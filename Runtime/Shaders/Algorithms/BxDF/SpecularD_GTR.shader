Shader "Hidden/Algorithms/BRDF/SpecularD_GTR"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_a("a",range(0,1))=0.5

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
				float _a;
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
					/*法线
					o.normal = v.normal; break;
					o.normal = UnityObjectToWorldNormal(v.normal); break;
					o.normal = COMPUTE_VIEW_NORMAL; break;
					o.normal = v.normal; break;*/
					//顶点色
					//o.ScreenPos = ComputeScreenPos(o.vertex);
					/* 屏幕尺寸坐标
					float2 clipScreen = screenPos.xy*_ScreenParams.xy;
					

					//屏幕UV UV
					switch (_Space)
					{
						case 2:
							//normalize
							o.ScreenPos /= o.ScreenPos.w;
							//屏幕UV坐标 xy
							o.ScreenPos.xy = TRANSFORM_TEX(o.ScreenPos.xy, _MainTex);
							o.uv = o.ScreenPos.xy; break;
					}

					o.depth = COMPUTE_DEPTH_01;
					
					//视线
					switch (_Space)
					{
						case 0:o.view =normalize(ObjSpaceViewDir(v.vertex)); break;
						case 1:o.view =
							//WorldSpaceViewDir(v.vertex); break;
							normalize(UnityWorldSpaceViewDir(o.posWorld.xyz)); break;
						default:o.view = 1; break;
					}
					//light0
					switch (_Space)
					{
						case 0:o.light0Dir = ObjSpaceLightDir(v.vertex); break;
						case 1:o.light0Dir = WorldSpaceLightDir(v.vertex); break;
							//o.light0Dir = UnityWorldSpaceLightDir(o.posWorld.xyz); break;
						default:o.light0Dir = 1; break;
					}*/


					return o;
				}
#define PI 3.14156926
				float D_GTR1(float alpha, float dotNH)
				{
					float a2 = alpha * alpha;
					float cos2th = dotNH * dotNH;
					float den = (1.0 + (a2 - 1.0) * cos2th);

					return (a2 - 1.0) / (PI * log(a2) * den);
				}

				fixed4 frag(v2f i) : SV_Target
				{
					half4 col = tex2D(_MainTex,i.uv);
					half3 m= UnpackNormal(col);
					//视线
					half3 view= normalize(UnityWorldSpaceViewDir(i.posWorld.xyz));
					//法线
					half3 normal = normalize(i.normal);

					half3 light = normalize(UnityWorldSpaceLightDir(i.posWorld.xyz));

					half3 h = (view+light)*0.5;

					half d = D_GTR1(_a, dot(normal, h));

					return d;
				}
				ENDCG
			}
		}
}