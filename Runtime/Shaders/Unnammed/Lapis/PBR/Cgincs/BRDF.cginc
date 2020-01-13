#include "NDF.cginc"
#include "GSF.cginc"
#include "Fresnel.cginc"

//microfacet Cook-Torrance BRDF

float3 CookTorranceBRDF(float3 D, float3 F, float3 G, float NdotL, float NdotV)
{
	return (D * F * G) / (4.0 * NdotL * NdotV + 0.00001);
}