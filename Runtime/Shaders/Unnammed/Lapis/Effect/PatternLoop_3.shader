// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Lapis/Effect/PatternLoop_3"
{
	Properties
	{
		_Texture3("Texture 3", 2D) = "white" {}
		_Texture2("Texture 2", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
		_BPM("BPM", Range( 60 , 300)) = 60
		_Color3("Color 3", Color) = (0.643,0.643,0.643,0)
		_Color2("Color 2", Color) = (0.643,0.643,0.643,0)
		_Color1("Color 1", Color) = (0.643,0.643,0.643,0)
		_IsDouble("IsDouble", Range( 1 , 2)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue"="Transparent+1" }
		LOD 100
		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		Cull Back
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		Offset 0 , 0

		Pass
		{
			Name "Unlit"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_OUTPUT_STEREO
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			uniform sampler2D _Texture1;
			uniform float4 _Texture1_ST;
			uniform float4 _Color1;
			uniform float _BPM;
			uniform float _IsDouble;
			uniform sampler2D _Texture2;
			uniform float4 _Texture2_ST;
			uniform float4 _Color2;
			uniform sampler2D _Texture3;
			uniform float4 _Texture3_ST;
			uniform float4 _Color3;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 finalColor;
				float2 uv_Texture1 = i.ase_texcoord.xy * _Texture1_ST.xy + _Texture1_ST.zw;
				float temp_output_267_0 = ( _Time.y * ( _BPM * 0.01667 * _IsDouble ) );
				float2 uv_Texture2 = i.ase_texcoord.xy * _Texture2_ST.xy + _Texture2_ST.zw;
				float2 uv_Texture3 = i.ase_texcoord.xy * _Texture3_ST.xy + _Texture3_ST.zw;
				
				
				fixed4 color1 = tex2D(_Texture1, uv_Texture1).a * _Color1 * (((sin((temp_output_267_0 + 0.0)) + 1.0) - 1.0) * (1.0 - 0.0) / (2.0 - 1.0));
				fixed4 color2 = tex2D(_Texture2, uv_Texture2).a * _Color2 * (((sin((temp_output_267_0 + (UNITY_PI * 0.667))) + 1.0) - 1.0) * (1.0 - 0.0) / (2.0 - 1.0));
				fixed4 color3 = tex2D(_Texture3, uv_Texture3).a * _Color3 * (((sin((temp_output_267_0 + (UNITY_PI * 1.333))) + 1.0) - 1.0) * (1.0 - 0.0) / (2.0 - 1.0));
				finalColor = color1 + color2 + color3;
				//				finalColor = ( ( tex2D( _Texture1, uv_Texture1 ).a * _Color1 * (0.0 + (( sin( ( temp_output_267_0 + 0.0 ) ) + 1.0 ) - 1.0) * (1.0 - 0.0) / (2.0 - 1.0)) ) + ( tex2D( _Texture2, uv_Texture2 ).a * _Color2 * (0.0 + (( sin( ( temp_output_267_0 + ( UNITY_PI * 0.667 ) ) ) + 1.0 ) - 1.0) * (1.0 - 0.0) / (2.0 - 1.0)) ) + ( tex2D( _Texture3, uv_Texture3 ).a * _Color3 * (0.0 + (( sin( ( temp_output_267_0 + ( UNITY_PI * 1.333 ) ) ) + 1.0 ) - 1.0) * (1.0 - 0.0) / (2.0 - 1.0)) ) );
								//finalColor.a = clamp(finalColor.a, 0, 1);
				//return clamp(finalColor,0,1);
				return saturate(finalColor);
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16100
1920;20;1906;958;738.1959;997.6189;1.90536;True;True
Node;AmplifyShaderEditor.RangedFloatNode;160;-484.2899,-657.1801;Float;False;Property;_BPM;BPM;3;0;Create;True;0;0;False;0;60;120;60;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;269;-415.8448,-396.0861;Float;False;Property;_IsDouble;IsDouble;7;0;Create;True;0;0;False;0;1;1;1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;159;-438.0819,-534.7361;Float;False;Constant;_second;second;4;0;Create;True;0;0;False;0;0.01667;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;158;-439.8263,-877.3075;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;162;-176.8971,-626.6662;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;266;-190.23,231.5478;Float;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;False;0;1.333;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;258;-151.7567,-47.43797;Float;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;0.667;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;256;259.4208,-329.6752;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;259;203.4218,209.4875;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;440.5367,211.1933;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;462.7909,-268.8282;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;267;-29.67284,-445.4487;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;244;494.6093,-769.9109;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;248;595.2751,-394.8248;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;262;593.4973,76.66367;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;246;760.5996,-353.1951;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;264;924.4004,282.2849;Half;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;263;734.5948,133.9521;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;899.2605,-690.9689;Half;False;Constant;_Addone;Add one;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;243;935.9219,-194.5818;Half;False;Constant;_Float5;Float 5;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;154;687.7659,-768.9198;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;234;1119.461,-348.1722;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;203;1150.731,-769.0012;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;265;1117.683,122.3987;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;194;1435.451,-461.0336;Float;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;2;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;163;1313.963,-8.018868;Float;False;Property;_Color2;Color 2;5;0;Create;True;0;0;False;0;0.643,0.643,0.643,0;0.5,0.5280898,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;173;1529.487,694.8013;Float;False;Property;_Color3;Color 3;4;0;Create;True;0;0;False;0;0.643,0.643,0.643,0;0.5,0.5280898,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;172;1517.491,445.3919;Float;True;Property;_Texture3;Texture 3;0;0;Create;True;0;0;False;0;b9f1c2125557bf34c98df0614dff4483;f5f15b5038d058d418e321e9143dd4d3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;199;1513.08,156.3127;Float;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;2;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;155;1244.539,-1326.503;Float;True;Property;_Texture1;Texture 1;2;0;Create;True;0;0;False;0;b9f1c2125557bf34c98df0614dff4483;cd0b543bf334829468b2c418be3d987e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;164;1301.967,-228.6289;Float;True;Property;_Texture2;Texture 2;1;0;Create;True;0;0;False;0;b9f1c2125557bf34c98df0614dff4483;04f8268013c3e5a41a396cbdb1269799;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;156;1349.421,-1105.849;Float;False;Property;_Color1;Color 1;6;0;Create;True;0;0;False;0;0.643,0.643,0.643,0;0.5,0.5280898,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;190;1418.309,-810.4855;Float;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;2;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;2047.718,203.9783;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;1894.789,-414.6919;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;1789.888,-796.2515;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;2079.867,-706.0039;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;191;2693.442,-722.2037;Float;False;True;2;Float;ASEMaterialInspector;0;1;FloorPattern_3;0770190933193b94aaa3065e307002fa;0;0;Unlit;2;True;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;True;0;False;-1;0;False;-1;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;Queue=Transparent=Queue=1;True;2;0;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;162;0;160;0
WireConnection;162;1;159;0
WireConnection;162;2;269;0
WireConnection;260;0;259;0
WireConnection;260;1;266;0
WireConnection;257;0;256;0
WireConnection;257;1;258;0
WireConnection;267;0;158;2
WireConnection;267;1;162;0
WireConnection;244;0;267;0
WireConnection;248;0;267;0
WireConnection;248;1;257;0
WireConnection;262;0;267;0
WireConnection;262;1;260;0
WireConnection;246;0;248;0
WireConnection;263;0;262;0
WireConnection;154;0;244;0
WireConnection;234;0;246;0
WireConnection;234;1;243;0
WireConnection;203;0;154;0
WireConnection;203;1;204;0
WireConnection;265;0;263;0
WireConnection;265;1;264;0
WireConnection;194;0;234;0
WireConnection;199;0;265;0
WireConnection;190;0;203;0
WireConnection;174;0;172;4
WireConnection;174;1;173;0
WireConnection;174;2;199;0
WireConnection;165;0;164;4
WireConnection;165;1;163;0
WireConnection;165;2;194;0
WireConnection;157;0;155;4
WireConnection;157;1;156;0
WireConnection;157;2;190;0
WireConnection;170;0;157;0
WireConnection;170;1;165;0
WireConnection;170;2;174;0
WireConnection;191;0;170;0
ASEEND*/
//CHKSM=6342D31E268A9D6CC0BFEABBA6BF28236A1FD957