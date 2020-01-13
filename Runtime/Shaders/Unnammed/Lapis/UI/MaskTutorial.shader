// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Lapis/UI/Tutorial Mask"
{
	Properties
	{
		[PerRendererData] _MainTex("Background", 2D) = "white" { }
		_EmptyRange("Range", Vector) = (0,0,0,0)
		_Alpha("Alpha", float) = 0.25
		_Distance("Distance", float) = 1.0

		[HideInInspector]_StencilComp("Stencil Comparison", Float) = 8
		[HideInInspector]_Stencil("Stencil ID", Float) = 0
		[HideInInspector]_StencilOp("Stencil Operation", Float) = 0
		[HideInInspector]_StencilWriteMask("Stencil Write Mask", Float) = 255
		[HideInInspector]_StencilReadMask("Stencil Read Mask", Float) = 255

		[HideInInspector]_ColorMask("Color Mask", Float) = 15
	}
		SubShader
		{
			LOD 200

			Tags
			{
				"Queue" = "Transparent"
				"IgnoreProjector" = "True"
				"RenderType" = "Transparent"
				"PreviewType" = "Plane"
				"CanUseSpriteAtlas" = "True"
			}

			Stencil
			{
				Ref[_Stencil]
				Comp[_StencilComp]
				Pass[_StencilOp]
				ReadMask[_StencilReadMask]
				WriteMask[_StencilWriteMask]
			}

			Cull Off
			Lighting Off
			ZWrite Off
			Fog { Mode Off }
			Offset -1, -1
			Blend SrcAlpha OneMinusSrcAlpha

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				sampler2D _MainTex;
				float4 _EmptyRange;
				float _Alpha;
				float _Distance;

				struct appdata_t
				{
					float4 vertex : POSITION;
					half4 color : COLOR;
					float2 texcoord : TEXCOORD0;
				};

				struct v2f
				{
					float4 vertex : POSITION;
					half4 color : COLOR;
					float2 texcoord : TEXCOORD0;
				};

				float4 _MainTex_ST;
				v2f vert(appdata_t v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.color = v.color;
					o.texcoord = v.texcoord;
					return o;
				}

				half4 frag(v2f IN) : COLOR
				{
					// Sample the texture
					half4 col = tex2D(_MainTex, IN.texcoord) * IN.color;

					bool show = true;

					float a = _EmptyRange.z;
					float b = _EmptyRange.w;

					float x_div_a = a != 0 ? (IN.texcoord.x - _EmptyRange.x) / abs(a) : 1;
					float y_div_b = a != 0 ? (IN.texcoord.y - _EmptyRange.y) / abs(b) : 1;

					float dis = x_div_a * x_div_a + y_div_b * y_div_b;
					show = dis > _Distance;

					col.a = show ? _Alpha : _Alpha * sqrt(dis);
					return col;
				}
				ENDCG
			}
		}
}