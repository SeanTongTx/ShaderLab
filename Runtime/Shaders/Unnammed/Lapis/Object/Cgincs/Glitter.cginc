#include "UnityCG.cginc"
#include "../../../Cgincs/CelShading.cginc"
#include "../../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 color : COLOR;
	half2 uv : TEXCOORD0;
};

struct v2f
{
	float4 vertex : SV_POSITION;
	float4 color : COLOR;
	float2 uv : TEXCOORD0;
	float3 tsLightDir : TEXCOORD1;
	float3 tsViewDir : TEXCOORD2;
};

uniform fixed4 _LightColor0;

uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;
uniform sampler2D _ShadeTex;
uniform float4 _BaseColor;
uniform float4 _GlitterColor;
uniform sampler2D _NormalTex;
uniform float4 _NormalTex_ST;

uniform sampler2D _SpecTex;
uniform float4 _SpecTex_ST;
uniform float _Shininess;
uniform float _SpecMulti;

v2f vert(appdata v)
{
	v2f o;

	float3 lightDir = FixableObjSpaceLightDir(v.vertex);
	float3 viewDir = ObjSpaceViewDir(v.vertex);

	//TANGENT_SPACE_ROTATION;
	float3 binormal = cross(normalize(v.normal), normalize(v.tangent.xyz)) * v.tangent.w;
	float3x3 rotation = float3x3(v.tangent.xyz, binormal, v.normal);

	o.vertex = UnityObjectToClipPos(v.vertex);
	o.color = v.color;
	o.uv = v.uv;
	o.tsLightDir = mul(rotation, lightDir);
	o.tsViewDir = mul(rotation, viewDir);

	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	// sample the texture
	fixed4 mainTexColor = tex2D(_MainTex, i.uv * _MainTex_ST.xy + _MainTex_ST.zw);
	mainTexColor = ApplyOutline(mainTexColor, i.color.b);

	fixed4 shadeTexColor = tex2D(_ShadeTex, i.uv);
	fixed4 normalTexColor = tex2D(_NormalTex, i.uv * _NormalTex_ST.xy + _NormalTex_ST.zw);

	fixed3 tsNormal = normalize(UnpackNormal(normalTexColor));
	fixed3 tsLightDir = normalize(i.tsLightDir);
	fixed3 tsViewDir = normalize(i.tsViewDir);

	fixed ndv = dot(fixed3(0, 0, 1), tsViewDir);
	fixed ndl = dot(fixed3(0, 0, 1), tsLightDir);

	fixed glitterMask = mainTexColor.a;

	fixed4 Albedo = lerp(_BaseColor, mainTexColor * _GlitterColor, glitterMask);

	float specular = BlinnPhongSpecular(tsViewDir, tsLightDir, tsNormal, _Shininess) * glitterMask;

	fixed4 specularTexColor = tex2D(_SpecTex, i.uv * _SpecTex_ST.xy + _SpecTex_ST.zw);

	Albedo += specular * _SpecMulti * specularTexColor;

	//toon
	fixed4 color = CelShadingRim(ndl, ndv, Albedo, shadeTexColor, _LightColor0);

	color.a = 0;

	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, color);
	//MRT/HDR
	SETUP_COLORHDR(o, color);

	return o;
}
