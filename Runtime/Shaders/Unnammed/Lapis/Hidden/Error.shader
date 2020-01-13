Shader "Hidden/Lapis/Error"
{
	SubShader
	{
		Pass
		{
		cull off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#pragma multi_compile _ UNITY_SINGLE_PASS_STEREO STEREO_INSTANCING_ON STEREO_MULTIVIEW_ON
			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float2 uv:TEXCOORD0;
				float2 uv1:TEXCOORD1;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
					float2 uv:TEXCOORD0;
				float2 uv1:TEXCOORD1;
					float4 ScreenPos : TEXCOORD2;

			};

			sampler2D _ErrorTex;
			float4 _ErrorTex_ST;
			sampler2D _ErrorTex1;
			float4 _ErrorTex1_ST;
			v2f vert(appdata_t v)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _ErrorTex);
				o.uv1 = TRANSFORM_TEX(v.uv1, _ErrorTex1);
				o.ScreenPos = ComputeScreenPos(o.vertex);
				return o;
			}
			fixed4 frag(v2f i) : SV_Target
			{

				i.ScreenPos /= i.ScreenPos.w;
i.ScreenPos*=6;
				fixed4 col = tex2D(_ErrorTex, i.ScreenPos.xy + half2(_Time.y,0));
				fixed4 col1 = tex2D(_ErrorTex1	,i.ScreenPos.xy + half2(-_Time.y, 0));
				return lerp(col,col1,col1.a);
//return fixed4(1,0,1,1);
			}
			ENDCG
		}
	}
		Fallback Off
}
