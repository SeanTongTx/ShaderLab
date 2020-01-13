#include "../../Cgincs/Common.cginc"
#include "../../Cgincs/HSLSupport.cginc"

#if USE_FIXED_VIEW_LIGHTDIR
uniform float3 _ViewSpaceLightDir;
#endif

//light dir

inline float3 FixableWorldSpaceLightDir(in float3 worldPos)
{
#if USE_FIXED_VIEW_LIGHTDIR
	float3 lightDir = mul(unity_MatrixInvV, normalize(_ViewSpaceLightDir));
#else
	float3 lightDir = UnityWorldSpaceLightDir(worldPos);
#endif
	return lightDir;
}

inline float3 FixableObjSpaceLightDir(in float4 v)
{
#if USE_FIXED_VIEW_LIGHTDIR
	float3 lightDir = mul(unity_WorldToObject * unity_MatrixInvV, normalize(_ViewSpaceLightDir));
#else
	float3 lightDir = ObjSpaceLightDir(v);
#endif
	return lightDir;
}

uniform float _OutlineInside;
uniform fixed4 _OutlineColor;
//
inline fixed4 ApplyOutline(fixed4 color, fixed threshold)
{
#ifdef OUTLINE_INSIDE
	return lerp(_OutlineColor, color, step(_OutlineInside, threshold));
#else
	return color;
#endif
}

//rim
uniform float4 _RimParam;//x:Bias,y:scale,z:power,w:strength

//Scene environment rim setting
uniform float _SceneRim;
uniform fixed4 _RimColor;

inline float RimLight(float ndl, float ndv)
{
	float rim = FresnelEmpricial(_RimParam.x, _RimParam.y, max(0, ndv), _RimParam.z) * _RimParam.w;

	return rim;
}

inline float DirectionalRimLight(float ndl, float ndv)
{
	float rim = max(0, ndl) * FresnelEmpricial(_RimParam.x, _RimParam.y, max(0, ndv), _RimParam.z) * _RimParam.w;

	return rim;
}

//cel shaing

uniform sampler2D _RampTex;
uniform float4 _RampTex_ST;
uniform float _LightRadiance;

inline fixed4 CelShadingSimple(half NdL, fixed4 baseColor, fixed4 lightColor)
{
	fixed ramp = tex2D(_RampTex, fixed2(NdL * 0.5 + 0.5, 0)).r;
	fixed4 color = baseColor * ramp * lightColor * _LightRadiance;

	return color;
}

inline fixed4 CelShading(half NdL, fixed4 baseColor, fixed4 shadeColor, fixed4 lightColor)
{
	fixed ramp = tex2D(_RampTex, fixed2(NdL * 0.5 + 0.5, 0)).r;
	ramp = BlendDarkenf(ramp, shadeColor.a);
	fixed4 color = baseColor * BlendScreenf(ramp, shadeColor) * lightColor * _LightRadiance;

	return color;
}

inline fixed4 CelShadingRim(half NdL, half NdV, fixed4 baseColor, fixed4 shadeColor, fixed4 lightColor)
{
	fixed4 color = CelShading(NdL, baseColor, shadeColor, lightColor);

	float rim = DirectionalRimLight(NdL, NdV);
	color += lerp(color, _RimColor, _SceneRim) * rim * _LightRadiance;

	return color;
}

//uniform float _BaseColor_Step;
//uniform float _BaseShade_Feather;
//uniform float _ShadeColor_Step;
//uniform float _1st2nd_Shades_Feather;
//
//inline fixed4 CelShadingUCTS(half NdL, fixed4 baseColor, fixed4 shadeColor1, fixed4 shadeColor2, fixed4 lightColor)
//{
//	float shadowMask = smoothstep(_ShadeColor_Step - _1st2nd_Shades_Feather, _ShadeColor_Step, NdL);
//	float finalShadowMask = smoothstep(_BaseColor_Step - _BaseShade_Feather, _BaseColor_Step, NdL);
//	float3 color = lerp(lerp(shadeColor2, shadeColor1, shadowMask), baseColor, finalShadowMask) * lightColor;
//
//	return fixed4(color, 1);
//}
