
Shader "Screen/SeanGrabPass"
{
	Properties
	{
		_MaskTex("MaskTex", 2D) = "white" {}
		_MeshRatio("MeshRatio",vector)=(1,1,0,0)
		_ValueGrabPass("ValueGrabPass", Range(0,5)) = 1
		/*Properties*/
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque"  }
		LOD 100
		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Cull Off

		Pass
		{
			
		    Tags { "ForceNoShadowCasting" = "True"  }
			Name "GrabPass"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			/*RenderSetup*/
			
			sampler2D _MaskTex;
			float4 _MaskTex_ST;
			fixed _ValueGrabPass;
			sampler2D _SeanGlobleGrab;
			float4 _SeanGlobleGrab_ST;
			fixed4 _MeshRatio;
			/*PassData*/
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv0 : TEXCOORD0;
				/*vertInput*/
			};
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
				/*vert2Frag*/
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv0, _MaskTex);
				//TRANSFORM_TEX(tex,name) (tex.xy * name##_ST.xy + name##_ST.zw)
				//uv缩放 x=meshW/screenW y=1 ,z=0 w=0
				float4 ratio= _MeshRatio / _SeanGlobleGrab_ST;
				o.uv1 = v.uv0*(fixed2(ratio.x, ratio.y)) + _MeshRatio.zw;// _SeanGlobleGrab_ST.zw;
				#if UNITY_UV_STARTS_AT_TOP
					o.uv1 = o.uv1;
				#else
					o.uv1 = float2(o.uv1.x, 1 - o.uv1.y);
				#endif
				/*vertCode*/
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				/*fragCode*/
				fixed4 col = tex2D(_MaskTex, i.uv)* tex2D(_SeanGlobleGrab, i.uv1)*_ValueGrabPass;
				return col;
			}
			ENDCG
		}
		/*Passes*/

	}
	/*SubShader*/

}
