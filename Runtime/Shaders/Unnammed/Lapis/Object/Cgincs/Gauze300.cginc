#include "UnityCG.cginc"
#include "../../Cgincs/HSLSupport.cginc"
#include "../../Cgincs/MaterialFX.cginc"
#include "../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	//Texture
	half2 uv : TEXCOORD0;
	fixed3 normal : NORMAL;
	float4 color : COLOR;
	half2 uv1 : TEXCOORD1;
	/*vertInput*/
};

struct v2f
{
	float4 vertex : SV_POSITION;
	//Texture
	float2 uv : TEXCOORD0;
	fixed3 normal : NORMAL;
	float4 posWorld : TEXCOORD1;
	float2 Ramp_uv : TEXCOORD2;
	float4 color : COLOR;
	DITHER_SCREENPOS(3)
	DISSOLVE_COORDS(4)
	float2 uvMask : TEXCOORD5;
	/*vert2Frag*/
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
	//背面
	o.normal = UnityObjectToWorldNormal(v.normal);
	o.posWorld = mul(unity_ObjectToWorld, v.vertex);
	//Texture
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	o.Ramp_uv = TRANSFORM_TEX(v.uv, _RampTex);
	o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

	o.color = v.color;

	DITHER_VERTEX(o, o.vertex)
		DISSOLVE_VERTEX(o)
		/*vertCode*/
		return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	DITHER_FRAGMENT(i.ScreenPos,_Control)
	/*fragCode*/
	//Texture
	fixed4 col = tex2D(_MainTex, i.uv);
	fixed4 shadow = tex2D(_ShadeTex, i.uv);
	//法线
	fixed3 normal = normalize(i.normal);
	//主光源信息
	half3 lightDir = UnityWorldSpaceLightDir(i.posWorld.xyz);
	half nl = dot(normal, lightDir)*0.5 + 0.5;
	fixed4 ramp = tex2D(_RampTex, fixed2(nl, 0));
	ramp = ramp.r;
	ramp = BlendDarkenf(ramp, shadow.a);
	ramp = BlendScreenf(ramp, shadow);
	col.rgb *= _LightColor0 * (ramp);
	DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))

	col.a = lerp(col.a, 1, _Alpha);
	//MRT/Core
	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, col);
	//MRT/HDR
	SETUP_COLORHDR(o, col);

	return o;
}