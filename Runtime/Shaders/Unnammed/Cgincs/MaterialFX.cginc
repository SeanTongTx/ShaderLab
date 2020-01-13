#define _EMPTY 
//add this to each pass 
//#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE
#define CONTROLLER_BLOCK uniform float _Control;
/**********************Dither************************/
inline float Dither8x8Bayer(int x, int y)
{
	const float dither[64] = {
		1, 49, 13, 61,  4, 52, 16, 64,
		33, 17, 45, 29, 36, 20, 48, 32,
		9, 57,  5, 53, 12, 60,  8, 56,
		41, 25, 37, 21, 44, 28, 40, 24,
		3, 51, 15, 63,  2, 50, 14, 62,
		35, 19, 47, 31, 34, 18, 46, 30,
		11, 59,  7, 55, 10, 58,  6, 54,
		43, 27, 39, 23, 42, 26, 38, 22 };
	int r = y * 8 + x;
	return dither[r] / 64; // same # of instructions as pre-dividing due to compiler magic
}
//use ComputeScreenPos get ScreenPos
float Dither(float4 screenPos)
{
	float4 screenPosNormal = screenPos / screenPos.w;
	float2 clipScreen = screenPosNormal.xy * _ScreenParams.xy;
	float dither = Dither8x8Bayer(fmod(clipScreen.x, 8), fmod(clipScreen.y, 8));
	return dither;
}
#ifdef MODE_DITHER
#define DITHER_SCREENPOS(idx1) float4 ScreenPos : TEXCOORD##idx1;
#define DITHER_VERTEX(output,clipos) output.ScreenPos = ComputeScreenPos(clipos);
#define DITHER_FRAGMENT(ScreenPos,control) \
				float dither = Dither(ScreenPos); \
				dither = control*2 - dither; \
				clip(dither - 0.5);
#else 
#define DITHER_FRAGMENT(ScreenPos,control) _EMPTY
#define DITHER_VERTEX(output,clipos) _EMPTY
#define DITHER_SCREENPOS(idx1) _EMPTY
#endif
/**********************Dither************************/

/**********************Dissolve************************/
#ifdef MODE_DISSOLVE
#define DISSOLVE_BLOCK uniform float4 _Dissolve_Pramas;
#define DISSOLVE_COORDS(idx1) float2 uv1 : TEXCOORD##idx1;
#define DISSOLVE_VERTEX(output) output.uv1 =TRANSFORM_TEX(v.uv1, _MainTex);
#define DISSOLVE_FRAGMENT(input,control,baseColor, mask) \
				half yMask = input.uv1.y + control * 2 - 1; \
				yMask = smoothstep(0.5-_Dissolve_Pramas.w, 0.5+_Dissolve_Pramas.w, yMask); \
				half c = step( yMask, mask.r); \
				baseColor+=c*yMask*_Dissolve_Pramas.z; \
				clip(c-0.5); 
#else
#define DISSOLVE_BLOCK _EMPTY
#define DISSOLVE_COORDS(idx1) _EMPTY
#define DISSOLVE_VERTEX(output) _EMPTY
#define DISSOLVE_FRAGMENT(input,control,baseColor, mask) _EMPTY
#endif
/**********************Dissolve************************/