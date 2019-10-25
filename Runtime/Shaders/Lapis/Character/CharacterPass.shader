
Shader "Hidden/ShaderLab/Lapis/CharacterPass"
{
	CGINCLUDE
	#include "UnityCG.cginc"
	#include "../../Cgincs/HSLSupport.cginc"
	#include "../../Cgincs/MaterialFX.cginc"
	#include "../../Cgincs/MRTSupport.cginc"
	#pragma multi_compile _ _MODE_DITHER _MODE_DISSOLVE SOURCE_MRT

	struct appdata
	{
		float4 vertex : POSITION;
		fixed2 uv : TEXCOORD0;
		//法线
		fixed3 normal : NORMAL;
		float4 color : COLOR;
		half2 uv1 : TEXCOORD1;

		/*vertInput*/
	};

	struct v2f
	{
		float4 vertex : SV_POSITION;
		fixed2 uv : TEXCOORD0;
		//主光源信息
		fixed nl : TEXCOORD1;
		DITHER_SCREENPOS(2)
		float4 color : COLOR;
		/*vert2Frag*/
		fixed2 uvMask : TEXCOORD3;
		//空间占比
		DISSOLVE_COORDS(4)
			
	};
	
	CONTROLLER_BLOCK
	DISSOLVE_BLOCK
	/*RenderSetup*/
	uniform sampler2D _MainTex;
	uniform float4 _MainTex_ST;
	uniform sampler2D _ShadowTex;
	uniform sampler2D _Ramp;

	uniform sampler2D _Mask;
	uniform float4 _Mask_ST;

	/*PassData*/
	//主像素光
	uniform half4 _LightColor0;
	//描边
	uniform float _OutlineInside;
	uniform fixed4 _OutlineColor;
	ENDCG
	SubShader
	{
		Tags { "RenderType" = "Opaque"}
		Pass
		{
			Tags{ "LightMode" = "ForwardBase" }
			Name "Skin"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

				//法线
				half3 normal = UnityObjectToWorldNormal(v.normal);
				//世界坐标
				half3 posWorld = mul(unity_ObjectToWorld, v.vertex);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(posWorld.xyz);
				o.nl = dot(normal, lightDir)*0.5 + 0.5;
				o.color = v.color;
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{

				DITHER_FRAGMENT(i.ScreenPos,_Control)
				float4 edge = 1; 
				edge = lerp(_OutlineColor,1,step(_OutlineInside /6, i.color.b));
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= edge;
				fixed4 shadow = tex2D(_ShadowTex, i.uv);
				//ramp light
				fixed4 ramp = tex2D(_Ramp, fixed2(i.nl,0));
				ramp = fixed4(ramp.r, ramp.r, ramp.r, ramp.r);
				ramp = BlendDarkenf(ramp, shadow.a);
				ramp = BlendScreenf(ramp, shadow);
				col*= (_LightColor0)*ramp;
				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))

				col.a = 1;
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);
				return o;
			}
			ENDCG
		}
		Pass
		{
			Tags{ "LightMode" = "ForwardBase" }
			Name "Face"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			
			uniform fixed4 _CheekColor;
            uniform float _CheekPower;
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

				//法线
				half3 normal = UnityObjectToWorldNormal(v.normal);
				//世界坐标
				half3 posWorld = mul(unity_ObjectToWorld, v.vertex);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(posWorld.xyz);
				o.nl = dot(normal, lightDir)*0.5 + 0.5;
				o.color = v.color;
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				return o;
			}
			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed3 cheek = 0;
				cheek = (1 - col.a)*_CheekPower;
				col.rgb= lerp(col.rgb, _CheekColor.rgb, cheek);

				fixed4 shadow = tex2D(_ShadowTex, i.uv);
				//ramp light
				fixed4 ramp = tex2D(_Ramp, fixed2(i.nl,0));
				ramp = fixed4(ramp.r, ramp.r, ramp.r, ramp.r);
				ramp = BlendDarkenf(ramp, shadow.a);
				ramp = BlendScreenf(ramp, shadow);
				col*= (_LightColor0)*ramp;

				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))
				col.a = 1;
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);
				return o;
			}
			ENDCG
		}
		Pass
		{  
			Tags{ "LightMode" = "ForwardBase" }
			Name "Eye"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase


			struct v2f_eye
			{
				float4 vertex : SV_POSITION;
				fixed2 uv : TEXCOORD0;
				DITHER_SCREENPOS(2)
				/*vert2Frag*/
				fixed2 uvMask : TEXCOORD3;
				//空间占比
				DISSOLVE_COORDS(4)

			};
			v2f_eye vert(appdata v)
			{
				v2f_eye o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= (_LightColor0);
				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))
				col.a = 1;
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);
				return  o;
			}
			ENDCG
		}
		Pass
		{
			Tags{ "LightMode" = "vertex" }
			Name "Brow"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);
				//法线
				half3 normal = UnityObjectToWorldNormal(v.normal);
				//世界坐标
				half3 posWorld = mul(unity_ObjectToWorld, v.vertex);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(posWorld.xyz);
				o.nl = dot(normal, lightDir)*0.5 + 0.5;
				o.color = v.color;
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				//ramp light
				fixed ramp = tex2D(_Ramp, fixed2(i.nl,0)).r*0.5+0.5;
				col*= (unity_LightColor[0])*ramp;
				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))
				col.a = 1;
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);
				return o;
			}
			ENDCG
		}

	}
}
