#include "UnityCG.cginc"
#include "../../../Cgincs/CelShading.cginc"
#include "../../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 color : COLOR;
	half2 uv : TEXCOORD0;
};

struct v2f
{
	float4 vertex : SV_POSITION;
	float4 color : COLOR;
	float2 uv : TEXCOORD0;
	float3 worldPos : TEXCOORD1;
	float3 worldNormal : TEXCOORD2;
};

uniform fixed4 _LightColor0;

uniform sampler2D _MainTex;
uniform sampler2D _ShadeTex;

uniform float _Illumin;

v2f vert(appdata v)
{
	float3 worldPos = mul(unity_ObjectToWorld, v.vertex);
	float3 worldNormal = UnityObjectToWorldNormal(v.normal);

	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.color = v.color;
	o.uv = v.uv;
	o.worldPos = worldPos;
	o.worldNormal = worldNormal;

	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	fixed4 mainTexColor = tex2D(_MainTex, i.uv);
	mainTexColor = ApplyOutline(mainTexColor, i.color.b);

	fixed4 shadeTexColor = tex2D(_ShadeTex, i.uv);

	fixed3 normal = normalize(i.worldNormal);
	fixed3 lightDir = normalize(FixableWorldSpaceLightDir(i.worldPos));
	fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));

	float ndv = dot(normal, viewDir);
	float ndl = dot(normal, lightDir);

	fixed4 color = CelShadingRim(ndl, ndv, mainTexColor, shadeTexColor, _LightColor0);
	color.rgb += mainTexColor.rgb * mainTexColor.a * _Illumin;
	color.a = 0.0;

	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, color);
	//MRT/HDR
	SETUP_COLORHDR(o, color);

	return o;
}
