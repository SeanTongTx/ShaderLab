Shader "Lapis/Character/Hair"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		[NoScaleOffset] _RampTex("Ramp Texture", 2D) = "white" {}
		[NoScaleOffset] _ShadeTex("Shade Texture", 2D) = "white" {}
		[NoScaleOffset] _SpecularTex("Specular Texture", 2D) = "black" {}

		_SpecularIntensity("Specular Intensity", Range(0.0, 10.0)) = 0.1
		_SpecularWidth("Specular Width", Range(0.0, 10.0)) = 2.0

		_LightRadiance("Light Radiance", Range(0.0, 1.0)) = 1.0

		_Outline("Outline", float) = 1.2
		_OutlineInside("OutlineInside", float) = 0.02
		_OutlineColor("OutlineColor", Color) = (0,0,0,0)
	}

	SubShader//LOD400
	{
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 300

		Pass//Base
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma multi_compile _ PIXELLIGHT1 
			#pragma multi_compile _ PIXELLIGHT2
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "../../Cgincs/CelShading.cginc"
			#include "../../Cgincs/CustomLight.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
				fixed2 uv : TEXCOORD0;
				fixed nl : TEXCOORD1;
				fixed nv : TEXCOORD2;
				fixed rv : TEXCOORD3;
				fixed3 position : TEXCOORD4;
				fixed3 normal : NORMAL;
			};

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform sampler2D _ShadeTex;
			uniform sampler2D _SpecularTex;
			uniform float _SpecularIntensity;
			uniform float _SpecularWidth;
			uniform fixed4 _LightColor0;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;

				half3 normal = UnityObjectToWorldNormal(v.normal);
				half3 worldPos = mul(unity_ObjectToWorld, v.vertex);
				half3 lightDir = FixableWorldSpaceLightDir(worldPos);
				half3 viewDir = normalize(UnityWorldSpaceViewDir(worldPos));

				o.nl = dot(normal, lightDir);
				o.nv = dot(normal, viewDir);
				o.normal = normal;
				o.position = worldPos;
				// highLight
				// ==========================================
				fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
				fixed3 reflectDir = normalize(reflect(-worldLightDir, normal));
				fixed3 verticalDir = normal - viewDir;
				fixed verticalPower = abs(verticalDir.x);
				o.rv = saturate((dot(reflectDir, viewDir) - verticalPower * _SpecularWidth));
				// ==========================================

				o.color = v.color;
				o.color.a = 0;

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2Dbias(_MainTex, float4(i.uv, 0, -0.5));
				col = ApplyOutline(col, i.color.b);

				fixed4 shadow = tex2D(_ShadeTex, i.uv);

				col = CelShading(i.nl, col, shadow, _LightColor0);

				// Specular
				fixed4 specularTex = tex2D(_SpecularTex, i.uv);
				fixed specular = specularTex.r * pow(i.rv, max(0.02, _SpecularIntensity));
				col = col + fixed4(specular, specular, specular, 0) * 0.3;
				col.a = 0;

#if PIXELLIGHT1
				col.rgb += LAMBERT_LIGHT1(i.normal, i.position);
#endif
#if PIXELLIGHT2
				col.rgb += LAMBERT_LIGHT2(i.normal, i.position);
#endif
				return col;
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

	Fallback "Lapis/Unlit/Texture"
}
