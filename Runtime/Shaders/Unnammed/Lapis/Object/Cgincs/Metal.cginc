#include "UnityCG.cginc"
#include "../../Cgincs/CelShading.cginc"
#include "../../Cgincs/MRTSupport.cginc"

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
	float3 viewDir : TEXCOORD3;
};

uniform sampler2D _MainTex;
uniform sampler2D _ShadeTex;

#ifdef ENABLE_ANISOTROPY	
uniform sampler2D _AnisoTex;
uniform float _AnisoScale;
#endif

#ifdef ENABLE_SPECULAR
uniform sampler2D _SpecTex;
uniform float _Shininess;
uniform float _SpecMulti;
#endif

uniform samplerCUBE _ReflectTex;
uniform half4 _ReflectTex_HDR;

uniform float _Reflective;

uniform fixed4 _LightColor0;

v2f vert(appdata v)
{
	v2f o;

	float3 worldPos = mul(unity_ObjectToWorld, v.vertex);
	float3 worldNormal = UnityObjectToWorldNormal(v.normal);

	o.vertex = UnityObjectToClipPos(v.vertex);
	o.color = v.color;
	o.uv = v.uv;
	o.worldPos = worldPos;
	o.worldNormal = worldNormal;
	o.viewDir = UnityWorldSpaceViewDir(worldPos);

	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	float3 lightDir = normalize(FixableWorldSpaceLightDir(i.worldPos));
	float3 viewDir = normalize(i.viewDir);
	float3 worldNormal = normalize(i.worldNormal);
	float3 reflectDir = reflect(-viewDir, worldNormal);

	float ndv = max(0, dot(worldNormal, viewDir));
	float ndl = max(0, dot(worldNormal, lightDir));

	fixed4 mainTexColor = tex2D(_MainTex, i.uv);
	mainTexColor = ApplyOutline(mainTexColor, i.color.b);
	fixed4 shadeTexColor = tex2D(_ShadeTex, i.uv);

#ifdef ENABLE_ANISOTROPY
	fixed4 anisoTexColor = tex2D(_AnisoTex, i.uv * _AnisoScale);
	fixed3 anisoDir = UnpackNormal(anisoTexColor);
	reflectDir = normalize(reflectDir + anisoDir);
#endif

	fixed4 reflectTexColor = fixed4(DecodeHDR(texCUBE(_ReflectTex, normalize(reflectDir)), _ReflectTex_HDR), 1.0);
	mainTexColor = lerp(mainTexColor, mainTexColor * reflectTexColor, _Reflective * mainTexColor.a);
	shadeTexColor = lerp(shadeTexColor, shadeTexColor * reflectTexColor, _Reflective * mainTexColor.a);
	fixed4 color = CelShadingRim(ndl, ndv, mainTexColor, shadeTexColor, _LightColor0);

#ifdef ENABLE_SPECULAR
	fixed4 specularTexColor = tex2D(_SpecTex, i.uv);
	float specular = BlinnPhongSpecular(viewDir, lightDir, worldNormal, _Shininess);
	color += specular * specularTexColor * specularTexColor.a * _SpecMulti * _LightColor0;
#endif
	color.a = 0;

	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, color);
	//MRT/HDR
	SETUP_COLORHDR(o, color);

	return o;
}

