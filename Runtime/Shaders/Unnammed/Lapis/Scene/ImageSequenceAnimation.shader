Shader "Lapis/Scene/ImageSequenceAnimation"
{
	Properties
	{
		_Color("Color Tint", Color) = (1,1,1,1)
		_MainTex("Image Sequence", 2D) = "white" {}
		_HorizonetalAmount("Horizontal Amount", Float) = 4
		_VerticalAmount("Vertical Amount", Float) = 3
		_Speed("Speed", Range(1,100)) = 30
		_BPM("BPM",Float) = 120
	}
		SubShader
		{
			Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
			LOD 100

			Pass
			{
				Tags { "LightMode" = "ForwardBase"}
				ZWrite Off
				Blend SrcAlpha OneMinusSrcAlpha

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

			//#pragma multi_compile_fog

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;

				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Speed;
			float _VerticalAmount;
			float _HorizonetalAmount;
			fixed4 _Color;
			float _BPM;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
			float time = floor(_Time.y * _Speed * _BPM / 60);
			float row = floor(time / _HorizonetalAmount);
			float column = time - row * _VerticalAmount;

			half2 uv = i.uv + half2(column, -row);
			uv.x /= _HorizonetalAmount;
			uv.y /= _VerticalAmount;



			// sample the texture
			fixed4 col = tex2D(_MainTex, uv);
			col.rgb *= _Color * _LightColor0;

			return col;
		}
		ENDCG
	}
		}
			//Fallback "Transparent/VertexLit"
}