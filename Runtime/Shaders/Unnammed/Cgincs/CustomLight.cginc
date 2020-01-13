//完全自定义光照
//a 点光源范围
uniform float4 P_Light1_pos;
//a 强度
uniform float4 P_Light1_col;

uniform float4 P_Light2_pos;
uniform float4 P_Light2_col;
//a =intensity
//PointLight
//
inline half3 Lambert(half3 worldNormal, half3 worldPos,half4 lightPos,half4 LightColor)
{
	if (lightPos.a < 0)
	{
		fixed3 dir = -lightPos.xyz;
		fixed diff = max(0, dot(worldNormal, normalize(dir)));
		half3 c = half3(LightColor.rgb * LightColor.a) * diff;
		return c;
	}
	else
	{
		fixed3 dir = lightPos - worldPos;
		fixed len = distance(lightPos.xyz, worldPos) + 1;
		fixed diff = max(0, dot(worldNormal, normalize(dir)));
		half3 c = half3(LightColor.rgb * LightColor.a) * diff * lerp(1, 0, saturate(len - lightPos.a));
		return c;
	}
}

#define LAMBERT_LIGHT1(normal,pos) Lambert(normal,pos,P_Light1_pos,P_Light1_col);
#define LAMBERT_LIGHT2(normal,pos) Lambert(normal,pos,P_Light2_pos,P_Light2_col);