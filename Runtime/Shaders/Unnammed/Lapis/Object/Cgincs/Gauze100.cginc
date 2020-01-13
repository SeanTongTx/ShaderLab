#include "UnityCG.cginc"
#include "../../Cgincs/HSLSupport.cginc"
#include "../../Cgincs/MaterialFX.cginc"
#include "../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	fixed2 uv : TEXCOORD0;
};

struct v2f
{
	float4 vertex : SV_POSITION;
	fixed2 uv : TEXCOORD0;
};

uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;

/*RenderSetup*/
sampler2D _ShadeTex;
sampler2D _RampTex;
float4 _RampTex_ST;
float _Alpha;
float _RimPower;
//描边
//uniform float _OutlineInside;
uniform fixed4 _OutlineColor;

CONTROLLER_BLOCK
DISSOLVE_BLOCK

//主像素光
uniform fixed4 _LightColor0;
uniform sampler2D _Mask;
uniform float4 _Mask_ST;

v2f vert(appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);

	/*vertCode*/
	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	/*fragCode*/
	//Texture
	fixed4 col = tex2D(_MainTex, i.uv);
	col *= _LightColor0;
	col.a = 1;
	//MRT/Core
	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, col);
	//MRT/HDR
	SETUP_COLORHDR(o, col);

	return o;
}