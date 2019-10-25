Shader "ShaderLab/Debug"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_CubeMap("CubeMap",CUBE) = ""{}
		[MaterialToggle]_UV1("UV1" , float) = 0
		[KeywordEnum(texture,vertColor,normal,depth,eye,light0,uv)] _Datas("Datas", Float) = 0
		[KeywordEnum(object,world,screen)] _Space("Space", Float) = 0
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

				struct appdata
				{
					float4 vertex : POSITION;
					half4 color : COLOR;
					fixed3 normal : NORMAL;
					half4 tangent : TANGENT;
					half2 uv : TEXCOORD0;
					half2 uv1 : TEXCOORD1;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
					float4 color : COLOR;
					fixed3 normal : NORMAL;
					float4 ScreenPos : TEXCOORD1;
					float depth : TEXCOORD2;
					float3 view : TEXCOORD3;
					float4 posWorld : TEXCOORD4;
					float3 light0Dir : TEXCOORD5;
					float4 posObj:TEXCOORD6;
				};

				uniform float _Datas;
				uniform float _Space;
				uniform fixed _UV1;


				sampler2D _MainTex; 
				float4 _MainTex_ST;
				samplerCUBE _CubeMap;

				v2f vert(appdata v)
				{
					v2f o;
					o.posObj = v.vertex;
					//ClipPos
					o.vertex = UnityObjectToClipPos(v.vertex);
					//worldPos
					o.posWorld = mul(unity_ObjectToWorld, v.vertex);
					//uv
					if (_UV1 > 0)
					{
						o.uv = TRANSFORM_TEX(v.uv1, _MainTex);
					}
					else
					{
						o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					}

					//发现
					switch (_Space)
					{
						case 0:o.normal = v.normal; break;
						case 1:o.normal = UnityObjectToWorldNormal(v.normal); break;
						case 2:o.normal = COMPUTE_VIEW_NORMAL; break;
						default:
							o.normal = v.normal; break;
					}
					//顶点色
					o.color = v.color;
					o.ScreenPos = ComputeScreenPos(o.vertex);
					/* 屏幕尺寸坐标
					float2 clipScreen = screenPos.xy*_ScreenParams.xy;
					*/

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
					}


					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					// sample the texture
					switch (_Datas)
					{
						case 0:
						{
							switch (_Space)
							{
								case 0:
								case 1:
									fixed4 col = tex2D(_MainTex, i.uv);
									return col;
								case 2:
									half4 screenPos = i.ScreenPos;
									fixed4 col1 = tex2D(_MainTex, screenPos.xy);
									return col1;
							}
						}break;
						case 1:return i.color;
						case 2:return half4(i.normal, 1);
						case 3:return i.depth;
						case 4:return half4(i.view,1);
						case 5:return half4(i.light0Dir, 1);
						case 6:return half4(i.uv, 0,1);
					}
					return 1;
				}
				ENDCG
			}
		}
}
