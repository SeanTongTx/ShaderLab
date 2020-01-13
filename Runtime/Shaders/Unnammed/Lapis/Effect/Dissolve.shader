// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Lapis/Effect/Dissolve"
{
	Properties
	{
		_MainTexture("MainTexture", 2D) = "white" {}
		_DissolutionTexture("Dissolution Texture", 2D) = "white" {}
		[HDR]_MainColor("Main Color", Color) = (1,1,1,0)
		[HDR]_OutlineColor("Outline Color", Color) = (0.2688679,0.3149669,1,0)
		_OutlineRange("Outline Range", Range( 0 , 1)) = 0.02548835
		_OutlineEmission("Outline Emission", Range( 0 , 3)) = 0.9008209
		_DissolutionIntensity("Dissolution Intensity", Range( 0 , 1)) = 0.2876917
		_Speed("Speed", Vector) = (0,0,0,0)
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
			};

			uniform float4 _MainColor;
			uniform sampler2D _MainTexture;
			uniform float4 _Speed;
			uniform float _DissolutionIntensity;
			uniform sampler2D _DissolutionTexture;
			uniform float _OutlineRange;
			uniform float4 _OutlineColor;
			uniform float _OutlineEmission;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				float2 uv055 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 UV72 = uv055;
				float Time70 = _Time.y;
				float2 appendResult65 = (float2(_Speed.z , _Speed.w));
				float2 ZW68 = appendResult65;
				float4 tex2DNode1 = tex2D( _MainTexture, ( UV72 + ( Time70 * ZW68 ) ) );
				float Dissolution_Intensity19 = _DissolutionIntensity;
				float2 appendResult63 = (float2(_Speed.x , _Speed.y));
				float Dissolution_R14 = tex2D( _DissolutionTexture, ( uv055 + ( appendResult63 * _Time.y ) ) ).r;
				float ifLocalVar3 = 0;
				if( Dissolution_Intensity19 >= Dissolution_R14 )
				ifLocalVar3 = 1.0;
				else
				ifLocalVar3 = 0.0;
				float Dissolution_Part_A24 = ifLocalVar3;
				float ifLocalVar10 = 0;
				if( Dissolution_Intensity19 >= ( Dissolution_R14 + _OutlineRange ) )
				ifLocalVar10 = 1.0;
				else
				ifLocalVar10 = 0.0;
				float temp_output_7_0 = ( Dissolution_Part_A24 - ifLocalVar10 );
				float4 Outline_Colorg41 = ( temp_output_7_0 * _OutlineColor * _OutlineEmission );
				float Opactiy39 = ( tex2DNode1.a * ( Dissolution_Part_A24 + temp_output_7_0 ) );
				
				
				finalColor = ( ( ( _MainColor * tex2DNode1 ) + ( tex2DNode1.a * Outline_Colorg41 ) ) * ( Opactiy39 * i.ase_color.a ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17000
-1938;62;1906;1004;4029.38;802.9138;1.781814;True;True
Node;AmplifyShaderEditor.Vector4Node;58;-3559.685,171.874;Float;False;Property;_Speed;Speed;7;0;Create;True;0;0;False;0;0,0,0,0;0.65,0.61,0.66,0.82;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;63;-3292.832,121.7056;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;61;-3200.46,223.8297;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-3205.635,-33.96155;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-3000.832,117.7056;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-2790.196,93.70557;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;44;-2367.201,159.44;Float;False;645;362;;4;2;14;19;4;Dissolution Intensity;0.9716981,0.1420879,0.1420879,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-2344.822,203.2357;Float;False;Property;_DissolutionIntensity;Dissolution Intensity;6;0;Create;True;0;0;False;0;0.2876917;0.102;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-2347.649,303.7481;Float;True;Property;_DissolutionTexture;Dissolution Texture;1;0;Create;True;0;0;False;0;0b5238a58ec15f6489f3d8fb3f2b554a;72f49c1fa4bbeb446ad45dc25d4f07e3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1957.474,325.9015;Float;False;Dissolution_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;45;-2381.609,580.9886;Float;False;1138;386;利用Dissolution Texture的R通道与一个浮点值进行对比。若浮点值大于等于该图像的像素，则输出1，小于则输出0。;5;24;3;6;20;5;Dissolution Part A;0.8207547,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;46;-2388.533,1038.224;Float;False;1141.002;309.2808;与Dissolution Part A同理，但是在Dissolution Texture的R通道对比前增加了一个可控的浮点值。这部分将作为溶解边缘来控制;7;10;23;21;22;8;9;16;Dissolution Part B;0.6886792,0,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-1997.129,202.7019;Float;False;Dissolution_Intensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2327.149,780.0007;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2318.762,868.5062;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-2361.467,627.7648;Float;False;19;Dissolution_Intensity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-2314.14,1163.789;Float;False;14;Dissolution_R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-2642.467,668.7648;Float;True;14;Dissolution_R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2340.09,1262.988;Float;False;Property;_OutlineRange;Outline Range;4;0;Create;True;0;0;False;0;0.02548835;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;3;-1974.903,681.6843;Float;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-2030.284,1145.701;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;65;-3298.269,306.4624;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1778.54,1274.808;Float;False;Constant;_Float3;Float 3;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-2346.589,1083.817;Float;False;19;Dissolution_Intensity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1776.54,1193.808;Float;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-1672.843,682.3079;Float;True;Dissolution_Part_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;48;-1174.559,550.863;Float;False;628.4541;425.3349;将Part A与Part B相减，多出一条轮廓线，这条线将叠加到原Part A上作为描边。;4;7;12;25;52;Outline;1,0,0,1;0;0
Node;AmplifyShaderEditor.ConditionalIfNode;10;-1509.528,1097.458;Float;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-3111.542,427.4851;Float;False;ZW;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-3094.286,336.8936;Float;False;Time;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;-2854.145,-41.29049;Float;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-1161.319,600.0009;Float;False;24;Dissolution_Part_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;49;-1185.677,1042.249;Float;False;893.3362;335.2941;;5;41;47;28;29;27;Outline Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1880.644,-95.93311;Float;False;70;Time;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-1138.625,739.7324;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;-1874.893,-13.96936;Float;False;68;ZW;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1170.069,1273.731;Float;False;Property;_OutlineEmission;Outline Emission;5;0;Create;True;0;0;False;0;0.9008209;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1676.282,-67.05207;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-785.407,609.7781;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-1877.768,-182.2108;Float;False;72;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;47;-835.6603,1279.719;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;67;-1400.206,-74.98991;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;51;-1109.565,-253.0858;Float;False;669.4;417.2;控制主贴图的颜色;3;1;30;32;Main Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;52;-593.8666,577.2147;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;-1167.841,1092.139;Float;False;Property;_OutlineColor;Outline Color;3;1;[HDR];Create;True;0;0;False;0;0.2688679,0.3149669,1,0;0,0.1681619,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-747.5637,1092.832;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;53;-1086.422,228.1739;Float;False;614.7999;265.1001;将Main Texture与溶解结果相乘，获得Main Texture的遮罩，最终决定显示那些像素。;2;39;34;Opacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;50;-1165.914,458.1157;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1079.943,-30.36473;Float;True;Property;_MainTexture;MainTexture;0;0;Create;True;0;0;False;0;383f86cde7cf78d4bb4e3eeb6ab2d397;a0b72600572fe8d46b24ec2ead47fe85;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;54;-291.1038,4.819336;Float;False;621.0865;263.4153;把Outline Color所得的像素与主贴图相乘，最终与主贴图相加。;2;42;37;Outline Color Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-526.8132,1092.749;Float;True;Outline_Colorg;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-1031.382,268.9427;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-242.8932,160.392;Float;False;41;Outline_Colorg;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;32;-1080.321,-203.0574;Float;False;Property;_MainColor;Main Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.4039216,0.5860129,0.9803922,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-777.7891,264.973;Float;False;Opactiy;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-648.5951,-197.3805;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;55.65383,51.46606;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;444.8403,-21.23932;Float;True;39;Opactiy;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;75;454.61,173.8703;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;38;729.6281,-193.9901;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;729.722,169.4539;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;1051.802,107.3004;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;82;1323.641,112.3305;Float;False;True;2;Float;ASEMaterialInspector;0;1;Lapis/Effect/Dissolve;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;2;5;False;-1;10;False;-1;0;1;False;-1;1;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;63;0;58;1
WireConnection;63;1;58;2
WireConnection;59;0;63;0
WireConnection;59;1;61;0
WireConnection;64;0;55;0
WireConnection;64;1;59;0
WireConnection;2;1;64;0
WireConnection;14;0;2;1
WireConnection;19;0;4;0
WireConnection;3;0;20;0
WireConnection;3;1;18;0
WireConnection;3;2;5;0
WireConnection;3;3;5;0
WireConnection;3;4;6;0
WireConnection;8;0;16;0
WireConnection;8;1;9;0
WireConnection;65;0;58;3
WireConnection;65;1;58;4
WireConnection;24;0;3;0
WireConnection;10;0;21;0
WireConnection;10;1;8;0
WireConnection;10;2;22;0
WireConnection;10;3;22;0
WireConnection;10;4;23;0
WireConnection;68;0;65;0
WireConnection;70;0;61;0
WireConnection;72;0;55;0
WireConnection;7;0;24;0
WireConnection;7;1;10;0
WireConnection;66;0;71;0
WireConnection;66;1;69;0
WireConnection;12;0;25;0
WireConnection;12;1;7;0
WireConnection;47;0;29;0
WireConnection;67;0;73;0
WireConnection;67;1;66;0
WireConnection;52;0;12;0
WireConnection;28;0;7;0
WireConnection;28;1;27;0
WireConnection;28;2;47;0
WireConnection;50;0;52;0
WireConnection;1;1;67;0
WireConnection;41;0;28;0
WireConnection;34;0;1;4
WireConnection;34;1;50;0
WireConnection;39;0;34;0
WireConnection;30;0;32;0
WireConnection;30;1;1;0
WireConnection;37;0;1;4
WireConnection;37;1;42;0
WireConnection;38;0;30;0
WireConnection;38;1;37;0
WireConnection;76;0;40;0
WireConnection;76;1;75;4
WireConnection;100;0;38;0
WireConnection;100;1;76;0
WireConnection;82;0;100;0
ASEEND*/
//CHKSM=292C909A91E34DEF748C8DEA9E4F3FE02102AB11