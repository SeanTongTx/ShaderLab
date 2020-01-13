Shader "Lapis/Character/Eye"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_RotAng("Rotate Angle", Range(-1.04, 1.04)) = 0
		_LightRadiance("Light Radiance", Range(0.0, 1.0)) = 1.0
	}
	SubShader
	{
		Tags { "RenderType" = "TransparentCutout" "Queue" = "AlphaTest" }
		LOD 100

		Pass //Base
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 color : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _ShadeTex;

			fixed _RotAng;
			fixed4 _LightColor0;

			float _LightRadiance;

			fixed2 uv_rotate(fixed2 uv, fixed angle)
			{
				uv = uv - fixed2(0.5, 0.5);
				fixed2 ret_uv;
				ret_uv.x = uv.x * cos(angle) - uv.y * sin(angle) + 0.5;
				ret_uv.y = uv.x * sin(angle) + uv.y * cos(angle) + 0.5;
				return ret_uv;
			}

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed2 rotated_uv = uv_rotate(i.uv, _RotAng);
				fixed highlight = tex2D(_MainTex, rotated_uv).a;
				clip((1.0 - i.color.r) + highlight - 0.5);

				fixed4 color = tex2D(_MainTex, i.uv);
				color = lerp(color, fixed4(1,1,1,0), any(i.color.r)) * _LightColor0 * _LightRadiance;
				color.a = 0.0;
				return color;
			}
			ENDCG
		}
	}
}
