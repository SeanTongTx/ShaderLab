Shader "Hidden/ToonShader/Outline"
{
	CGINCLUDE

			#include "UnityCG.cginc"
            #include "Common.cginc"
			#include "../Cgincs/MaterialFX.cginc"
			#pragma multi_compile _ _MODE_DITHER _MODE_DISSOLVE
            inline void ShoveOutlineDepth (inout float depth, float shoveVal)
            {
                #if defined(UNITY_REVERSED_Z)
                depth -= _OUTLINE_SHOVE_BASE * (1.0 - shoveVal);
                #else
                depth += _OUTLINE_SHOVE_BASE * (1.0 - shoveVal);
                #endif
            }

			struct a2v
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
				float4 color : COLOR;
				half2 uv1 : TEXCOORD1;
			};

			struct v2f
			{
				fixed4 pos : SV_POSITION;
				fixed4 color : COLOR;
				DITHER_SCREENPOS(0)
				DISSOLVE_COORDS(1)
				fixed2 uvMask : TEXCOORD2;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _Mask;
			float4 _Mask_ST;
			float _Outline;
			fixed4 _OutlineColor;

			//主像素光
			uniform half4 _LightColor0;
			CONTROLLER_BLOCK
			DISSOLVE_BLOCK
			v2f vert(a2v v)
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f, o);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

				float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
				float2 offset = TransformViewToProjection(norm.xy);

				// アウトライン幅の補正スケール（デフォルトでは補正OFF）
				float correction = 1.0;

				if (UNITY_MATRIX_P._m33 == 0.0)
				{
					// 透視投影時のアウトライン幅の補正

					// View空間上で距離を計算する
					// プロジェクション空間は非線形なので、View空間を用いる
					float3 viewPos = UnityObjectToViewPos(v.vertex);
					float distanceCorrection = max(0.0, -viewPos.z);

					// プロジェクション変換行列の要素を利用してFoVの影響を打ち消す
					// _m00 = 1 / tan(FoV/2) * H / W
					// _m11 = 1 / tan(FoV/2)
					// http://marupeke296.com/DXG_No70_perspective.html

					// FoV30°を補正なしの基準値にする
					float tan15 = 0.26794919243;// tan(30/2)

												// TODO: アスペクト比を 16:9 で決め打ちにしているので、パラメータとして渡すようにする
					float fovCorrection = UNITY_MATRIX_P._m00 * tan15 * 16 / 9;

					// _m11 からFoVを計算すれば、アスペクト比を渡す必要がなくなる
					// fovCorrection = UNITY_MATRIX_P._m11 * tan15;
					// しかし、iPhone上では _m11 から計算すると、アウトラインが表示されなくなることを確認した
					// TOOD: iPhone上の _m11 の値について調査

					// 距離とFoVを合成したキャラクターとカメラの距離。スクリーン上でどの大きさで見えるかを基準とした値
					correction = distanceCorrection / fovCorrection;

					if (correction < _OUTLINE_CORRECTION_DISTANCE)
					{
						// 近影時のアウトライン幅の補正
						correction = correction / _OUTLINE_CORRECTION_DISTANCE;
					}
					else
					{
						// 遠影時のアウトライン幅の補正
						correction = correction * _OUTLINE_CORRECTION_RATE / _OUTLINE_CORRECTION_DISTANCE + 1.0 - _OUTLINE_CORRECTION_RATE;
					}
				}
				else
				{
					// 平行投影時にはアウトライン幅を0にする（アウトラインを非表示）
					// correction = 0.0;
				}

				// 頂点カラーRで太さ調整する
				o.pos.xy += offset * _Outline * _OUTLINE_WIDTH_BASE * v.color.r * correction;
				//o.pos.xy += offset * _OUTLINE_WIDTH_BASE * v.color.r * correction;

				// 頂点カラーのGで押し込み量を調整する
				ShoveOutlineDepth(o.pos.z, v.color.g);
				o.color = tex2Dlod(_MainTex, float4(v.uv, 0, 0)) * _OutlineColor*_LightColor0;
				DITHER_VERTEX(o, o.pos)
				DISSOLVE_VERTEX(o)
				return o;
			}
	ENDCG

    SubShader
    {
        Pass {
            Name "OUTLINE"

	        Tags {
	        	"Queue" = "Opaque"  "LightMode" = "ForwardBase"
	    	}
            Cull Front
            ZWrite On
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile_fwdbase

            fixed4 frag (v2f i) : COLOR
            {
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				DISSOLVE_FRAGMENT(i,_Control,i.color,tex2D(_Mask, i.uvMask))

				i.color.a = 1;
				return i.color;
            }
            ENDCG
        }
    }
}