//RGBM ���� ������32λrgba�д洢 hdr��ɫ��Ϣ
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

//MRT ���ݼ�
//3��pipline ����
//#pragma multi_compile SOURCE_UNITY SOURCE_ZBUFFER SOURCE_MRT
//HDR�ؼ��� MRT_COLORHDR  
#if SOURCE_MRT
	struct MRTOut
	{
		fixed4 color : SV_Target0;//������ɫ
		fixed4 colorHDR : SV_Target1;//HDR��ɫ
	};
#define FRAG_OUT_TYPE MRTOut 
#define SETUP_COLOR(o,col) o.color=col;
#define SETUP_COLORHDR(o,col) o.colorHDR=EncodeHDR(col-1);

#else
#define FRAG_OUT_TYPE fixed4
#define SETUP_COLOR(o,col) o=col;
#define SETUP_COLORHDR(o,col) ;
#endif