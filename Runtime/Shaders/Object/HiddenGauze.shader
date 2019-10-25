
Shader "Hidden/ShaderLab/Object/Gauze"
{
	Properties
	{
		_MainTex("MainTex",2D) = ""{}
		_Ramp("Ramp",2D) = ""{}
		[NoScaleOffset]_ShadowTex("Shadow",2D) = ""{}
		_Alpha("Alpha",Range(0,1)) = 0
		[Enum(Strong,20,Normal,12,Weak,6)] _RimPower("Rim Power", float) = 12
		_Gloss("Gloss",Range(0,1)) = 0.5
		/*Properties*/
	}
	CGINCLUDE
	#include "UnityCG.cginc"
	#include "../Cgincs/HSLSupport.cginc"
	#include "../Cgincs/MaterialFX.cginc"
	#include "../Cgincs/MRTSupport.cginc"
	#pragma multi_compile _ _MODE_DITHER _MODE_DISSOLVE SOURCE_MRT
	//Texture
	uniform sampler2D _MainTex;
	uniform float4 _MainTex_ST;

	/*RenderSetup*/
	sampler2D _ShadowTex;
	sampler2D _Ramp;
	float4 _Ramp_ST;
	float _Alpha;
	float _RimPower;
	//描边
	uniform float _OutlineInside;
	uniform fixed4 _OutlineColor;

	CONTROLLER_BLOCK
	DISSOLVE_BLOCK
		
	//主像素光
	uniform half4 _LightColor0;
	uniform sampler2D _Mask;
	uniform float4 _Mask_ST;

	struct appdata
	{
		float4 vertex : POSITION;
		//Texture
		half2 uv : TEXCOORD0;
		fixed3 normal : NORMAL;
		float4 color : COLOR;
		half2 uv1 : TEXCOORD1;
		/*vertInput*/
	};

	struct appdata_200
	{
		float4 vertex : POSITION;
		//Texture
		half2 uv : TEXCOORD0;
		fixed3 normal : NORMAL;
		/*vertInput*/
	};

	struct v2f
	{
		float4 vertex : SV_POSITION;
		//Texture
		float2 uv : TEXCOORD0;
		fixed3 normal : NORMAL;
		float4 posWorld : TEXCOORD1;
		half3 view : TEXCOORD2;
		float2 Ramp_uv : TEXCOORD3;
		float4 color : COLOR;
		DITHER_SCREENPOS(4)
		DISSOLVE_COORDS(5)
		float2 uvMask : TEXCOORD6;
		/*vert2Frag*/
	};
	struct v2f_400
	{
		float4 vertex : SV_POSITION;
		//Texture
		float2 uv : TEXCOORD0;
		fixed3 normal : NORMAL;
		float4 posWorld : TEXCOORD1;
		float2 Ramp_uv : TEXCOORD2;
		float4 color : COLOR;
		DITHER_SCREENPOS(3)
		DISSOLVE_COORDS(4)
		float2 uvMask : TEXCOORD5;
		/*vert2Frag*/
	};
	struct v2f_200
	{
		float4 vertex : SV_POSITION;
		//Texture
		float2 uv : TEXCOORD0;
		fixed3 normal : NORMAL;
		float4 posWorld : TEXCOORD1;
		float2 Ramp_uv : TEXCOORD2;
		/*vert2Frag*/
	};
	ENDCG
	SubShader
	{
		Tags { "RenderType" = "Opaque" "Queue" = "Transparent"  }
		//500
		Pass
		{
			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
			zwrite on
			Cull front
			Tags { "LightMode" = "ForwardBase"  }
			Name "Gauze_back"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			/*PassData*/
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//背面
				o.normal = -v.normal;
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				o.view = ObjSpaceViewDir(v.vertex);
				//Texture

				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.Ramp_uv = TRANSFORM_TEX(v.uv, _Ramp);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

				o.color = v.color;
				
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				/*vertCode*/
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				/*fragCode*/
				//Texture
				fixed4 col = tex2D(_MainTex, i.uv);
				float4 edge = 1;
				edge = lerp(_OutlineColor, 1, step(_OutlineInside / 6, i.color.b));
				col.rgb *= edge;
				fixed4 shadow = tex2D(_ShadowTex, i.uv);
				//法线
				fixed3 normal = normalize(i.normal);
				fixed3 view = normalize(i.view);
				//世界坐标
				float4 worldPostion = i.posWorld;
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(i.posWorld.xyz);

				half nl = dot(normal, lightDir)*0.5 + 0.5;
				//边缘光
				half nv =  dot(view, normal);

				half ref = saturate(dot(-reflect(lightDir, normal), view));

				fixed4 ramp = tex2D(_Ramp, fixed2(nl, 0));
				ramp = ramp.r;
				ramp = BlendDarkenf(ramp, shadow.a);
				ramp = BlendScreenf(ramp, shadow);
				col.rgb *= _LightColor0* (ramp+(1-col.a)*ref);
				half Fresnel = saturate(1-pow(nv, _RimPower/10));
				Fresnel = lerp(Fresnel, 1, col.a);

				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))

				col.a = lerp(_Alpha*ref, 1, Fresnel);
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
			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha

			zwrite on
			Cull back
			Tags { "LightMode" = "ForwardBase"  }
			Name "Gauze_front"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//背面
				o.normal = v.normal;
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				o.view = ObjSpaceViewDir(v.vertex);
				//Texture

				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.Ramp_uv = TRANSFORM_TEX(v.uv, _Ramp);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

				o.color = v.color;
				
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				/*vertCode*/
				return o;
			}
			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				/*fragCode*/
				//Texture
				fixed4 col = tex2D(_MainTex, i.uv);
				float4 edge = 1;
				edge = lerp(_OutlineColor, 1, step(_OutlineInside / 6, i.color.b));
				col.rgb *= edge;
				fixed4 shadow = tex2D(_ShadowTex, i.uv);
				//法线
				fixed3 normal = normalize(i.normal);
				fixed3 view = normalize(i.view);
				//世界坐标
				float4 worldPostion = i.posWorld;
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(i.posWorld.xyz);

				half nl = dot(normal, lightDir)*0.5 + 0.5;
				//边缘光
				half nv =  dot(view, normal);

				half ref = saturate(dot(-reflect(lightDir, normal), view));

				fixed4 ramp = tex2D(_Ramp, fixed2(nl, 0));
				ramp = ramp.r;
				ramp = BlendDarkenf(ramp, shadow.a);
				ramp = BlendScreenf(ramp, shadow);
				col.rgb *= _LightColor0* (ramp+(1-col.a)*ref);
				half Fresnel = saturate(1-pow(nv, _RimPower/10));
				Fresnel = lerp(Fresnel, 1, col.a);

				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))

				col.a = lerp(_Alpha*ref, 1, Fresnel);

				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);

				return o;
			}
			ENDCG
		}

		//400
		
		Pass
		{
			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
			zwrite on
			Cull front
			Tags { "LightMode" = "ForwardBase"  }
			Name "Gauze_back_400"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			/*PassData*/
			v2f_400 vert(appdata v)
			{
				v2f_400 o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//背面
				o.normal = -v.normal;
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				//Texture
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.Ramp_uv = TRANSFORM_TEX(v.uv, _Ramp);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

				o.color = v.color;
				
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				/*vertCode*/
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				/*fragCode*/
				//Texture
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 shadow = tex2D(_ShadowTex, i.uv);
				//法线
				fixed3 normal = normalize(i.normal);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(i.posWorld.xyz);
				half nl = dot(normal, lightDir)*0.5 + 0.5;
				fixed4 ramp = tex2D(_Ramp, fixed2(nl, 0));
				ramp = ramp.r;
				ramp = BlendDarkenf(ramp, shadow.a);
				ramp = BlendScreenf(ramp, shadow);
				col.rgb *= _LightColor0* (ramp);
				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))

				col.a = lerp(col.a, 1, _Alpha);
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
			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha

			zwrite on
			Cull back
			Tags { "LightMode" = "ForwardBase"  }
			Name "Gauze_front_400"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			v2f_400 vert(appdata v)
			{
				v2f_400 o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//背面
				o.normal = v.normal;
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				//Texture
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.Ramp_uv = TRANSFORM_TEX(v.uv, _Ramp);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

				o.color = v.color;
				
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				/*vertCode*/
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				/*fragCode*/
				//Texture
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 shadow = tex2D(_ShadowTex, i.uv);
				//法线
				fixed3 normal = normalize(i.normal);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(i.posWorld.xyz);
				half nl = dot(normal, lightDir)*0.5 + 0.5;
				fixed4 ramp = tex2D(_Ramp, fixed2(nl, 0));
				ramp = ramp.r;
				ramp = BlendDarkenf(ramp, shadow.a);
				ramp = BlendScreenf(ramp, shadow);
				col.rgb *= _LightColor0* (ramp);
				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))

				col.a = lerp(col.a, 1, _Alpha);
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);

				return o;
			}
			ENDCG
		}
		//300
		Pass
		{
			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha

			zwrite on
			Cull OFF
			Tags { "LightMode" = "ForwardBase"  }
			Name "Gauze_300"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			v2f_400 vert(appdata v)
			{
				v2f_400 o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//背面
				o.normal = v.normal;
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				//Texture
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.Ramp_uv = TRANSFORM_TEX(v.uv, _Ramp);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);

				o.color = v.color;
				
				DITHER_VERTEX(o,o.vertex)
				DISSOLVE_VERTEX(o)
				/*vertCode*/
				return o;
			}

			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				/*fragCode*/
				//Texture
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 shadow = tex2D(_ShadowTex, i.uv);
				//法线
				fixed3 normal = normalize(i.normal);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(i.posWorld.xyz);
				half nl = dot(normal, lightDir)*0.5 + 0.5;
				fixed4 ramp = tex2D(_Ramp, fixed2(nl, 0));
				ramp = ramp.r;
				ramp = BlendDarkenf(ramp, shadow.a);
				ramp = BlendScreenf(ramp, shadow);
				col.rgb *= _LightColor0* (ramp);
				DISSOLVE_FRAGMENT(i, _Control, col, tex2D(_Mask, i.uvMask))

				col.a = lerp(col.a, 1, _Alpha);
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);

				return o;
			}
			ENDCG
		}
		//200
				
		Pass
		{
			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha

			zwrite on
			Cull OFF
			Tags { "LightMode" = "ForwardBase"  }
			Name "Gauze_200"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			v2f_200 vert(appdata_200 v)
			{
				v2f_200 o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//背面
				o.normal = v.normal;
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				//Texture
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.Ramp_uv = TRANSFORM_TEX(v.uv, _Ramp);

				/*vertCode*/
				return o;
			}
			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				/*fragCode*/
				//Texture
				fixed4 col = tex2D(_MainTex, i.uv);
				//法线
				fixed3 normal = normalize(i.normal);
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(i.posWorld.xyz);
				half nl = dot(normal, lightDir)*0.5 + 0.5;
				fixed4 ramp = tex2D(_Ramp, fixed2(nl, 0));
				ramp = ramp.r*0.3+0.7;
				col.rgb *= _LightColor0* (ramp);
				col.a = lerp(col.a, 1, _Alpha);
				//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, col);
				//MRT/HDR
				SETUP_COLORHDR(o, col);

				return o;
			}
			ENDCG
		}
		//min
				
		Pass
		{
			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha

			zwrite on
			Cull OFF
			Tags { "LightMode" = "Vertex"  }
			Name "Gauze_100"
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			struct appdata_100
			{
				float4 vertex : POSITION;
				fixed2 uv : TEXCOORD0;
			};

			struct v2f_100
			{
				float4 vertex : SV_POSITION;
				fixed2 uv : TEXCOORD0;
			};
			v2f_100 vert(appdata_100 v)
			{
				v2f_100 o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				/*vertCode*/
				return o;
			}
			FRAG_OUT_TYPE frag(v2f i) : SV_Target
			{
				/*fragCode*/
				//Texture
				fixed4 col = tex2D(_MainTex, i.uv);
				col*= (unity_LightColor[0]);
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
