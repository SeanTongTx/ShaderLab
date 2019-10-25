
Shader "Hidden/ShaderLab/Lapis/CharacterPass200"
{
	CGINCLUDE
	#include "UnityCG.cginc"
	#include "../../Cgincs/HSLSupport.cginc"
	#include "../../Cgincs/MRTSupport.cginc"
	#pragma multi_compile _ SOURCE_MRT
	struct appdata
	{
		float4 vertex : POSITION;
		fixed2 uv : TEXCOORD0;
		//法线
		fixed3 normal : NORMAL;
	};

	struct v2f
	{
		float4 vertex : SV_POSITION;
		fixed2 uv : TEXCOORD0;
		//主光源信息
		fixed nl : TEXCOORD1;
	};
	/*RenderSetup*/
	uniform sampler2D _MainTex;
	uniform float4 _MainTex_ST;
	uniform sampler2D _Ramp;
	ENDCG
	SubShader
	{
		Tags { "RenderType" = "Opaque"}
		Pass
		{
			Tags{ "LightMode" = "Vertex" }
			Name "Skin_LOD200"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//法线
				half3 normal = UnityObjectToWorldNormal(v.normal);
				//世界坐标
				half3 posWorld = mul(unity_ObjectToWorld, v.vertex);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(posWorld.xyz);
				o.nl = dot(normal, lightDir)*0.5 + 0.5;
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 ramp = tex2D(_Ramp, fixed2(i.nl,0))*0.3 + 0.7;
				col*= (unity_LightColor[0])*ramp;
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
			Name "Face_LOD200"
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
				//法线
				half3 normal = UnityObjectToWorldNormal(v.normal);
				//世界坐标
				half3 posWorld = mul(unity_ObjectToWorld, v.vertex);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(posWorld.xyz);
				o.nl = dot(normal, lightDir)*0.5 + 0.5;
				return o;
			}
			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed3 cheek = 0;
				cheek = (1 - col.a)*_CheekPower;
				col.rgb= lerp(col.rgb, _CheekColor.rgb, cheek);
				fixed4 ramp = tex2D(_Ramp, fixed2(i.nl,0))*0.3 + 0.7;
				col*= (unity_LightColor[0])*ramp;
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
