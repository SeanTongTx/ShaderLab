#include "UnityCG.cginc"
#include "../../../Cgincs/CelShading.cginc"
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

uniform fixed4 _CheekColor;
uniform float _CheekPower;

v2f vert(appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

	//法线
	half3 normal = UnityObjectToWorldNormal(v.normal);
	//世界坐标
	half3 posWorld = mul(unity_ObjectToWorld, v.vertex);
	//主光源信息
	half3 lightDir = FixableWorldSpaceLightDir(posWorld.xyz);
	half3 viewDir = normalize(UnityWorldSpaceViewDir(posWorld.xyz));

	o.nl = dot(normal, lightDir);
	o.nv = dot(normal, viewDir);

	o.color = v.color;
	o.color.a = 0;

	DITHER_VERTEX(o, o.vertex)
		DISSOLVE_VERTEX(o)
		return o;
}
FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	DITHER_FRAGMENT(i.ScreenPos,_Control)
	/*fragCode*/
	fixed4 col = tex2D(_MainTex, i.uv);
	fixed3 cheek = 0;
	cheek = (1 - col.a)*_CheekPower;
	col.rgb = lerp(col.rgb, _CheekColor.rgb, cheek);

	fixed4 shadow = tex2D(_ShadeTex, i.uv);

	col = CelShadingRim(i.nl, i.nv, col, shadow, _LightColor0);

	DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))
	col.a = 0;
	//MRT/Core
	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, col);
	//MRT/HDR
	SETUP_COLORHDR(o, col);
	return o;
}

