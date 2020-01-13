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

#ifdef ENABLE_NORMALMAP
	float3 tsLightDir : TEXCOORD1;
	float3 tsViewDir : TEXCOORD2;
#else
	float3 worldPos : TEXCOORD1;
	float3 worldNormal : TEXCOORD2;
#endif
};

uniform fixed4 _LightColor0;

uniform sampler2D _MainTex;
uniform sampler2D _ShadeTex;

#ifdef ENABLE_NORMALMAP
uniform sampler2D _NormalTex;
uniform float4 _NormalTex_ST;
#endif

uniform sampler2D _SpecTex;
uniform float _Shininess;
uniform float _SpecMulti;

v2f vert(appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.color = v.color;
	o.uv = v.uv;

#ifdef ENABLE_NORMALMAP
	float3 lightDir = FixableObjSpaceLightDir(v.vertex);
	float3 viewDir = ObjSpaceViewDir(v.vertex);

	//TANGENT_SPACE_ROTATION;
	float3 binormal = cross(normalize(v.normal), normalize(v.tangent.xyz)) * v.tangent.w;
	float3x3 rotation = float3x3(v.tangent.xyz, binormal, v.normal);

	o.tsLightDir = mul(rotation, lightDir);
	o.tsViewDir = mul(rotation, viewDir);

#else
	float3 worldPos = mul(unity_ObjectToWorld, v.vertex);
	float3 worldNormal = UnityObjectToWorldNormal(v.normal);

	o.worldPos = worldPos;
	o.worldNormal = worldNormal;

#endif
	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	fixed4 mainTexColor = tex2D(_MainTex, i.uv);
	mainTexColor = ApplyOutline(mainTexColor, i.color.b);

	fixed4 shadeTexColor = tex2D(_ShadeTex, i.uv);
	fixed4 specularTexColor = tex2D(_SpecTex, i.uv);

#ifdef ENABLE_NORMALMAP
	fixed4 normalTexColor = tex2D(_NormalTex, i.uv * _NormalTex_ST.xy + _NormalTex_ST.zw);
	fixed3 normal = lerp(float3(0, 0, 1), normalize(UnpackNormal(normalTexColor)), mainTexColor.a);
	fixed3 lightDir = normalize(i.tsLightDir);
	fixed3 viewDir = normalize(i.tsViewDir);
#else
	fixed3 normal = normalize(i.worldNormal);
	fixed3 lightDir = normalize(FixableWorldSpaceLightDir(i.worldPos));
	fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
#endif

	float ndv = dot(normal, viewDir);
	float ndl = dot(normal, lightDir);


	float specular = BlinnPhongSpecular(viewDir, lightDir, normal, _Shininess);

#ifdef ENABLE_RAMP_SPECULAR
	specular = tex2D(_RampTex, float2(specular, 0.5)).r;
#endif
	fixed3 specularColor = specularTexColor.rgb * specular * _SpecMulti;
	mainTexColor.rgb += specularColor * specularTexColor.a;

	fixed4 color = CelShadingRim(ndl, ndv, mainTexColor, shadeTexColor, _LightColor0);
	color.a = 0;

	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, color);
	//MRT/HDR
	SETUP_COLORHDR(o, color);

	return o;
}
