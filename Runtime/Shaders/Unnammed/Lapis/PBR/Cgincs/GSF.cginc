float G_SmithGGX(float NdotV, float alphaG)
{
	float a = alphaG * alphaG;
	float b = NdotV * NdotV;
	return rcp(NdotV + sqrt(a + b - a * b));
}

float SmithGGX_Aniso(float NdotV, float VdotX, float VdotY, float ax, float ay)
{
	return rcp(NdotV + sqrt(sqr(VdotX * ax) + sqr(VdotY * ay) + sqr(NdotV)));
}

float G_SmithGGX_Aniso(float anisotropic, float roughness, float NdotV, float VdotX, float VdotY)
{
	float aspect = sqrt(1.0h - anisotropic * 0.9h);
	float X = max(0.001, roughness / aspect);
	float Y = max(0.001, roughness * aspect);

	return SmithGGX_Aniso(NdotV, VdotX, VdotY, X, Y);
}


float SmithJointGGXVisibilityTerm(float NdotL, float NdotV, float roughness)
{
	// Approximation of the above formulation (simplify the sqrt, not mathematically correct but close enough)
	float a = roughness;
	float lambdaV = NdotL * (NdotV * (1 - a) + a);
	float lambdaL = NdotV * (NdotL * (1 - a) + a);

	return 0.5f / (lambdaV + lambdaL + 1e-5f);
}

float SmithJointGGXAniso(float XdotV, float YdotV, float NdotV, float XdotL, float YdotL, float NdotL, float roughnessX, float roughnessY)
{
	float aX = roughnessX;
	float aX2 = aX * aX;
	float aY = roughnessY;
	float aY2 = aY * aY;
	float lambdaV = NdotL * sqrt(aX2 * XdotV * XdotV + aY2 * YdotV * YdotV + NdotV * NdotV);
	float lambdaL = NdotV * sqrt(aX2 * XdotL * XdotL + aY2 * YdotL * YdotL + NdotL * NdotL);

	return 0.5 / (lambdaV + lambdaL);
}

float G_SmithJointGGXAniso(float anisotropic, float roughness, float XdotV, float YdotV, float NdotV, float XdotL, float YdotL, float NdotL)
{
	float aspect = sqrt(1.0h - anisotropic * 0.9h);
	float roughnessX = max(0.001, roughness / aspect);
	float roughnessY = max(0.001, roughness * aspect);

	return SmithJointGGXAniso(XdotV, YdotV, NdotV, XdotL, YdotL, NdotL, roughnessX, roughnessY);
}

//Fabric

float G_Ashikhmin(float NdotV, float NdotL)
{
	return rcp(4.0 * (NdotL + NdotV - NdotL * NdotV));
}