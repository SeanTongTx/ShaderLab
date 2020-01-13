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

struct v2f
{
	float4 vertex : SV_POSITION;
	fixed2 uv : TEXCOORD0;
	//主光源信息
	fixed nl : TEXCOORD1;
	DITHER_SCREENPOS(2)
		float4 color : COLOR;
	/*vert2Frag*/
	fixed2 uvMask : TEXCOORD3;
	//空间占比
	DISSOLVE_COORDS(4)
	fixed nv : TEXCOORD5;
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

v2f vert(appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	o.uvMask = TRANSFORM_TEX(v.uv, _Mask);
	o.nl = 0;
	o.nv = 0;
	o.color = v.color;
	DITHER_VERTEX(o, o.vertex)
	DISSOLVE_VERTEX(o)
	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	DITHER_FRAGMENT(i.ScreenPos,_Control)
	/*fragCode*/
	fixed4 col = tex2D(_MainTex, i.uv);
	//ramp light
	col *= _LightColor0;

	DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))
	col.a = 0;
	//MRT/Core
	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, col);
	//MRT/HDR
	SETUP_COLORHDR(o, col);
	return o;
}
