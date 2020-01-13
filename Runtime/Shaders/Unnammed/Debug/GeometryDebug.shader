Shader "Hidden/Debug/Geometry Debug"
{
	Properties
	{
		[KeywordEnum(VertexNormal,WorldNormal,ViewNormal,TexCoord0,TexCoord1,VertexColor,NDotL,NDotV)] _DebugType("Debug Type", Int) = 0
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" "LightMode" = "ForwardBase" }
		LOD 100

		Pass
		{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 color : COLOR;
				float2 texcoord0 : TEXCOORD0;
				float2 texcoord1 : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 value : TEXCOORD0;
			};

			int _DebugType;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.value = 0;

				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);

				switch (_DebugType)
				{
					case 0:
						o.value = float4(v.normal, 1);
						break;
					case 1:
						o.value = float4(worldNormal, 1);
						break;
					case 2:
						o.value = float4(mul((float3x3)unity_MatrixMV, v.normal), 1);
						break;
					case 3:
						o.value = float4(v.texcoord0, 0, 0);
						break;
					case 4:
						o.value = float4(v.texcoord1, 0, 0);
						break;
					case 5:
						o.value = v.color;
						break;
					case 6:
						o.value = dot(worldNormal, UnityWorldSpaceLightDir(worldPos));
						break;
					case 7:
						o.value = dot(worldNormal, UnityWorldSpaceViewDir(worldPos));
						break;
				}

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return i.value;
			}
			ENDCG
		}
	}
}
