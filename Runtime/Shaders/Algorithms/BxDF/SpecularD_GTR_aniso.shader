Shader "Hidden/Algorithms/BRDF/SpecularD_GTR_aniso"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ax("ax",range(0,1))=0.5
		_ay("ay",range(0,1)) = 0.5

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
#define PI 3.14156926

				float D_GTR2_aniso(float dotHX, float dotHY, float dotNH, float ax, float ay)
				{
					float deno = dotHX * dotHX / (ax * ax) + dotHY * dotHY / (ay * ay) + dotNH * dotNH;
					return 1.0 / (PI * ax * ay * deno * deno);

				}

				fixed4 frag(v2f i) : SV_Target
				{
					half4 col = tex2D(_MainTex,i.uv);
					//视线
					half3 view= normalize(UnityWorldSpaceViewDir(i.posWorld.xyz));
					//法线
					half3 normal = normalize(i.normal);

					half3 light = normalize(UnityWorldSpaceLightDir(i.posWorld.xyz));

					half3 h = normalize(view + light);

					half d = D_GTR2_aniso(dot(_ax, h), dot(_ay, h), dot(normal, h),_ax,_ay);

					return d;
				}
				ENDCG
			}
		}
}