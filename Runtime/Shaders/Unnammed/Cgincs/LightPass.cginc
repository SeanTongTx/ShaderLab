#include "UnityCG.cginc"
#include "AutoLight.cginc"
#include "Lighting.cginc"
#include "MaterialFX.cginc"
#include "MRTSupport.cginc"

struct VertexInput 
{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
    float2 uv : TEXCOORD0;
};

struct VertexOutput 
{
    float4 pos : SV_POSITION;
	float2 uv : TEXCOORD0;
    float4 posWorld : TEXCOORD1;
    float3 normalDir : TEXCOORD2;
    LIGHTING_COORDS(3,4)
    UNITY_FOG_COORDS(5)
	float4 ScreenPos : TEXCOORD6;
};

#if defined(MODE_DITHER)
	CONTROLLER_BLOCK
#endif

uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;

uniform sampler2D _RampTex;

VertexOutput vert (VertexInput v) 
{

    VertexOutput o = (VertexOutput)0;

	o.uv = TRANSFORM_TEX(v.uv, _MainTex);

    o.normalDir = UnityObjectToWorldNormal(v.normal);

    o.posWorld = mul(unity_ObjectToWorld, v.vertex);

    o.pos = UnityObjectToClipPos(v.vertex );

    UNITY_TRANSFER_FOG(o,o.pos);

    TRANSFER_VERTEX_TO_FRAGMENT(o)

	o.ScreenPos = ComputeScreenPos(o.pos);

    return o;
}

FRAG_OUT_TYPE frag(VertexOutput i) : COLOR
{
	#if defined(MODE_DITHER)
		float dither = Dither(i.ScreenPos);
		dither = _Control * 2 - dither;
		clip(dither - 0.5);
	#endif

	float3 normalDirection = normalize(i.normalDir);

	UNITY_LIGHT_ATTENUATION(attenuation, i, i.posWorld.xyz);

    float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz, _WorldSpaceLightPos0.w));

	float NdL = 0.5 * dot(lightDirection, normalDirection) + 0.5;

	float3 lightColor = _LightColor0.rgb * NdL * attenuation;

	////// Lighting:

	float ramp =  tex2D(_RampTex, half2(NdL, 0)).r;

    float3 finalColor = ramp * tex2D(_MainTex, i.uv) * lightColor.rgb;

    fixed4 finalRGBA = fixed4(finalColor,0);

    UNITY_APPLY_FOG(i.fogCoord, finalRGBA);

	//MRT/Core
	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, finalRGBA);

	//MRT/HDR
	SETUP_COLORHDR(o, finalRGBA);

	return o;
}
