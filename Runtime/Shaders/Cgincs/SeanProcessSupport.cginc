
//Use MultiCompile to get texture from different source
//#pragma multi_compile SOURCE_UNITY SOURCE_ZBUFFER SOURCE_MRT
//如果直接使用unity的默认贴图 会在其他之外的效果设置时被覆盖（例如 pc下开启实时阴影会默认开启depthpass 覆盖depthtexture)
#if SOURCE_UNITY
uniform sampler2D _CameraDepthNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#elif SOURCE_ZBUFFER
uniform sampler2D Screen_DepthTexture;
#elif SOURCE_MRT
uniform sampler2D Screen_DepthNormalsTexture;
uniform sampler2D Screen_DepthTexture;
#endif
float4 ScreenDepthNormal(float2 UV)
{
#if SOURCE_UNITY
	float3 normalValues;
	float depthValue;
	DecodeDepthNormal(tex2D(_CameraDepthNormalsTexture, UV), depthValue, normalValues);
	return fixed4(normalValues, depthValue);
#elif SOURCE_MRT
	return tex2D(Screen_DepthNormalsTexture, UV);
#endif
	return 0;
}
float ScreenDepth(float2 UV)
{
#if SOURCE_UNITY
	float depth = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, UV));
	depth = Linear01Depth(depth);
	return depth;

#elif SOURCE_ZBUFFER
	float4 EncodeDepth = tex2D(Screen_DepthTexture, UV);
	return DecodeFloatRGBA(EncodeDepth);
#elif SOURCE_MRT
	float4 EncodeDepth = tex2D(Screen_DepthTexture, UV);
	return DecodeFloatRGBA(EncodeDepth);
#endif
	return 0;
}
///RGBAM
// RGBM encoding/decoding
half4 EncodeHDR(float3 rgb)
{
	rgb *= 1.0 / 8;
	float m = max(max(rgb.r, rgb.g), max(rgb.b, 1e-6));
	m = ceil(m * 255) / 255;
	return half4(rgb / m, m);
}

float3 DecodeHDR(half4 rgba)
{
	return rgba.rgb * rgba.a * 8;
}