// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-9768-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32120,y:32758,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7640,x:32245,y:33115,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_7640,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3a5a96df060a5cf4a9cc0c59e13486b7,ntxv:0,isnm:False|UVIN-7575-OUT;n:type:ShaderForge.SFN_TexCoord,id:8994,x:31553,y:32932,varname:node_8994,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:1558,x:31816,y:33037,varname:node_1558,prsc:2|A-8994-UVOUT,B-3217-OUT;n:type:ShaderForge.SFN_Add,id:7575,x:32046,y:33115,varname:node_7575,prsc:2|A-1558-OUT,B-5460-OUT;n:type:ShaderForge.SFN_Multiply,id:6084,x:31567,y:33295,varname:node_6084,prsc:2|A-3217-OUT,B-5513-OUT;n:type:ShaderForge.SFN_Vector1,id:5513,x:31351,y:33503,varname:node_5513,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Subtract,id:5460,x:31770,y:33409,varname:node_5460,prsc:2|A-5513-OUT,B-6084-OUT;n:type:ShaderForge.SFN_Tex2d,id:5140,x:32157,y:32565,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_5140,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7a98613fec496df489ffb5e3d58a4d8d,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:9768,x:32354,y:32653,varname:node_9768,prsc:2|A-5140-RGB,B-7241-RGB,C-7640-RGB;n:type:ShaderForge.SFN_ValueProperty,id:3217,x:31410,y:33135,ptovrint:False,ptlb:Scale,ptin:_Scale,varname:node_3217,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:7241-7640-5140-3217;pass:END;sub:END;*/

Shader "Lapis/Effect/ColorHDR_UVScale" {
    Properties {
        [HDR]_Color ("Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _Mask ("Mask", 2D) = "white" {}
        _MainTex ("MainTex", 2D) = "white" {}
        _Scale ("Scale", Float ) = 1
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Scale;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float node_5513 = 0.5;
                float2 node_7575 = ((i.uv0*_Scale)+(node_5513-(_Scale*node_5513)));
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(node_7575, _Mask));
                float3 emissive = (_MainTex_var.rgb*_Color.rgb*_Mask_var.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
	Fallback "Hidden/Lapis/VertexLit"
    CustomEditor "ShaderForgeMaterialInspector"
}
