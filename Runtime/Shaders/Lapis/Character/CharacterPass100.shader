
Shader "Hidden/ShaderLab/Lapis/CharacterPass100"
{
	CGINCLUDE
	#include "UnityCG.cginc"
	#include "../../Cgincs/HSLSupport.cginc"
	#include "../../Cgincs/MaterialFX.cginc"
	#include "../../Cgincs/MRTSupport.cginc"
	#pragma multi_compile _ SOURCE_MRT
	struct appdata
	{
		float4 vertex : POSITION;
		fixed2 uv : TEXCOORD0;
	};

	struct v2f
	{
		float4 vertex : SV_POSITION;
		fixed2 uv : TEXCOORD0;
	};
	/*RenderSetup*/
	uniform sampler2D _MainTex;
	uniform float4 _MainTex_ST;

	ENDCG
	SubShader
	{
		Tags { "RenderType" = "Opaque"}
		Pass
		{
			Tags{ "LightMode" = "Vertex" }
			Name "Skin_LOD100"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				col*= (unity_LightColor[0]);
				col.a = 1;
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);
				return o;
			}
			ENDCG
		}
		Pass
		{
			Tags{ "LightMode" = "Vertex" }
			Name "Face_LOD100"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			uniform fixed4 _CheekColor;
            uniform float _CheekPower;
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				
				col*= (unity_LightColor[0]);

				
				col.a = 1;
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);
				return o;
			}
			ENDCG
		}
		Pass
		{  
			Tags{ "LightMode" = "Vertex" }
			Name "Eye_LOD100"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				
				return o;
			}
			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= (unity_LightColor[0]);
				col.a = 1;
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);
				return o;
			}
			ENDCG
		}	
		Pass
		{  
			Tags{ "LightMode" = "Vertex" }
			Name "Brow_LOD100"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				
				return o;
			}
			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= (unity_LightColor[0]);
				col.a = 1;
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);
				return o;
			}
			ENDCG
		}
	}
}
