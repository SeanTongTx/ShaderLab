Shader "Hidden/Algorithms/BRDF/Diffuse_Burley_Disney"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Roughness("Roughness",float)=1

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
				float _Roughness;
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
#define PI 3.1415926
				// [Burley 2012, "Physically-Based Shading at Disney"]
				float3 Diffuse_Burley_Disney(float3 DiffuseColor, float Roughness, float NoV, float NoL, float VoH)
				{
					float FD90 = 0.5 + 2 * VoH * VoH * Roughness;
					float FdV = 1 + (FD90 - 1) * Pow5(1 - NoV);
					float FdL = 1 + (FD90 - 1) * Pow5(1 - NoL);
					return DiffuseColor * ((1 / PI) * FdV * FdL);
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

					float3 diffuse = Diffuse_Burley_Disney(col.rgb, _Roughness, dot(normal, view), dot(normal, light), dot(view, h));

					return half4(diffuse,1);
				}
				ENDCG
			}
		}
}