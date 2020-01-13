#include "UnityCG.cginc"
#include "MaterialFX.cginc"

#ifndef DEFINES_INC_COMMON_INCLUDE
#define DEFINES_INC_COMMON_INCLUDE

//
// アウトライン関連
//

// アウトラインの幅[m]
#define _OUTLINE_WIDTH_BASE 0.001

// アウトライン色
//#define _OUTLINE_COLOR_TINT fixed4(0.35, 0.35, 0.35, 1.0)
// TODO: モデルデータに頂点カラーが未設定なので仮対応
#define _OUTLINE_COLOR_TINT fixed4(1.0, 1.0, 1.0, 1.0)

// Z方向の押し込み量[m]
#define _OUTLINE_SHOVE_BASE 0.0007

// 任意エッジのアウトラインの幅の比率。0.0〜1.0の範囲で指定
#define _EDGE_WIDTH_RATE 0.18

// 近影とみなす距離[m]
// カメラとの距離がこれ未満ならアウトライン幅を常に一定を保つ
#define _OUTLINE_CORRECTION_DISTANCE 0.9

// 遠影（カメラとの距離が _OUTLINE_CORRECTION_DISTANCE 以降）のときの補正率
//
// 0.0〜1.0の範囲で指定。大きいほど補正が強い
//   0.0: 補正が完全に無効になる（遠ざかるほど細くなる）
//   1.0: 遠ざかってもアウトライン幅を一定に保つ（近影時と完全に同じ補正率を維持する）
#define _OUTLINE_CORRECTION_RATE 0.3

#define RAMP_POWER 0

#endif

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
	DITHER_SCREENPOS(0)
	DISSOLVE_COORDS(1)
	fixed2 uvMask : TEXCOORD2;
	fixed2 uv : TEXCOORD3;
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

inline void ShoveOutlineDepth(inout float depth, float shoveVal)
{
#if defined(UNITY_REVERSED_Z)
	depth -= _OUTLINE_SHOVE_BASE * (1.0 - shoveVal);
#else
	depth += _OUTLINE_SHOVE_BASE * (1.0 - shoveVal);
#endif
}

v2f vert(a2v v)
{
	v2f o;
	UNITY_INITIALIZE_OUTPUT(v2f, o);
	o.pos = UnityObjectToClipPos(v.vertex);
	o.uvMask = TRANSFORM_TEX(v.uv, _Mask);
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);

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
	//o.color =tex2Dlod(_MainTex, float4(v.uv, 0, 0))* _OutlineColor* _LightColor0;
	
	DITHER_VERTEX(o, o.pos)
		DISSOLVE_VERTEX(o)
		return o;
}

fixed4 frag(v2f i) : COLOR
{
	DITHER_FRAGMENT(i.ScreenPos,_Control)
	DISSOLVE_FRAGMENT(i,_Control,i.color,tex2D(_MainTex, i.uvMask))
	half4 col= tex2D(_MainTex, i.uv);
	//clip(col.a - 0.9);
	col.a = 0;
	return col* _OutlineColor * _LightColor0;
}