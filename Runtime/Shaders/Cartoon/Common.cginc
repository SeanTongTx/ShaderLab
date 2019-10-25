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
