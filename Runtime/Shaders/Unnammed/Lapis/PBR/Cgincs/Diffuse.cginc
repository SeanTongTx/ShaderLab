// Note: Disney diffuse must be multiply by diffuseAlbedo / PI. This is done outside of this function.
half DisneyDiffuse(half NdotV, half NdotL, half LdotH, half Roughness)
{
	half FD90 = 0.5 + 2.0 * LdotH * LdotH * Roughness;
	// Two schlick fresnel term
	half FdV = (1.0 + (FD90 - 1.0) * Pow5(1.0 - NdotV));
	half FdL = (1.0 + (FD90 - 1.0) * Pow5(1.0 - NdotL));

	return FdV * FdL;
}