Shader "Lapis/PBR/Standard Anisotropic"
{
    Properties
    {
		_Color("Color", Color) = (1,1,1,1)
        _MainTex ("Main Texture", 2D) = "white" {}
		_ShadeTex("Shade Texture", 2D) = "white" {}
		_RampTex("Ramp Texture", 2D) = "white" {}
		_FeatureTex("Feature (R:metallic, G:emission, B:anisotropic, A:smoothness", 2D) = "white" {}
		//[Toggle(ENABLE_JITTER)]FEATURE_JITTER("Enable Jitter Map", Float) = 0
		//_JitterShift ("Jitter Shift", Range(-1, 1)) = 0
		//_JitterTex("Jitter Texture", 2D) = "black" {}
		_Glossiness("Smoothness ", Range(0, 1)) = 0.0
		[Gamma]_Metallic("Metallic", Range(0, 1)) = 0.0
		[Gamma]_Anisotropic("Anisotropic", Range(0, 1)) = 0.0
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
			//#pragma shader_feature_local ENABLE_JITTER
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
			#include "Cgincs/BRDF.cginc"
			//#include "../../Cgincs/InsideLine.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
				float4 color : COLOR;
                float3 normal : NORMAL;
				float3 tangent : TANGENT;
				float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
				float4 color : TEXCOORD1;
				float3 position : TEXCOORD2;
				float3 light : TEXCOORD3;
				float3 normal : TEXCOORD4;
				float3 tangent : TEXCOORD5;
				float3 binormal :TEXCOORD6;
				float3 halfdir : TEXCOORD7;
				float3 reflect : TEXCOORD8;
				float3 ndvndl : TEXCOORD9;
				float3 view : TEXCOORD10;
            };

			fixed4 _Color;
			fixed4 _LightColor0;
            sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _ShadeTex;
			sampler2D _RampTex;
			sampler2D _FeatureTex;
//#ifdef ENABLE_JITTER
//			float _JitterShift;
//			sampler2D _JitterTex;
//#endif
			fixed _Glossiness;
			fixed _Metallic;
			fixed _Anisotropic;
			fixed4 _Emission;

			fixed _LightRadiance;

			inline float3 JitterTangent(float3 T, float3 N, float shift)
			{
				half3 shiftedT = T + shift * N;
				return normalize(shiftedT);
			}

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color;
				o.position = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.view = normalize(UnityWorldSpaceViewDir(o.position));
				o.light = normalize(UnityWorldSpaceLightDir(o.position));
				o.normal = normalize(UnityObjectToWorldNormal(v.normal));
				o.halfdir = o.view + o.light;
				o.reflect = reflect(-o.view, o.normal);
				o.ndvndl = float3(dot(o.normal, o.view), dot(o.normal, o.light), dot(o.normal, o.light) * 0.5 + 0.5);
				o.tangent = normalize(UnityObjectToWorldDir(v.tangent));
				o.binormal = cross(o.normal, o.tangent);

                return o;
            }

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 albedo = tex2D(_MainTex, i.uv) * _Color;
				//clip(albedo.a - 0.5);
				fixed4 feature = tex2D(_FeatureTex, i.uv);
				fixed4 shade = tex2D(_ShadeTex, i.uv);

				float smoothness = feature.a * _Glossiness;
				float metallic = feature.r * _Metallic;
				float emmision = feature.g;
				float anisotropic = feature.b * _Anisotropic;

				float3 L = i.light;
				float3 R = i.reflect;

				float3 V = normalize(i.view);
				float3 N = normalize(i.normal);
				float3 H = normalize(i.halfdir);

				float3 X = normalize(i.tangent);
				float3 Y = normalize(i.binormal);
				//#ifdef ENABLE_JITTER
				//float shift = tex2D(_JitterTex, i.uv) - 0.5;
				//Y = JitterTangent(Y, N, shift + _JitterShift);
				//#endif
				half NdotV = abs(i.ndvndl.x);
				half NdotL = saturate(i.ndvndl.y);

				half NdotH = saturate(dot(N, H));
				half LdotH = saturate(dot(L, H));

				half XdotH = dot(X, H);
				half YdotH = dot(Y, H);
				half XdotL = dot(X, L);
				half YdotL = dot(Y, L);
				half XdotV = dot(X, V);
				half YdotV = dot(Y, V);

				float perceptualRoughness = (1.0 - smoothness);
				float roughness = perceptualRoughness * perceptualRoughness;

				half ramp = tex2D(_RampTex, float2(i.ndvndl.z, 0.5));
				//
				half3 specColor = lerp(unity_ColorSpaceDielectricSpec.rgb, albedo, metallic);
				half oneMinusDielectricSpec = unity_ColorSpaceDielectricSpec.a;
				half oneMinusReflectivity = oneMinusDielectricSpec - metallic * oneMinusDielectricSpec;
				half3 diffColor = albedo * oneMinusReflectivity;

				//
				roughness = max(roughness, 0.002);
				float G = G_SmithJointGGXAniso(anisotropic, roughness, XdotV, YdotV, NdotV, XdotL, YdotL, NdotL);
				float D = D_GGX_Aniso(anisotropic, roughness, NdotH, XdotH, YdotH);

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
