
Shader "ShaderLab/Lapis/Scene/LightMapOpaque"
{
	Properties
	{ 
		_Color("Color", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
		[NoScaleOffset]_LightMap("Light Map", 2D) = "black" {}
		_LightMapParams("LightMapParams",vector)=(0.3,0.5,0.5,0)
		/*Properties*/
	}
	
	SubShader
	{
		Tags { "RenderType" = "Opaque" "ForceNoShadowCasting" = "True" "Queue" = "Geometry"  }
		LOD 200
		Pass
		{
			
		    Tags { "LightMode" = "Vertex"  }
			Name "LightMap_Opaque"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			#pragma multi_compile _ SOURCE_MRT
			#include "UnityCG.cginc"
			//MRT/Core

			#include "../../Cgincs/MRTSupport.cginc"

			/*RenderSetup*/

			uniform float4 _Color;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;

			uniform sampler2D _LightMap;
			uniform float4 _LightMap_ST;
			uniform fixed4 _LightMapParams;
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
				float2 uv1 : TEXCOORD1;
				float4 color : TEXCOORD2;
				UNITY_FOG_COORDS(3)
				/*vert2Frag*/
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv1 = TRANSFORM_TEX(v.uv1, _LightMap);
				o.color = unity_LightColor[0];
				UNITY_TRANSFER_FOG(o, o.vertex);
				/*vertCode*/
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : COLOR
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 lightMap = tex2D(_LightMap, i.uv1);
				half Lumin = Luminance(lightMap.rgb*_LightMapParams.z);
				col.rgb = col * (lightMap + lerp(_LightMapParams.x, _LightMapParams.y, Lumin))*_Color *i.color;
				// apply fog
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
			
		    Tags { "LightMode" = "Vertex"  }
			Name "LightMap_Opaque_LOD100"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			//MRT/Core

			#include "../../Cgincs/MRTSupport.cginc"

			/*RenderSetup*/

			uniform float4 _Color;
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
				col.rgb *= unity_LightColor[0]*_Color;
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
