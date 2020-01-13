//NormalDistributionFunction

inline half sqr(half x)
{
	return x * x;
}

inline float2 sqr(float2 x)
{
	return x * x;
}

inline half3 sqr(half3 x)
{
	return x * x;
}

inline half4 sqr(half4 x)
{
	return x * x;
}

inline half Pow3(half x)
{
	return x * x * x;
}

inline float2 Pow3(float2 x)
{
	return x * x * x;
}

inline half3 Pow3(half3 x)
{
	return x * x * x;
}

inline half4 Pow3(half4 x)
{
	return x * x * x;
}

inline half Pow4(half x)
{
	return x * x * x * x;
}

inline float2 Pow4(float2 x)
{
	return x * x * x * x;
}

inline half3 Pow4(half3 x)
{
	return x * x * x * x;
}

inline half4 Pow4(half4 x)
{
	return x * x * x * x;
}

inline half Pow5(half x)
{
	return x * x * x * x * x;
}

inline half2 Pow5(half2 x)
{
	return x * x * x * x * x;
}

inline half3 Pow5(half3 x)
{
	return x * x * x * x * x;
}

inline half4 Pow5(half4 x)
{
	return x * x * x * x * x;
}

float GGXTerm(float NdotH, float roughness)
{
	float a2 = roughness * roughness;
	float d = (NdotH * a2 - NdotH) * NdotH + 1.0f; // 2 mad
	return UNITY_INV_PI * a2 / (d * d + 1e-7f); // This function is not intended to be running on Mobile,
											// therefore epsilon is smaller than what can be represented by half
}

float GGX_Aniso(float XdotH, float YdotH, float NdotH, float roughnessX, float roughnessY)
{
	float f = XdotH * XdotH / (roughnessX * roughnessX) + YdotH * YdotH / (roughnessY * roughnessY) + NdotH * NdotH;
	return 1.0 / (UNITY_PI * roughnessX * roughnessY * f * f);
}

float D_GGX_Aniso(float anisotropic, float roughness, float NdotH, float XdotH, float YdotH)
{
	float aspect = sqrt(1.0h - anisotropic * 0.9h);
	float roughnessX = max(0.001, roughness / aspect);
	float roughnessY = max(0.001, roughness * aspect);

	return GGX_Aniso(XdotH, YdotH, NdotH, roughnessX, roughnessY);
}

//Fabric

float D_Fabric(float NdotH, float roughness)
{
	return 0.96 * pow(1 - NdotH, 2) + 0.057;
}

float D_Ashikhmin(float NdotH, float roughness)
{
	float m2 = roughness * roughness;
	float cos2h = NdotH * NdotH;
	float sin2h = 1. - cos2h;
	float sin4h = sin2h * sin2h;
	return (sin4h + 4. * exp(-cos2h / (sin2h * m2))) / (UNITY_PI * (1. + 4. * m2) * sin4h);
}

float D_Charlie(float NdotH, float roughness)
{
	float invR = 1.0 / roughness;
	float cos2h = NdotH * NdotH;
	float sin2h = 1.0 - cos2h;
	return (2.0 + invR) * pow(sin2h, invR * 0.5) / (2.0 * UNITY_PI);
}

float D_InvGGX(float NdotH, float roughness)
{
	float a2 = roughness * roughness;
	float A = 4;
	float d = (NdotH - a2 * NdotH) * NdotH + a2;
	return rcp(UNITY_PI * (1 + A * a2)) * (1 + 4 * a2 * a2 / (d * d));
}