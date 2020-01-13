Shader "Lapis/Scene/CutOut Pass + AlphaBlend Pass"
{
	Properties
	{
		_TintColor("Tint Color", Color) = (1.0,1.0,1.0,1.0)
		_MainTex("Particle Texture", 2D) = "white" {}
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.9
	}

	Category
	{
		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"PreviewType" = "Plane"
		}
		ColorMask RGB
		Cull Off Lighting Off 

		SubShader
		{
			Pass
			{
				ZWrite On

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 2.0
				#pragma multi_compile_particles

				#include "UnityCG.cginc"

				sampler2D _MainTex;
				fixed4 _TintColor;
				float _Cutoff;

				struct appdata_t
				{
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					float2 texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					fixed4 color : COLOR;
					float2 texcoord : TEXCOORD0;
					UNITY_VERTEX_OUTPUT_STEREO
				};

				float4 _MainTex_ST;

				v2f vert(appdata_t v)
				{
					v2f o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.color = v.color * _TintColor;
					o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					fixed4 col = i.color * tex2D(_MainTex, i.texcoord);
					
					clip(col.a - _Cutoff);

					return col;
				}
				ENDCG
			}

			Pass
			{
				Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
				ZTest LEqual
				ZWrite Off

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 2.0
				#pragma multi_compile_particles

				#include "UnityCG.cginc"

				sampler2D _MainTex;
				fixed4 _TintColor;
				float _Cutoff;

				struct appdata_t
				{
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					float2 texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					fixed4 color : COLOR;
					float2 texcoord : TEXCOORD0;
					UNITY_VERTEX_OUTPUT_STEREO
				};

				float4 _MainTex_ST;

				v2f vert(appdata_t v)
				{
					v2f o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.color = v.color * _TintColor;
					o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					fixed4 col = i.color * tex2D(_MainTex, i.texcoord);

					return col;
				}
				ENDCG
			}
		}
	}
}