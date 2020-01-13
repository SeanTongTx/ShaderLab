#include "UnityCG.cginc"
#include "../../../Cgincs/CelShading.cginc"
#include "../../../Cgincs/MaterialFX.cginc"
#include "../../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	fixed4 color : COLOR;
	float3 normal : NORMAL;
	float2 uv : TEXCOORD0;
	float2 uv1 : TEXCOORD1;
};

struct v2f
{
	float4 vertex : SV_POSITION;
	float4 color : COLOR;
	fixed2 uv : TEXCOORD0;
	fixed nl : TEXCOORD1;
	fixed nv : TEXCOORD2;
	fixed2 uvMask : TEXCOORD3;
	DITHER_SCREENPOS(4)
	DISSOLVE_COORDS(5)
};

CONTROLLER_BLOCK
DISSOLVE_BLOCK

uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;
uniform sampler2D _ShadeTex;
//uniform sampler2D _RampTex;

uniform sampler2D _Mask;
uniform float4 _Mask_ST;

uniform fixed4 _LightColor0;

v2f vert(appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = v.uv;
	o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

	half3 normal = UnityObjectToWorldNormal(v.normal);
	half3 worldPos = mul(unity_ObjectToWorld, v.vertex);
	half3 lightDir = FixableWorldSpaceLightDir(worldPos);
	half3 viewDir = normalize(UnityWorldSpaceViewDir(worldPos));

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
	DITHER_FRAGMENT(i.ScreenPos, _Control)

	fixed4 col = tex2Dbias(_MainTex, float4(i.uv, 0, -0.5));
	col = ApplyOutline(col, i.color.b);

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