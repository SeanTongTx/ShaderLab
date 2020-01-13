#include "UnityCG.cginc"
#include "../../Cgincs/CelShading.cginc"
#include "../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float3 tangent : TANGENT;
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
	float3 viewDir : TEXCOORD3;
	float3 worldTangent : TEXCOORD4;
};

uniform sampler2D _MainTex;
uniform sampler2D _ShadeTex;

#ifdef ENABLE_SHIFT
uniform sampler2D _ShiftTex;
uniform float4 _Shift;
#endif 

uniform sampler2D _SpecTex;
uniform float _Shininess;
uniform float _SpecMulti;
uniform fixed4 _LightColor0;


v2f vert(appdata v)
{
	v2f o;

	float3 worldPos = mul(unity_ObjectToWorld, v.vertex);
	float3 worldNormal = UnityObjectToWorldNormal(v.normal);
	float3 worldTangent = UnityObjectToWorldDir(v.tangent);

	o.vertex = UnityObjectToClipPos(v.vertex);
	o.color = v.color;
	o.uv = v.uv;
	o.worldPos = worldPos;
	o.worldNormal = worldNormal;
	o.viewDir = UnityWorldSpaceViewDir(worldPos);
	o.worldTangent = worldTangent;

	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	float3 lightDir = FixableWorldSpaceLightDir(i.worldPos);
	float3 viewDir = normalize(i.viewDir);
	float3 worldNormal = normalize(i.worldNormal);
	float3 worldTangent = normalize(i.worldTangent);
	float3 worldBinormal = cross(worldNormal, worldTangent);

#ifdef ENABLE_SHIFT
	//shift tangents
	float shiftTexColor1 = tex2D(_ShiftTex, float2(i.uv.x * _Shift.x, i.uv.y)) - 0.5;
	float shiftTexColor2 = tex2D(_ShiftTex, float2(i.uv.x * _Shift.z, i.uv.y)) - 0.5;

	float3 t1 = ShiftTangent(worldBinormal, worldNormal, _Shift.y + shiftTexColor1);
	float3 t2 = ShiftTangent(worldBinormal, worldNormal, _Shift.w + shiftTexColor2);
#endif
	//
	float ndv = dot(worldNormal, viewDir);
	float ndl = dot(worldNormal, lightDir);

	//main texture
	fixed4 mainTexColor = tex2D(_MainTex, i.uv);
	mainTexColor = ApplyOutline(mainTexColor, i.color.b);
#ifdef ENABLE_SHIFT
	//strand specular
	float specular = StrandSpecular(viewDir, lightDir, t1, _Shininess) + StrandSpecular(viewDir, lightDir, t2, _Shininess);
#else
	float specular = StrandSpecular(viewDir, lightDir, worldBinormal, _Shininess);
#endif
	fixed4 specularTexColor = tex2D(_SpecTex, i.uv);
	fixed3 specularColor = specularTexColor.rgb * specular * _SpecMulti;
	mainTexColor.rgb += specularColor * specularTexColor.a;

	//toon
	fixed4 shadeTexColor = tex2D(_ShadeTex, i.uv);
	fixed4 color = CelShadingRim(ndl, ndv, mainTexColor, shadeTexColor, _LightColor0);

	color.a = 0;

	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, color);
	//MRT/HDR
	SETUP_COLORHDR(o, color);

	return o;
}