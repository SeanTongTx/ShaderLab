// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Lapis/Scene/Non-lightmapOpaque"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		[Toggle(ENABLE_LIGHTING)]FEATURE_LIGHTING("Enable lighting", Int) = 0
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
			"Queue" = "Geometry"
			"IgnoreProjector" = "True"
			"ForceNoShadowCasting" = "True"
		}
		LOD 200
		Cull Back

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }
			Name "Opaque 200"

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#pragma multi_compile _ SOURCE_MRT
			#pragma shader_feature_local ENABLE_LIGHTING
			#include "UnityCG.cginc"
			#include "../../Cgincs/MRTSupport.cginc"

			uniform float4 _Color;
			uniform fixed4 _LightColor0;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float _Cutoff;

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 color : TEXCOORD1;
				UNITY_FOG_COORDS(2)
			};

			v2f vert(appdata v)
			{
				v2f o;

				half3 worldPos = mul(unity_ObjectToWorld, v.vertex);
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				float3 lightDir = UnityWorldSpaceLightDir(worldPos);
				half NdotL = max(dot(worldNormal, lightDir), 0.0);
				half3 lightColor = glstate_lightmodel_ambient.rgb;
				lightColor += min(NdotL * _LightColor0.rgb, 1.0);

				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color.rgb = lightColor;
				o.color.a = 1.0;
				UNITY_TRANSFER_FOG(o, o.pos);

				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv) * _Color;
#ifdef ENABLE_LIGHTING
				col *= i.color;
#endif
				UNITY_APPLY_FOG(i.fogCoord, col);

				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				SETUP_COLORHDR(o, col);
				return o;
			}
			ENDCG
		}
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
			"Queue" = "Geometry"
			"IgnoreProjector" = "True"
			"ForceNoShadowCasting" = "True"
		}
		Cull Back
		Lighting Off

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }
			Name "Opaque 100"

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile _ SOURCE_MRT
			#pragma shader_feature_local ENABLE_LIGHTING
			#include "UnityCG.cginc"

			#include "../../Cgincs/MRTSupport.cginc"

			uniform float4 _Color;
			uniform fixed4 _LightColor0;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float _Cutoff;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : COLOR
			{
				fixed4 col = tex2D(_MainTex, i.uv) * _Color;
#ifdef ENABLE_LIGHTING
				col.rgb *= _LightColor0.rgb;
#endif
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				SETUP_COLORHDR(o, col);

				return o;
			}
			ENDCG
		}
	}
}
