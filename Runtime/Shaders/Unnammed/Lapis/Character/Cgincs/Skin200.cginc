#include "UnityCG.cginc"
#include "../../../Cgincs/CelShading.cginc"
#include "../../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	fixed2 uv : TEXCOORD0;
	fixed3 normal : NORMAL;
};

struct v2f
{
	float4 vertex : SV_POSITION;
	fixed2 uv : TEXCOORD0;
	fixed nl : TEXCOORD1;
};

uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;
uniform sampler2D _ShadeTex;
uniform fixed4 _LightColor0;

v2f vert(appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	//法线
	half3 normal = UnityObjectToWorldNormal(v.normal);
	//世界坐标
	half3 posWorld = mul(unity_ObjectToWorld, v.vertex);
	//主光源信息
	half3 lightDir = FixableWorldSpaceLightDir(posWorld.xyz);
	o.nl = dot(normal, lightDir);
	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	/*fragCode*/
	fixed4 col = tex2D(_MainTex, i.uv);

	fixed4 shadow = tex2D(_ShadeTex, i.uv);

	col = CelShading(i.nl, col, shadow, _LightColor0);
	col.a = 0;
	//MRT/Core
	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, col);
	//MRT/HDR
	SETUP_COLORHDR(o, col);

	return o;
}