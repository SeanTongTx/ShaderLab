
Shader "Lapis/Scene/LightMapOpaque"
{
	Properties
	{ 
		_Color("Color", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
		[NoScaleOffset]_LightMap("Light Map", 2D) = "black" {}
		[Toggle(ENABLE_LIGHTING)]FEATURE_LIGHTING("Enable lighting", Int) = 0
		[Toggle(ENABLE_VERTEX_COLOR)]FEATURE_VERTEX_COLOR("Enable vertex_color", Int) = 0
		_LightMapParams("LightMapParams",vector)=(0.3,0.5,0.5,0)
		/*Properties*/
	}
	
	SubShader
	{
		Tags { "RenderType" = "Opaque" "ForceNoShadowCasting" = "True" "Queue" = "Geometry"  }
		LOD 200
		Pass
		{
			
		    Tags { "LightMode" = "ForwardBase"  }
			Name "LightMap_Opaque"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			#pragma multi_compile _ SOURCE_MRT
			#pragma shader_feature_local ENABLE_LIGHTING
			#pragma shader_feature_local ENABLE_VERTEX_COLOR
			#include "UnityCG.cginc"
			//MRT/Core

			#include "../../Cgincs/MRTSupport.cginc"

			/*RenderSetup*/

			uniform float4 _Color;
			uniform fixed4 _LightColor0;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;

			uniform sampler2D _LightMap;
			uniform float4 _LightMap_ST;
			uniform fixed4 _LightMapParams;

			/*PassData*/
			struct appdata
			{
				fixed4 vertex : POSITION;
				fixed2 uv : TEXCOORD0;
				fixed2 uv1 : TEXCOORD1;
				fixed4 color : COLOR;
			};

			struct v2f
			{
				fixed4 vertex : SV_POSITION;
				fixed2 uv : TEXCOORD0;
				fixed2 uv1 : TEXCOORD1;
				UNITY_FOG_COORDS(2)
				fixed4 color : COLOR;
				/*vert2Frag*/
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv1 = TRANSFORM_TEX(v.uv1, _LightMap);
				UNITY_TRANSFER_FOG(o, o.vertex);
				o.color = v.color;
				/*vertCode*/
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				fixed4 MainCol = tex2D(_MainTex, i.uv);
				fixed4 lightMap = tex2D(_LightMap, i.uv1);

#if defined(UNITY_COLORSPACE_GAMMA)
#else
				_LightColor0.rgb = LinearToGammaSpace(_LightColor0.rgb);
#endif

				half Lumin = LinearRgbToLuminance(lightMap.rgb * _LightMapParams.z);

				half4 col = MainCol;
#ifdef ENABLE_LIGHTING
				col.rgb = max(0, (lightMap * _LightColor0 + lerp(_LightMapParams.x, _LightMapParams.y, Lumin)));
#else
				col.rgb = (lightMap + lerp(_LightMapParams.x, _LightMapParams.y, Lumin));
#endif

#ifdef ENABLE_VERTEX_COLOR
				col *= i.color;
#endif
#if defined(UNITY_COLORSPACE_GAMMA)
#else
				col.rgb = MainCol.rgb * GammaToLinearSpace(col.rgb) * _Color;
#endif
				UNITY_APPLY_FOG(i.fogCoord, col);
				/*fragCode*/

				FRAG_OUT_TYPE o;
				//MRT/Core
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col+1);
				return o;
			}
			ENDCG
		}
		/*Passes*/

	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" "ForceNoShadowCasting" = "True" "Queue" = "Geometry"  }
		Pass
		{
			
		    Tags { "LightMode" = "ForwardBase"  }
			Name "LightMap_Opaque_LOD100"
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

			/*PassData*/
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
			};
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				/*vert2Frag*/
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				/*vertCode*/
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : COLOR
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				col.rgb *= _LightColor0 * _Color;
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
	/*SubShader*/

}
