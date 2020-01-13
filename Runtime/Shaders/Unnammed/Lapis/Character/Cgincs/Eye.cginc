#include "UnityCG.cginc"
#include "../../../Cgincs/MaterialFX.cginc"
#include "../../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	fixed2 uv : TEXCOORD0;
	//法线
	fixed3 normal : NORMAL;
	float4 color : COLOR;
	float2 uv1 : TEXCOORD1;

	/*vertInput*/
};

struct v2f_eye
{
	float4 vertex : SV_POSITION;
	fixed2 uv : TEXCOORD0;
	DITHER_SCREENPOS(2)
		/*vert2Frag*/
		fixed2 uvMask : TEXCOORD3;
	//空间占比
	DISSOLVE_COORDS(4)
};

CONTROLLER_BLOCK
DISSOLVE_BLOCK
/*RenderSetup*/
uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;
uniform sampler2D _ShadeTex;
//uniform sampler2D _RampTex;

uniform sampler2D _Mask;
uniform float4 _Mask_ST;

/*PassData*/
//主像素光
uniform fixed4 _LightColor0;
uniform float _LightRadiance;

v2f_eye vert(appdata v)
{
	v2f_eye o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	o.uvMask = TRANSFORM_TEX(v.uv, _Mask);
	DITHER_VERTEX(o, o.vertex)
		DISSOLVE_VERTEX(o)
		return o;
}

FRAG_OUT_TYPE frag(v2f_eye i) : SV_Target
{
	DITHER_FRAGMENT(i.ScreenPos,_Control)
	/*fragCode*/
	fixed4 col = tex2D(_MainTex, i.uv);
	col *= pow(_LightColor0 * _LightRadiance, 0.5);
	DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))
	col.a = 0;
	//MRT/Core
	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, col);
	//MRT/HDR
	SETUP_COLORHDR(o, col);
	return  o;
}
