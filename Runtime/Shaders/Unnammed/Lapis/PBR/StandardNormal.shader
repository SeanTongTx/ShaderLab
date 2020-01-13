Shader "Lapis/PBR/Standard Normal"
{
    Properties
    {
		_Color("Color", Color) = (1,1,1,1)
        _MainTex ("Main Texture", 2D) = "white" {}
		_ShadeTex("Shade Texture", 2D) = "white" {}
		_RampTex("Ramp Texture", 2D) = "white" {}
		_FeatureTex("Feature (R:metallic, G:emission, B:scale, A:smoothness", 2D) = "white" {}
		[Normal] _NormalTex("Normal Map", 2D) = "bump" {}
		[Gamma] _Scale("Scale", Range(0,1)) = 1.0
		_Glossiness("Smoothness ", Range(0,1)) = 0.0
		[Gamma]_Metallic("Metallic", Range(0, 1)) = 0.0
		[HDR]_Emission("Emission", Color) = (0,0,0,0)

		_LightRadiance("Light Radiance", Range(0.0, 1.0)) = 1.0

		_Outline("Outline", float) = 1.2
		//[Toggle(ENABLE_INSIDELINE)] FEATUREE_INSIDELINE("Enable Insideline", Float) = 0
		//_OutlineInside("OutlineInside", float) = 0.02
		_OutlineColor("OutlineColor", Color) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 400

        Pass
        {
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

            CGPROGRAM
			//#pragma shader_feature_local ENABLE_INSIDELINE

			#pragma multi_compile _ PIXELLIGHT1 
			#pragma multi_compile _ PIXELLIGHT2

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
			#include "Cgincs/BRDF.cginc"
			#include "../../Cgincs/CustomLight.cginc"
			//#include "../../Cgincs/InsideLine.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
				float4 color : COLOR;
                float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
				float4 color : TEXCOORD1;
				float4 tangentToWorld[3] : TEXCOORD2;
				float3 view : TEXCOORD5;
				float3 light : TEXCOORD6;
				float3 halfdir : TEXCOORD7;
            };

			fixed4 _Color;
			fixed4 _LightColor0;
            sampler2D _MainTex;
			sampler2D _ShadeTex;
			sampler2D _RampTex;
			sampler2D _FeatureTex;
			sampler2D _NormalTex;
            float4 _MainTex_ST;

			fixed _Scale;
			fixed _Glossiness;
			fixed _Metallic;
			fixed4 _Emission;

			fixed _LightRadiance;

			half3x3 CreateTangentToWorld(half3 normal, half3 tangent, half tangentSign)
			{
				// For odd-negative scale transforms we need to flip the sign
				half sign = tangentSign * unity_WorldTransformParams.w;
				half3 binormal = cross(normal, tangent) * sign;
				return half3x3(tangent, binormal, normal);
			}

			float3 PerPixelWorldNormal(float2 texcoord, float4 tangentToWorld[3], half scale)
			{
				half3 tangent = tangentToWorld[0].xyz;
				half3 binormal = tangentToWorld[1].xyz;
				half3 normal = tangentToWorld[2].xyz;

#if UNITY_TANGENT_ORTHONORMALIZE
				normal = normalize(normal);

				// ortho-normalize Tangent
				tangent = normalize(tangent - normal * dot(tangent, normal));

				// recalculate Binormal
				half3 newB = cross(normal, tangent);
				binormal = newB * sign(dot(newB, binormal));
#endif
				half3 normalTangent = UnpackNormalWithScale(tex2D(_NormalTex, texcoord), scale);//NormalInTangentSpace(uv);
				float3 normalWorld = normalize(tangent * normalTangent.x + binormal * normalTangent.y + normal * normalTangent.z); // @TODO: see if we can squeeze this normalize on SM2.0 as well

				return normalWorld;
			}

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color;

				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				float4 worldTangent = float4(UnityObjectToWorldDir(v.tangent.xyz), v.tangent.w);

				half3x3 tangentToWorld = CreateTangentToWorld(worldNormal, worldTangent.xyz, worldTangent.w);
				o.tangentToWorld[0].xyz = tangentToWorld[0];
				o.tangentToWorld[1].xyz = tangentToWorld[1];
				o.tangentToWorld[2].xyz = tangentToWorld[2];

				float4 worldPosition = mul(unity_ObjectToWorld, v.vertex);

				o.tangentToWorld[0].w = worldPosition.x;
				o.tangentToWorld[1].w = worldPosition.y;
				o.tangentToWorld[2].w = worldPosition.z;

				o.view = normalize(UnityWorldSpaceViewDir(worldPosition.xyz));
				o.light = normalize(UnityWorldSpaceLightDir(worldPosition.xyz));
				o.halfdir = o.view + o.light;

                return o;
            }

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 albedo = tex2D(_MainTex, i.uv) * _Color;
				//clip(albedo.a - 0.5);
				fixed4 feature = tex2D(_FeatureTex, i.uv);
				fixed4 shade = tex2D(_ShadeTex, i.uv);
				fixed4 normal = tex2D(_NormalTex, i.uv);

				float metallic = feature.r * _Metallic;
				float emmision = feature.g;
				float scale = feature.b * _Scale;
				float smoothness = feature.a * _Glossiness;

				float3 L = i.light;

				float3 N = PerPixelWorldNormal(i.uv, i.tangentToWorld, scale);
				float3 H = normalize(i.halfdir);
				float3 V = normalize(i.view);

				float3 R = reflect(-V, N);

				half NdotV = abs(dot(N, V));//abs(i.ndvndl.x);
				half NdotL = saturate(dot(N, L));//saturate(i.ndvndl.y);

				half NdotH = saturate(dot(N, H));
				half LdotH = saturate(dot(L, H));

				float3 X = normalize(i.tangentToWorld[0]);
				float3 Y = normalize(i.tangentToWorld[1]);

				half HdotX = dot(H, X);
				half HdotY = dot(H, Y);
				half LdotX = dot(L, X);
				half LdotY = dot(L, Y);

				float perceptualRoughness = (1.0 - smoothness);
				float roughness = perceptualRoughness * perceptualRoughness;

				half ramp = tex2D(_RampTex, float2(dot(N, L) * 0.5 + 0.5, 0.5));//tex2D(_RampTex, float2(i.ndvndl.z, 0.5));
				//
				half3 specColor = lerp(unity_ColorSpaceDielectricSpec.rgb, albedo, metallic);
				half oneMinusDielectricSpec = unity_ColorSpaceDielectricSpec.a;
				half oneMinusReflectivity = oneMinusDielectricSpec - metallic * oneMinusDielectricSpec;
				half3 diffColor = albedo * oneMinusReflectivity;

				//
				roughness = max(roughness, 0.002);
				float G = SmithJointGGXVisibilityTerm(NdotL, NdotV, roughness);
				float D = GGXTerm(NdotH, roughness);

				float specularTerm = G * D * UNITY_PI;
				specularTerm = max(0, specularTerm * NdotL);
				specularTerm *= any(specColor) ? 1.0 : 0.0;

				half surfaceReduction;
				surfaceReduction = 1.0 / (roughness * roughness + 1.0);           // fade \in [0.5;1]
				half grazingTerm = saturate(smoothness + (1 - oneMinusReflectivity));

				half mip = perceptualRoughness * (1.7 - 0.7 * perceptualRoughness) * 6.0;
				fixed3 reflectColor = DecodeHDR(UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, R, mip), unity_SpecCube0_HDR);

				float3 diffuseTerm = lerp(diffColor * shade, diffColor, min(ramp, shade.a));

				float3 color = diffColor * UNITY_LIGHTMODEL_AMBIENT 
					+ (diffuseTerm
					+ specularTerm * FresnelTerm(specColor, LdotH)) * _LightColor0.rgb * _LightRadiance
					+ surfaceReduction * reflectColor * FresnelLerp(specColor, grazingTerm, NdotV)
					+ emmision * _Emission * albedo;

				//color.rgb = ApplyOutline(color.rgb, i.color.b);

#if PIXELLIGHT1
				color += LAMBERT_LIGHT1(N, float3(i.tangentToWorld[0].w, i.tangentToWorld[1].w, i.tangentToWorld[2].w));
#endif
#if PIXELLIGHT2
				color += LAMBERT_LIGHT2(N, float3(i.tangentToWorld[0].w, i.tangentToWorld[1].w, i.tangentToWorld[2].w));
#endif
				return float4(color, 0);
            }
            ENDCG
        }

		Pass//Outline
		{
			Name "OUTLINE"
			Tags { "LightMode" = "ForwardBase" }

			Cull Front

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#include "../../Cgincs/Outline.cginc"
			ENDCG
		}
    }
}
