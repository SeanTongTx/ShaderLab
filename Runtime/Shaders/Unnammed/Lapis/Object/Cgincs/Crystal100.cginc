﻿#include "UnityCG.cginc"
#include "../../../Cgincs/MRTSupport.cginc"

struct appdata
{
	float4 vertex : POSITION;
	float2 texcoord : TEXCOORD0;
	UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct v2f 
{
	float4 vertex : SV_POSITION;
	float2 texcoord : TEXCOORD0;
	UNITY_FOG_COORDS(1)
		UNITY_VERTEX_OUTPUT_STEREO
};

sampler2D _MainTex;
float4 _MainTex_ST;
float4 _Color;

v2f vert(appdata v)
{
	v2f o;
	UNITY_SETUP_INSTANCE_ID(v);
	UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
	UNITY_TRANSFER_FOG(o, o.vertex);
	return o;
}

fixed4 frag(v2f i) : SV_Target
{
	fixed4 col = tex2D(_MainTex, i.texcoord)*_Color;
	UNITY_APPLY_FOG(i.fogCoord, col);
	UNITY_OPAQUE_ALPHA(col.a);
	return col;
}