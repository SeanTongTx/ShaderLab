/****************GPU Instanced BillBoard *********************/
///注意 "DisableBatching" = "True"   UNITY_SETUP_INSTANCE_ID
///Spherical 
float4 VertexSpherical(float4 vertex,float3 normal)
{
	//Calculate new billboard vertex position and normal;
	float3 upCamVec = normalize(UNITY_MATRIX_V._m10_m11_m12);
	float3 forwardCamVec = -normalize(UNITY_MATRIX_V._m20_m21_m22);
	float3 rightCamVec = normalize(UNITY_MATRIX_V._m00_m01_m02);
	float4x4 rotationCamMatrix = float4x4(rightCamVec, 0, upCamVec, 0, forwardCamVec, 0, 0, 0, 0, 1);
	normal = normalize(mul(float4(normal, 0), rotationCamMatrix));
	vertex.x *= length(unity_ObjectToWorld._m00_m10_m20);
	vertex.y *= length(unity_ObjectToWorld._m01_m11_m21);
	vertex.z *= length(unity_ObjectToWorld._m02_m12_m22);
	vertex = mul(vertex, rotationCamMatrix);
	vertex.xyz += unity_ObjectToWorld._m03_m13_m23;
	//Need to nullify rotation inserted by generated surface shader;
	vertex = mul(unity_WorldToObject, vertex);
	return vertex;
}
//Cylindrical
float4 VertexCylindrical(float4 vertex, float3 normal)
{
	//Calculate new billboard vertex position and normal;
	float3 upCamVec = float3(0, 1, 0);
	float3 forwardCamVec = -normalize(UNITY_MATRIX_V._m20_m21_m22);
	float3 rightCamVec = normalize(UNITY_MATRIX_V._m00_m01_m02);
	float4x4 rotationCamMatrix = float4x4(rightCamVec, 0, upCamVec, 0, forwardCamVec, 0, 0, 0, 0, 1);
	normal = normalize(mul(float4(normal, 0), rotationCamMatrix));
	vertex.x *= length(unity_ObjectToWorld._m00_m10_m20);
	vertex.y *= length(unity_ObjectToWorld._m01_m11_m21);
	vertex.z *= length(unity_ObjectToWorld._m02_m12_m22);
	vertex = mul(vertex, rotationCamMatrix);
	vertex.xyz += unity_ObjectToWorld._m03_m13_m23;
	//Need to nullify rotation inserted by generated surface shader;
	vertex = mul(unity_WorldToObject, vertex);
	return vertex;
}
//根据距离 缩放顶点
float4 vertexDepthScale(float4 vertex)
{
	float depth = -(UnityObjectToViewPos(vertex).z * _ProjectionParams.w);
	vertex.xyz *=saturate(depth*10);
	return vertex;
}
/******************************************/