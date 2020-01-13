float _OutlineInside;
fixed4 _OutlineColor;

//
inline fixed3 ApplyOutline(fixed3 color, fixed threshold)
{
#ifdef ENABLE_INSIDELINE
	return lerp(_OutlineColor, color, step(_OutlineInside, threshold));
#else
	return color;
#endif
}
