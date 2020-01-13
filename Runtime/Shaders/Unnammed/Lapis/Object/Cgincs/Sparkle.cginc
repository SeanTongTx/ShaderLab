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
	float4 screenPos : TEXCOORD4;
};

uniform fixed4 _LightColor0;

uniform sampler2D _MainTex;
uniform sampler2D _ShadeTex;

uniform sampler2D _NoiseTex;
uniform float4 _SparkleColor;
uniform float _Frequency;
uniform float _Threshold;
uniform float _Range;
uniform float _Brightness;
uniform float _Speed;
uniform float _ScreenContribution;
uniform float4 _SparkleFresnel;

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
	o.screenPos = ComputeScreenPos(o.vertex);

	return o;
}

fixed4 frag(v2f i) : SV_Target
{
	float3 lightDir = FixableWorldSpaceLightDir(i.worldPos);
	float3 viewDir = normalize(i.viewDir);
	float3 worldNormal = normalize(i.worldNormal);

	float ndv = dot(worldNormal, viewDir);
	float ndl = dot(worldNormal, lightDir);

	float4 screenPos = i.screenPos / i.screenPos.w;

	// sample the texture
	fixed4 mainTexColor = tex2D(_MainTex, i.uv);
	mainTexColor = ApplyOutline(mainTexColor, i.color.b);
	fixed4 shadeTexColor = tex2D(_ShadeTex, i.uv);

	float2 uvNoise = i.uv * _Frequency;
	float mulTime = _Time.y * _Speed;

	fixed noiseTexColor1 = tex2D(_NoiseTex, screenPos.xy * _ScreenContribution + uvNoise + mulTime).g;
	fixed noiseTexColor2 = tex2D(_NoiseTex, uvNoise * 1.1 - mulTime).g;

	float smoothstepResult = smoothstep(_Threshold, (_Threshold + _Range), (noiseTexColor1 * noiseTexColor2));

	float fresnel = FresnelEmpricial(_SparkleFresnel.x, _SparkleFresnel.y, ndv, _SparkleFresnel.z);

	fixed4 color = CelShadingRim(ndl, ndv, mainTexColor + _SparkleColor * smoothstepResult * _Brightness * fresnel, shadeTexColor, _LightColor0);
	color.a = 0;

	return color;
}