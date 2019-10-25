Shader "SeanLib/MaterialFX/Orgin"
{
	Properties
	{
		[MaterialToggle] _IsOldModel("Old Model", Float) = 0
		_Outline("Outline",float) = 1
		_OutlineColor("OutlineColor", Color) = (0,0,0,0)
		_Ramp("Ramp", 2D) = "white" {}
		_RampTex("RampTex", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_MainRampTex("MainRampTex", 2D) = "white" {}
		[KeywordEnum(none,Dither)] _Mode("Mode", Float) = 0
		[KeywordEnum(none,vertColor,edge,normal,ramp)] _Debug("Debug", Int) = 0
		_Control("Dither", range(0,2)) = 1
	}

		SubShader
		{

			Tags { "Queue" = "Geometry" }

			Lod 100

			Pass
			{
				Name "BODYBASE"
				ZWrite On
				Cull Back
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile _ _MODE_DITHER
				#include "UnityCG.cginc"
				#include "../Cgincs/HSLSupport.cginc"
				#include "../Cgincs/MaterialFX.cginc"
				#include "Common.cginc"

				sampler2D _MainTex;
				sampler2D _MainRampTex;
				sampler2D _RampTex;
				sampler2D _Ramp;
				//uniform float _RampPer;

				float4 _MainTex_ST;

				fixed4 _OutlineColor;

				uniform float4 _RimColor;
				uniform float _RimDirectionalLightMask;
				uniform float _RimDirectionalLightPower;
				uniform float _RimPower;
				uniform float _RimPower2;
				uniform float _Outline;
				uniform fixed4 _LightColor0;

				uniform float _Debug;
				uniform float _IsOldModel;
				#if defined(_MODE_DITHER)
				CONTROLLER_BLOCK
				#endif

				 struct a2v
				 {
					 fixed4 vertex : POSITION;
					 fixed3 normal : NORMAL;
					 fixed2 uv : TEXCOORD0;
					 float4 tangent : TANGENT;
					 float4 color : COLOR;
				 };

				struct v2f
				{
					fixed4 pos : POSITION;
					fixed3 normal : NORMAL;
					float4 color : COLOR;
					fixed2 main_uv : TEXCOORD0;
					fixed  diff : TEXCOORD1;
					float4 ScreenPos : TEXCOORD2;
				};

				v2f vert(a2v v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					//o.normal = UnityObjectToViewPos(v.normal);
					o.main_uv = TRANSFORM_TEX(v.uv, _MainTex);
					o.normal=normalize(mul(fixed4(v.normal, 0), unity_WorldToObject).xyz);
					o.diff = dot(o.normal, normalize(_WorldSpaceLightPos0.xyz)) * 0.5 + 0.5;
					o.color = v.color;
					o.ScreenPos = ComputeScreenPos(o.pos);

					return o;
				}

				fixed4 frag(v2f IN) : COLOR
				{

					#if defined(_MODE_DITHER)
					float dither = Dither(IN.ScreenPos);
					dither = _Control - dither;
					clip(dither - 0.5);
					#endif
					float3 edge = 1;
					if (_IsOldModel <1)
					{
						edge = lerp(_OutlineColor,1,step(_Outline / 5, IN.color.b));
					}
					//メインテクスチャ
					half4 main = tex2D(_MainTex, IN.main_uv);
					main.rgb *= edge;
					//メイン影色テクスチャ
					half4 mainRamp = tex2D(_MainRampTex, IN.main_uv);
					//影テクスチャ
					half4 shadow = tex2D(_RampTex, IN.main_uv);
					//影リアル
					half4 ramp = tex2D(_Ramp, fixed2(IN.diff, IN.diff));
					//リアル影の濃さを調整
					ramp = lerp(ramp, float4(1,1,1,1), RAMP_POWER);
					//比較(暗)でセルフ影とリアル影をブレンド
					ramp = BlendDarkenf(ramp, shadow);
					//影を比較(明)で黒→指定色に変更
					ramp = BlendScreenf(ramp, mainRamp);
					//リムライト
					//main.xyz += IN.rimColor;
					fixed4 final = main * ramp * _LightColor0;

					switch (_Debug)
					{
					case 0:return final;
					case 1:return half4(IN.color);
					case 2:return half4(edge, 1);
					case 3:return half4(IN.normal, 1);
					case 4:return ramp;
					}
					return 1;
				}
				ENDCG
			}

			UsePass "Hidden/ToonShader/Outline/OUTLINE"
		}
}