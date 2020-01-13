
//Fresnel Empricial Approximation
inline half FresnelEmpricial(half Bias, half Scale, half d, half Power)
{
	return max(0, min(1, Bias + Scale * pow(1.0 - d, Power)));
}

//Fresnel Schlick Approximation // same as UnityStandardBRDF.cginc FresnelTerm()
//half3 FresnelSchlick(half3 F0, half N, half V)
//{
//	return F0 + (1 - F0) * pow((1 - dot(N, V)), 5);
//}


//specular

inline float PhongSpecular(float3 viewDir, float3 lightDir, float3 normal, float shininess)
{
	float3 reflectDir = normalize(reflect(-lightDir, normal));
	float rdv = max(0, dot(reflectDir, viewDir));
	float specular = pow(rdv, shininess * 0.25);
	return specular;
}

inline float BlinnPhongSpecular(float3 viewDir, float3 lightDir, float3 normal, float shininess)
{
	half3 halfDir = normalize(lightDir + viewDir);
	float ndh = max(0, dot(normal, halfDir));
	float specular = pow(ndh, shininess);
	return specular;
}

inline float3 ShiftTangent(float3 T, float3 N, float shift)
{
	float3 shiftedT = T + shift * N;
	return normalize(shiftedT);
}

inline float StrandSpecular(float3 viewDir, float3 lightDir, float3 tangent, float shininess)
{
	float3 halfDir = normalize(lightDir + viewDir);
	float tdh = dot(tangent, halfDir);
	float sinTH = sqrt(1.0 - tdh * tdh);
	float dirAtten = smoothstep(-1.0, 0.0, tdh);
	float specular = dirAtten * pow(sinTH, shininess);
	return specular;
}

inline float AnisotropicSpecular(float3 viewDir, float3 lightDir, float3 normal, float3 anisoDir, float anisoOffset, float shininess)
{
	float3 halfDir = normalize(lightDir + viewDir);
	float ndh = dot(normalize(normal + anisoDir), halfDir);
	float aniso = max(0, sin(radians((ndh + anisoOffset) * 180)));
	float specular = saturate(pow(aniso, shininess));
	return specular;
}

inline float3 WardAniso(float3 N, float3 H, float NdotL, float NdotV, float Roughness1, float Roughness2, float3 anisotropicDir, float3 specColor)
{
	float3 binormalDirection = cross(N, anisotropicDir);
	float HdotN = dot(H, N);
	float dotHDirRough1 = dot(H, anisotropicDir) / Roughness1;
	float dotHBRough2 = dot(H, binormalDirection) / Roughness2;
	float attenuation = 1.0;
	float3 spec = attenuation * specColor * sqrt(max(0.0, NdotL / NdotV)) * exp(-2.0 * (dotHDirRough1 * dotHDirRough1 + dotHBRough2 * dotHBRough2) / (1.0 + HdotN));
	return spec;
}