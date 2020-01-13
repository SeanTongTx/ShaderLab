// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Lapis/Scene/Non-lightmapCutout" 
{
	Properties 
	{
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
		[Toggle(ENABLE_LIGHTING)]FEATURE_LIGHTING("Enable lighting", Int) = 0
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "TransparentCutout"
			"Queue" = "AlphaTest"
			"IgnoreProjector" = "True"
			"ForceNoShadowCasting" = "True"
		}
		LOD 200
		Cull Off

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }
			Name "CutOut 200"

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

			/*PassData*/
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
				o.color.a = 1;
				UNITY_TRANSFER_FOG(o, o.pos);

				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv) * _Color;
				clip(col.a - _Cutoff);
#ifdef ENABLE_LIGHTING
				col *= i.color;
#endif
				UNITY_APPLY_FOG(i.fogCoord, col);

				/*fragCode*/
				FRAG_OUT_TYPE o;
				//MRT/Core
				SETUP_COLOR(o, col);
				//MRT/HDR
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
			"RenderType" = "TransparentCutout"
			"Queue" = "AlphaTest" 
			"IgnoreProjector"="True"
			"ForceNoShadowCasting" = "True"
		}
		Cull Off
		Lighting Off

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }
			Name "CutOut 100"

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile _ SOURCE_MRT
			#pragma shader_feature_local ENABLE_LIGHTING
			#include "UnityCG.cginc"
			//MRT/Core

			#include "../../Cgincs/MRTSupport.cginc"
			/*RenderSetup*/

			uniform float4 _Color;
			uniform fixed4 _LightColor0;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float _Cutoff;

			/*PassData*/
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
				clip(col.a - _Cutoff);

				/*fragCode*/
				FRAG_OUT_TYPE o;
				//MRT/Core
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);

				return o;
			}
			ENDCG
		}
	}
}
