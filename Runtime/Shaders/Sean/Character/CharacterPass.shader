
Shader "Hidden/ShaderLab/Sean/CharacterPass"
{
	CGINCLUDE
	#include "UnityCG.cginc"
	#include "../../Cgincs/HSLSupport.cginc"
	#include "../../Cgincs/Debug.cginc"
	#include "../../Cgincs/MaterialFX.cginc"
	#pragma multi_compile _ _MODE_DITHER _MODE_DISSOLVE
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
			Name "Skin_Rim"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase

			float _RimPower;
			float _Gloss;
			struct v2f_Rim
			{
				float4 vertex : SV_POSITION;
				fixed2 uv : TEXCOORD0;
				//主光源信息
				DITHER_SCREENPOS(1)
				float4 color : COLOR;
				//法线
				fixed3 normal : NORMAL;
				//世界坐标
				float4 posWorld : TEXCOORD2;
				//边缘光
				half3 view : TEXCOORD3;
				DISSOLVE_COORDS(4)
					
				fixed2 uvMask : TEXCOORD5;
				/*vert2Frag*/
			};
			v2f_Rim vert(appdata v)
			{
				v2f_Rim o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvMask = TRANSFORM_TEX(v.uv, _Mask);
				//法线
				half3 normal = UnityObjectToWorldNormal(v.normal);
				o.normal = normal;
				//世界坐标
				half4 posWorld = mul(unity_ObjectToWorld, v.vertex);
				o.posWorld = posWorld;
				DITHER_VERTEX(o,o.vertex)
				o.color = v.color;
				//视线方向
				o.view = UnityWorldSpaceViewDir(posWorld.xyz);
				DISSOLVE_VERTEX(o)

				return o;
			}
			fixed4 frag (v2f_Rim i) : SV_Target
			{
				DITHER_FRAGMENT(i.ScreenPos,_Control)
				//法线
				fixed3 normal = i.normal;
				//世界坐标
				float4 worldPostion = i.posWorld;
				//主光源信息
				half3 lightDir = UnityWorldSpaceLightDir(i.posWorld.xyz);

				half nl = dot(normal, lightDir)*0.5 + 0.5;
				//同向为1负为0
				half vl = dot(normalize(i.view), normalize(lightDir));
				//边缘光
				//sss
				half nv = dot(normalize(i.view), normalize(i.normal));
				nv = pow(nv, _RimPower / 10);
				nv = lerp(nl+ _Gloss -nv,nl*nv, vl);// lerp(nl - nv, nl + nv, vl);
				nv = saturate(nv);

				float4 edge = 1; 
				edge = lerp(_OutlineColor,1,step(_OutlineInside /6, i.color.b));
				/*fragCode*/
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= edge;
				fixed4 shadow = tex2D(_ShadowTex, i.uv);
				//ramp light
				fixed4 ramp = tex2D(_Ramp, fixed2(nv,0));

				ramp = BlendDarkenf(ramp, shadow.a);
				ramp = BlendScreenf(ramp, shadow);
				col*= (_LightColor0)*ramp;
				DISSOLVE_FRAGMENT(i, _Control,col, tex2D(_Mask, i.uvMask))
				#if defined(DEBUG_MODE_ON)
				switch (_Debug)
				{
					case 0:return half4(col.rgb,1);
					case 1:return shadow.a;
					case 2:return ramp;
					case 3:return nv;
					case 4:return i.color;
					case 5:return half4(i.uv,0,0);
				}
				#endif
				return half4(col.rgb,1);
			}
			ENDCG
		}
		/*Passes*/
	}

}
