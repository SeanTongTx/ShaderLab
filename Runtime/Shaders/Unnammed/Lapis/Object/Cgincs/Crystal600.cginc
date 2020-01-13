#include "UnityCG.cginc"
#include "../../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	float2 uv : TEXCOORD0;
	fixed3 normal : NORMAL;
	float4 tangent : TANGENT;
};

struct v2f
{
	float4 vertex : SV_POSITION;
	float2 uv : TEXCOORD0;
	float4 vertColor : COLOR;
	UNITY_FOG_COORDS(1)
	float3 worldRef : TEXCOORD2;
	float3 view : TEXCOORD3;
};

sampler2D _MainTex;
float4 _MainTex_ST;
sampler2D _HeightTex;

samplerCUBE _CubeMap;
uniform half4 _CubeMap_HDR;

uniform float4 _EmissionColor;
uniform float4 _Color;
uniform fixed _Smooth;

float _Parallax;

v2f vert(appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	//反射
	half3 worldPos = mul(unity_ObjectToWorld, v.vertex);
	half3 worldNormal = UnityObjectToWorldNormal(v.normal);
	half3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos.xyz));
	o.worldRef = reflect(-worldViewDir, normalize(worldNormal));
	//视差
	TANGENT_SPACE_ROTATION;
	o.view = mul(rotation, ObjSpaceViewDir(v.vertex).xyz);

	UNITY_TRANSFER_FOG(o, o.vertex);
	return o;
}

FRAG_OUT_TYPE frag(v2f i) : SV_Target
{
	half4 col = tex2D(_MainTex, i.uv);
	// sample the texture
	fixed4 heightCol = tex2D(_HeightTex, i.uv);
	//反射率
	fixed3 cubecol = DecodeHDR(texCUBE(_CubeMap, i.worldRef + heightCol.r),_CubeMap_HDR);
	//反射 albedo
	col.rgb = lerp(col.rgb, 2.0 * col.rgb * cubecol + col.rgb * col.rgb * (1.0 - 2.0 * cubecol), _Smooth)*_Color;

	//高度
	fixed height = heightCol.g*0.5;
	//视差 深度
	half2 offset = ParallaxOffset(height, _Parallax, i.view);
	float2 uv = i.uv + offset;
	fixed4 parallax = tex2D(_HeightTex, uv);
	//内发光
	//col += (heightCol.b*(parallax.g + heightCol.r))*_EmissionColor;
	col += col;
	
	// apply fog
	UNITY_APPLY_FOG(i.fogCoord, col);
	//MRT/Core
	FRAG_OUT_TYPE o;
	SETUP_COLOR(o, col);
	//MRT/HDR
	SETUP_COLORHDR(o, col);

	return o;
}