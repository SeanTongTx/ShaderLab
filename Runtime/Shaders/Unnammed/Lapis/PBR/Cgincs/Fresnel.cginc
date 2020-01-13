float Mix(float i, float j, float x) 
{
	return  j * x + i * (1.0 - x);
}

float SchlickFresnel(float i) 
{
	float x = clamp(1.0 - i, 0.0, 1.0);
	float x2 = x * x;
	return x2 * x2 * x;
}

//normal incidence reflection calculation
float F0(float NdotL, float NdotV, float LdotH, float roughness) 
{
	float FL = SchlickFresnel(NdotL);//FresnelLight
	float FV = SchlickFresnel(NdotV);//FresnelView
	float FD90 = 0.5 + 2.0 * LdotH * LdotH * roughness;//FresnelDiffuse90
	return  lerp(1, FD90, FL) * lerp(1, FD90, FV);
}

float3 SchlickFresnelFunction(float3 SpecularColor, float LdotH) 
{
	return SpecularColor + (1 - SpecularColor)* SchlickFresnel(LdotH);
}
//FresnelFunction *=  SchlickFresnelFunction(specColor, LdotH);

float SchlickIORFresnelFunction(float ior, float LdotH) 
{
	float f0 = pow(ior - 1, 2) / pow(ior + 1, 2);
	return f0 + (1 - f0) * SchlickFresnel(LdotH);
}
//FresnelFunction *=  SchlickIORFresnelFunction(_Ior, LdotH);

float SphericalGaussianFresnelFunction(float LdotH, float SpecularColor)
{
	float power = ((-5.55473 * LdotH) - 6.98316) * LdotH;
	return SpecularColor + (1 - SpecularColor) * pow(2, power);
}
//FresnelFunction *= SphericalGaussianFresnelFunction(LdotH, specColor);

inline half3 FresnelTerm(half3 F0, half cosA)
{
	half t = Pow5(1 - cosA);   // ala Schlick interpoliation
	return F0 + (1 - F0) * t;
}

inline half3 FresnelLerp(half3 F0, half3 F90, half cosA)
{
	half t = Pow5(1 - cosA);   // ala Schlick interpoliation
	return lerp(F0, F90, t);
}

inline half FabricScatterFresnelLerp(half NdotV, half scale)
{
	half t0 = Pow4(1 - NdotV);
	half t1 = 0.4 * (1 - NdotV);
	return (t1 - t0) * scale + t0;
}