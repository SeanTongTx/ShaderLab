Shader "Hidden/Algorithms/BRDF/Disney Principled BRDF"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("baseColor",color)=(0.82,0.67,0.16,1)
		_metallic("metallic",range(0,1))=0
		_subsurface("subsurface",range(0,1)) = 0
		_specular("specular ",range(0,1)) = 0.5
		_roughness("roughness ",range(0,1)) = 0.5
		_specularTint("specularTint",range(0,1)) = 0
		_anisotropic("anisotropic",range(0,1)) = 0
		_sheen("sheen ",range(0,1)) = 0
		_sheenTint("sheenTint  ",range(0,1)) = 0.5
		_clearcoat("clearcoat  ",range(0,1)) = 0
		_clearcoatGloss("clearcoatGloss  ",range(0,1)) =1
		_X("X",vector)=(1,1,1,1)
		_Y("Y",vector) = (1,1,1,1)
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
#define PI  3.14159265358979323846
		float4 _Color;
		float _metallic;
		float _subsurface;
		float _specular;
		float _roughness;
		float _specularTint;
		float _anisotropic;
		float _sheen;
		float _sheenTint;
		float _clearcoat;
		float _clearcoatGloss;
		float3 _X;
		float3 _Y;
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
				//Tool
				float sqr(float x) { return x * x; }

				//diffuse
				float3 Diffuse_Burley_Disney(float3 DiffuseColor, float Roughness, float NoV, float NoL, float VoH)
				{
					float FD90 = 0.5 + 2 * VoH * VoH * Roughness;
					float FdV = 1 + (FD90 - 1) * Pow5(1 - NoV);
					float FdL = 1 + (FD90 - 1) * Pow5(1 - NoL);
					return DiffuseColor * ((1 / PI) * FdV * FdL);
				}
				//specular D
				float D_GTR2_aniso(float dotHX, float dotHY, float dotNH, float ax, float ay)
				{
					float scaleX = sqr(dotHX);
					float scaleY = sqr(dotHY);
					float aspectX= sqr(ax);
					float aspectY = sqr(ay);
					float cos2th = sqr(dotNH);
					float deno = scaleX / aspectX + scaleY / aspectY + cos2th;
					return 1.0 / (PI * ax * ay * deno * deno);

				}
				float D_GTR2(float alpha, float dotNH)
				{
					float a2 = alpha * alpha;
					float cos2th = dotNH * dotNH;
					float den = (1.0 + (a2 - 1.0) * cos2th);

					return a2 / (PI * den * den);
				}
				float SchlickFresnel(float u)
				{
					float m = clamp(1 - u, 0, 1);
					float m2 = m * m;
					return m2 * m2*m; // pow(m,5)
				}

				// Smith GGX G项，各项同性版本
				float smithG_GGX(float NdotV, float alphaG)
				{
					float a = alphaG * alphaG;
					float b = NdotV * NdotV;
					return 1 / (NdotV + sqrt(a + b - a * b));
				}

				fixed4 frag(v2f i) : SV_Target
				{
					//视线
					half3 V= normalize(UnityWorldSpaceViewDir(i.posWorld.xyz));
					//法线
					half3 N = normalize(i.normal);

					half3 L = normalize(UnityWorldSpaceLightDir(i.posWorld.xyz));

					half3 H = normalize(V +L);

					float NdotL = dot(N, L);
					float NdotV = dot(N, V);
					float NdotH = dot(N, H);
					float LdotH = dot(L, H);
					float VdotH = dot(V, H);
					//漫反射项 diffuse
					float3 diffuse = Diffuse_Burley_Disney(_Color.rgb, _roughness, NdotV, NdotL, VdotH);
					//反射项
					float aspect = sqrt(1 - _anisotropic * .9);
					float ax = max(.001, sqr(_roughness) / aspect);
					float ay = max(.001, sqr(_roughness)*aspect);

					//half D = D_GTR2_aniso(dot(_X, H), dot(_Y, H),NdotH, ax, ay);

					//NDF 法线分布项
					float D = D_GTR2(ax, NdotH);
					//F 菲涅尔项
					
					float FV = SchlickFresnel(NdotV);
					float FL =SchlickFresnel(NdotL);
					float Fd90 = 0.5 + 2 * LdotH*LdotH * _roughness;
					float Fd = lerp(1.0, Fd90, FL) * lerp(1.0, Fd90, FV);

					half G = smithG_GGX(NdotV, ax);

					return half4(diffuse+ D*Fd*G, 1);
				}
				ENDCG
			}
		}
}