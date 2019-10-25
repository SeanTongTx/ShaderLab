Shader "Hidden/Algorithms/BRDF/SpecularG_Smith-GGX_aniso"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ax("_ax",float)=1
		_ay("_ay",float) = 1

	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			LOD 100
			cull off
			Pass
			{
				Tags{"LightMode" = "ForwardBase" }
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

#include "UnityStandardBRDF.cginc"
				
				struct appdata
				{
					float4 vertex : POSITION;
					fixed3 normal : NORMAL;
					half2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
					fixed3 normal : NORMAL;
					float4 posObj : TEXCOORD1;
					float4 posWorld : TEXCOORD2;
				};

				sampler2D _MainTex; 
				float4 _MainTex_ST;
				float _ax;
				float _ay;
				v2f vert(appdata v)
				{
					v2f o;
					o.posObj = v.vertex;
					//ClipPos
					o.vertex = UnityObjectToClipPos(v.vertex);
					//worldPos
					o.posWorld = mul(unity_ObjectToWorld, v.vertex);
					//uv
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					o.normal = UnityObjectToWorldNormal(v.normal);

					return o;
				}
				// Smith GGX G项，各项异性版本
				// Derived G function for GGX
				float smithG_GGX_aniso(float dotVN, float dotVX, float dotVY, float ax, float ay)
				{
					return 1.0 / (dotVN + sqrt(pow(dotVX * ax, 2.0) + pow(dotVY * ay, 2.0) + pow(dotVN, 2.0)));
				}

				fixed4 frag(v2f i) : SV_Target
				{
					//视线
					half3 view= normalize(UnityWorldSpaceViewDir(i.posWorld.xyz));
					//法线
					half3 normal = normalize(i.normal);

					half3 light = normalize(UnityWorldSpaceLightDir(i.posWorld.xyz));

					half3 h = (view+light)*0.5;

					half sg = smithG_GGX_aniso(dot(normal, view), dot(view,_ax),dot(view,_ay),_ax,_ay);

					return sg;
				}
				ENDCG
			}
		}
}