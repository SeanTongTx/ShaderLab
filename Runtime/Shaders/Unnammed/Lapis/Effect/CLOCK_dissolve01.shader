// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33977,y:32942,varname:node_3138,prsc:2|emission-7663-OUT,alpha-6453-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:33020,y:32319,ptovrint:False,ptlb:MainTextureColor,ptin:_MainTextureColor,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:342,x:29672,y:33372,ptovrint:False,ptlb:Main_Mask,ptin:_Main_Mask,varname:node_342,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-85-OUT;n:type:ShaderForge.SFN_Power,id:4928,x:29906,y:33455,varname:node_4928,prsc:2|VAL-342-A,EXP-4008-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4008,x:29672,y:33595,ptovrint:False,ptlb:MainMask_Pow,ptin:_MainMask_Pow,varname:node_4008,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:8827,x:30239,y:33517,varname:node_8827,prsc:2|A-4928-OUT,B-1562-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1562,x:30038,y:33595,ptovrint:False,ptlb:MainMask_Intensity,ptin:_MainMask_Intensity,varname:node_1562,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:1664,x:29672,y:33153,ptovrint:False,ptlb:Main_Ramp,ptin:_Main_Ramp,varname:node_1664,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-85-OUT;n:type:ShaderForge.SFN_Multiply,id:4413,x:30426,y:33395,varname:node_4413,prsc:2|A-1664-A,B-8827-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1584,x:30456,y:33282,ptovrint:False,ptlb:Dissolve_Intensity,ptin:_Dissolve_Intensity,varname:node_1584,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.5;n:type:ShaderForge.SFN_If,id:5152,x:31204,y:33345,varname:node_5152,prsc:2|A-1584-OUT,B-4413-OUT,GT-9433-OUT,EQ-8036-OUT,LT-8036-OUT;n:type:ShaderForge.SFN_Vector1,id:9433,x:30971,y:33456,varname:node_9433,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:8036,x:30971,y:33630,varname:node_8036,prsc:2,v1:0;n:type:ShaderForge.SFN_If,id:305,x:31204,y:33566,varname:node_305,prsc:2|A-4115-OUT,B-4413-OUT,GT-9433-OUT,EQ-8036-OUT,LT-8036-OUT;n:type:ShaderForge.SFN_Subtract,id:4115,x:30808,y:33456,varname:node_4115,prsc:2|A-1584-OUT,B-2217-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2217,x:30426,y:33623,ptovrint:False,ptlb:DissolveLineWidth,ptin:_DissolveLineWidth,varname:node_2217,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_If,id:168,x:31204,y:33758,varname:node_168,prsc:2|A-8101-OUT,B-4413-OUT,GT-9433-OUT,EQ-8036-OUT,LT-8036-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1576,x:30576,y:33841,ptovrint:False,ptlb:DissolveLineWidth02,ptin:_DissolveLineWidth02,varname:_dissolveSideWidth_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Subtract,id:4982,x:31524,y:33418,varname:node_4982,prsc:2|A-5152-OUT,B-305-OUT;n:type:ShaderForge.SFN_Subtract,id:942,x:31530,y:33689,varname:node_942,prsc:2|A-5152-OUT,B-168-OUT;n:type:ShaderForge.SFN_Tex2d,id:6462,x:30445,y:32889,ptovrint:False,ptlb:Line_Ramp,ptin:_Line_Ramp,varname:_Main_Ramp_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-85-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3418,x:30456,y:33119,ptovrint:False,ptlb:Line_Ramp_AddValue,ptin:_Line_Ramp_AddValue,varname:node_3418,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:9492,x:30941,y:32976,varname:node_9492,prsc:2|A-6844-A,B-4245-OUT;n:type:ShaderForge.SFN_Tex2d,id:6844,x:30727,y:32725,ptovrint:False,ptlb:Line_dissolveMask,ptin:_Line_dissolveMask,varname:_Side_Ramp_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-85-OUT;n:type:ShaderForge.SFN_Multiply,id:1314,x:31433,y:33060,varname:node_1314,prsc:2|A-9492-OUT,B-4982-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7465,x:31562,y:32636,ptovrint:False,ptlb:LineDissolve_Intensity,ptin:_LineDissolve_Intensity,varname:_Dissolve_Intensity_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.25;n:type:ShaderForge.SFN_If,id:5109,x:32098,y:32701,varname:node_5109,prsc:2|A-7465-OUT,B-1314-OUT,GT-9140-OUT,EQ-937-OUT,LT-937-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6752,x:31562,y:32813,ptovrint:False,ptlb:LineDissolve_LineWidth,ptin:_LineDissolve_LineWidth,varname:_SideDissolve_Intensity_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.05;n:type:ShaderForge.SFN_Vector1,id:9140,x:31819,y:33004,varname:node_9140,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:937,x:31819,y:33052,varname:node_937,prsc:2,v1:0;n:type:ShaderForge.SFN_Color,id:9166,x:32431,y:32502,ptovrint:False,ptlb:LineDissolve_LineWidthColor,ptin:_LineDissolve_LineWidthColor,varname:node_9166,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:1465,x:32913,y:32961,varname:node_1465,prsc:2|A-5713-RGB,B-3219-OUT;n:type:ShaderForge.SFN_Color,id:5713,x:32668,y:32868,ptovrint:False,ptlb:LineWidthColor,ptin:_LineWidthColor,varname:node_5713,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:1029,x:33043,y:32523,ptovrint:False,ptlb:MainTexture,ptin:_MainTexture,varname:node_1029,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Add,id:1730,x:33405,y:32851,varname:node_1730,prsc:2|A-2625-OUT,B-8531-OUT;n:type:ShaderForge.SFN_Multiply,id:2625,x:33187,y:32463,varname:node_2625,prsc:2|A-7241-RGB,B-1029-RGB;n:type:ShaderForge.SFN_Clamp01,id:5420,x:33311,y:33290,varname:node_5420,prsc:2|IN-6366-OUT;n:type:ShaderForge.SFN_Add,id:6366,x:32776,y:33375,varname:node_6366,prsc:2|A-4824-OUT,B-305-OUT,C-3766-OUT;n:type:ShaderForge.SFN_OneMinus,id:4824,x:32335,y:32958,varname:node_4824,prsc:2|IN-5109-OUT;n:type:ShaderForge.SFN_If,id:4776,x:32098,y:32881,varname:node_4776,prsc:2|A-9519-OUT,B-1314-OUT,GT-9140-OUT,EQ-9140-OUT,LT-937-OUT;n:type:ShaderForge.SFN_Subtract,id:9519,x:31756,y:32769,varname:node_9519,prsc:2|A-7465-OUT,B-6752-OUT;n:type:ShaderForge.SFN_Subtract,id:3766,x:32318,y:32740,varname:node_3766,prsc:2|A-5109-OUT,B-4776-OUT;n:type:ShaderForge.SFN_Multiply,id:663,x:32586,y:32678,varname:node_663,prsc:2|A-9166-RGB,B-3766-OUT;n:type:ShaderForge.SFN_Add,id:8531,x:33159,y:32851,varname:node_8531,prsc:2|A-663-OUT,B-1465-OUT;n:type:ShaderForge.SFN_Multiply,id:4245,x:30730,y:33061,varname:node_4245,prsc:2|A-6462-A,B-3418-OUT;n:type:ShaderForge.SFN_Subtract,id:8101,x:30823,y:33697,varname:node_8101,prsc:2|A-1584-OUT,B-1576-OUT;n:type:ShaderForge.SFN_Add,id:3219,x:31901,y:33580,varname:node_3219,prsc:2|A-4982-OUT,B-942-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3128,x:32344,y:33469,ptovrint:False,ptlb:SideDissolve_Intensity_copy_copy_copy_copy_copy_copy,ptin:_SideDissolve_Intensity_copy_copy_copy_copy_copy_copy,varname:_SideDissolve_Intensity_copy_copy_copy_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_ValueProperty,id:152,x:32408,y:33533,ptovrint:False,ptlb:SideDissolve_Intensity_copy_copy_copy_copy_copy_copy_copy,ptin:_SideDissolve_Intensity_copy_copy_copy_copy_copy_copy_copy,varname:_SideDissolve_Intensity_copy_copy_copy_copy_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_TexCoord,id:395,x:29198,y:33034,varname:node_395,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_VertexColor,id:2259,x:33688,y:33099,varname:node_2259,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7663,x:33677,y:32927,varname:node_7663,prsc:2|A-1730-OUT,B-2259-RGB;n:type:ShaderForge.SFN_Multiply,id:6453,x:33711,y:33289,varname:node_6453,prsc:2|A-2259-A,B-5420-OUT;n:type:ShaderForge.SFN_TexCoord,id:8085,x:29198,y:32844,varname:node_8085,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_SwitchProperty,id:85,x:29388,y:32956,ptovrint:False,ptlb:Use_SecUV,ptin:_Use_SecUV,varname:node_85,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-8085-UVOUT,B-395-UVOUT;proporder:7241-1029-342-4008-1562-1664-1584-5713-2217-1576-6462-3418-6844-7465-9166-6752-85;pass:END;sub:END;*/

Shader "Lapis/Effect/CLOCK_dissolve01" {
    Properties {
        [HDR]_MainTextureColor ("MainTextureColor", Color) = (0.5,0.5,0.5,1)
        _MainTexture ("MainTexture", 2D) = "white" {}
        _Main_Mask ("Main_Mask", 2D) = "white" {}
        _MainMask_Pow ("MainMask_Pow", Float ) = 1
        _MainMask_Intensity ("MainMask_Intensity", Float ) = 1
        _Main_Ramp ("Main_Ramp", 2D) = "white" {}
        _Dissolve_Intensity ("Dissolve_Intensity", Float ) = 1.5
        [HDR]_LineWidthColor ("LineWidthColor", Color) = (0.5,0.5,0.5,1)
        _DissolveLineWidth ("DissolveLineWidth", Float ) = 0.2
        _DissolveLineWidth02 ("DissolveLineWidth02", Float ) = 0.1
        _Line_Ramp ("Line_Ramp", 2D) = "white" {}
        _Line_Ramp_AddValue ("Line_Ramp_AddValue", Float ) = 1
        _Line_dissolveMask ("Line_dissolveMask", 2D) = "white" {}
        _LineDissolve_Intensity ("LineDissolve_Intensity", Float ) = 0.25
        [HDR]_LineDissolve_LineWidthColor ("LineDissolve_LineWidthColor", Color) = (0.5,0.5,0.5,1)
        _LineDissolve_LineWidth ("LineDissolve_LineWidth", Float ) = 0.05
        [MaterialToggle] _Use_SecUV ("Use_SecUV", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            //#pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _MainTextureColor;
            uniform sampler2D _Main_Mask; uniform float4 _Main_Mask_ST;
            uniform float _MainMask_Pow;
            uniform float _MainMask_Intensity;
            uniform sampler2D _Main_Ramp; uniform float4 _Main_Ramp_ST;
            uniform float _Dissolve_Intensity;
            uniform float _DissolveLineWidth;
            uniform float _DissolveLineWidth02;
            uniform sampler2D _Line_Ramp; uniform float4 _Line_Ramp_ST;
            uniform float _Line_Ramp_AddValue;
            uniform sampler2D _Line_dissolveMask; uniform float4 _Line_dissolveMask_ST;
            uniform float _LineDissolve_Intensity;
            uniform float _LineDissolve_LineWidth;
            uniform float4 _LineDissolve_LineWidthColor;
            uniform float4 _LineWidthColor;
            uniform sampler2D _MainTexture; uniform float4 _MainTexture_ST;
            uniform fixed _Use_SecUV;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _MainTexture_var = tex2D(_MainTexture,TRANSFORM_TEX(i.uv0, _MainTexture));
                float2 _Use_SecUV_var = lerp( i.uv0, i.uv1, _Use_SecUV );
                float4 _Line_dissolveMask_var = tex2D(_Line_dissolveMask,TRANSFORM_TEX(_Use_SecUV_var, _Line_dissolveMask));
                float4 _Line_Ramp_var = tex2D(_Line_Ramp,TRANSFORM_TEX(_Use_SecUV_var, _Line_Ramp));
                float4 _Main_Ramp_var = tex2D(_Main_Ramp,TRANSFORM_TEX(_Use_SecUV_var, _Main_Ramp));
                float4 _Main_Mask_var = tex2D(_Main_Mask,TRANSFORM_TEX(_Use_SecUV_var, _Main_Mask));
                float node_4413 = (_Main_Ramp_var.a*(pow(_Main_Mask_var.a,_MainMask_Pow)*_MainMask_Intensity));
                float node_5152_if_leA = step(_Dissolve_Intensity,node_4413);
                float node_5152_if_leB = step(node_4413,_Dissolve_Intensity);
                float node_8036 = 0.0;
                float node_9433 = 1.0;
                float node_5152 = lerp((node_5152_if_leA*node_8036)+(node_5152_if_leB*node_9433),node_8036,node_5152_if_leA*node_5152_if_leB);
                float node_305_if_leA = step((_Dissolve_Intensity-_DissolveLineWidth),node_4413);
                float node_305_if_leB = step(node_4413,(_Dissolve_Intensity-_DissolveLineWidth));
                float node_305 = lerp((node_305_if_leA*node_8036)+(node_305_if_leB*node_9433),node_8036,node_305_if_leA*node_305_if_leB);
                float node_4982 = (node_5152-node_305);
                float node_1314 = ((_Line_dissolveMask_var.a*(_Line_Ramp_var.a*_Line_Ramp_AddValue))*node_4982);
                float node_5109_if_leA = step(_LineDissolve_Intensity,node_1314);
                float node_5109_if_leB = step(node_1314,_LineDissolve_Intensity);
                float node_937 = 0.0;
                float node_9140 = 1.0;
                float node_5109 = lerp((node_5109_if_leA*node_937)+(node_5109_if_leB*node_9140),node_937,node_5109_if_leA*node_5109_if_leB);
                float node_4776_if_leA = step((_LineDissolve_Intensity-_LineDissolve_LineWidth),node_1314);
                float node_4776_if_leB = step(node_1314,(_LineDissolve_Intensity-_LineDissolve_LineWidth));
                float node_3766 = (node_5109-lerp((node_4776_if_leA*node_937)+(node_4776_if_leB*node_9140),node_9140,node_4776_if_leA*node_4776_if_leB));
                float node_168_if_leA = step((_Dissolve_Intensity-_DissolveLineWidth02),node_4413);
                float node_168_if_leB = step(node_4413,(_Dissolve_Intensity-_DissolveLineWidth02));
                float3 emissive = (((_MainTextureColor.rgb*_MainTexture_var.rgb)+((_LineDissolve_LineWidthColor.rgb*node_3766)+(_LineWidthColor.rgb*(node_4982+(node_5152-lerp((node_168_if_leA*node_8036)+(node_168_if_leB*node_9433),node_8036,node_168_if_leA*node_168_if_leB))))))*i.vertexColor.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,(i.vertexColor.a*saturate(((1.0 - node_5109)+node_305+node_3766))));
            }
            ENDCG
        }
    }
	Fallback "Hidden/Lapis/VertexLit"
    CustomEditor "ShaderForgeMaterialInspector"
}
