// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:32657,y:32689,varname:node_4013,prsc:2|emission-4112-OUT,voffset-9289-OUT;n:type:ShaderForge.SFN_Tex2d,id:4185,x:31950,y:33231,ptovrint:False,ptlb:Offset,ptin:_Offset,varname:node_4185,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8406-OUT;n:type:ShaderForge.SFN_Append,id:4541,x:30977,y:33706,varname:node_4541,prsc:2|A-6515-OUT,B-3625-OUT;n:type:ShaderForge.SFN_TexCoord,id:83,x:31056,y:33211,varname:node_83,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_VertexColor,id:6028,x:31975,y:33389,varname:node_6028,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:2822,x:32134,y:32560,ptovrint:False,ptlb:Main,ptin:_Main,varname:node_2822,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3267-OUT;n:type:ShaderForge.SFN_Slider,id:3625,x:30470,y:33901,ptovrint:False,ptlb:Offset U,ptin:_OffsetU,varname:node_3625,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-100,cur:0,max:100;n:type:ShaderForge.SFN_Time,id:1888,x:30953,y:33397,varname:node_1888,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6386,x:31211,y:33591,varname:node_6386,prsc:2|A-4541-OUT,B-1888-TSL;n:type:ShaderForge.SFN_Slider,id:6515,x:30530,y:33654,ptovrint:False,ptlb:Offset V,ptin:_OffsetV,varname:node_6515,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-100,cur:0,max:100;n:type:ShaderForge.SFN_Add,id:8406,x:31394,y:33502,varname:node_8406,prsc:2|A-83-UVOUT,B-6386-OUT;n:type:ShaderForge.SFN_Multiply,id:9289,x:32545,y:33364,varname:node_9289,prsc:2|A-4185-RGB,B-6028-A;n:type:ShaderForge.SFN_Slider,id:8138,x:30383,y:32507,ptovrint:False,ptlb:U Scroll,ptin:_UScroll,varname:node_8138,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-50,cur:0,max:50;n:type:ShaderForge.SFN_Slider,id:623,x:30383,y:32643,ptovrint:False,ptlb:V Scroll,ptin:_VScroll,varname:_node_8138_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-50,cur:0,max:50;n:type:ShaderForge.SFN_Color,id:7807,x:31924,y:32759,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:node_7807,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:4112,x:32170,y:32798,varname:node_4112,prsc:2|A-2822-RGB,B-7807-RGB,C-5541-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5541,x:31924,y:32955,ptovrint:False,ptlb:Str,ptin:_Str,varname:node_5541,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Append,id:448,x:30836,y:32619,varname:node_448,prsc:2|A-8138-OUT,B-623-OUT;n:type:ShaderForge.SFN_TexCoord,id:4871,x:30915,y:32124,varname:node_4871,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:2765,x:30634,y:32334,varname:node_2765,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8621,x:31070,y:32504,varname:node_8621,prsc:2|A-448-OUT,B-2765-TSL;n:type:ShaderForge.SFN_Add,id:3267,x:31253,y:32415,varname:node_3267,prsc:2|A-4871-UVOUT,B-8621-OUT;proporder:5541-4185-2822-7807-3625-6515-8138-623;pass:END;sub:END;*/

Shader "ShaderLab/Lapis/Effect/VertexOffset" {
    Properties {
        _Str ("Str", Float ) = 1
        _Offset ("Offset", 2D) = "white" {}
        _Main ("Main", 2D) = "white" {}
        [HDR]_MainColor ("MainColor", Color) = (0.5,0.5,0.5,1)
        _OffsetU ("Offset U", Range(-100, 100)) = 0
        _OffsetV ("Offset V", Range(-100, 100)) = 0
        _UScroll ("U Scroll", Range(-50, 50)) = 0
        _VScroll ("V Scroll", Range(-50, 50)) = 0
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _Offset; uniform float4 _Offset_ST;
            uniform sampler2D _Main; uniform float4 _Main_ST;
            uniform float _OffsetU;
            uniform float _OffsetV;
            uniform float _UScroll;
            uniform float _VScroll;
            uniform float4 _MainColor;
            uniform float _Str;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                float4 node_1888 = _Time;
                float2 node_8406 = (o.uv0+(float2(_OffsetV,_OffsetU)*node_1888.r));
                float4 _Offset_var = tex2Dlod(_Offset,float4(TRANSFORM_TEX(node_8406, _Offset),0.0,0));
                v.vertex.xyz += (_Offset_var.rgb*o.vertexColor.a);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 node_2765 = _Time;
                float2 node_3267 = (i.uv0+(float2(_UScroll,_VScroll)*node_2765.r));
                float4 _Main_var = tex2D(_Main,TRANSFORM_TEX(node_3267, _Main));
                float3 emissive = (_Main_var.rgb*_MainColor.rgb*_Str);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
