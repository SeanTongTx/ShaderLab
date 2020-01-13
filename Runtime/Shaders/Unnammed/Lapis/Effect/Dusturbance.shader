// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32703,y:32566,varname:node_3138,prsc:2|emission-8553-OUT,alpha-2155-A;n:type:ShaderForge.SFN_Tex2d,id:2155,x:32217,y:32667,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_2155,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:40782b981a6511f4ba94dd215b5093dd,ntxv:0,isnm:False|UVIN-3675-OUT;n:type:ShaderForge.SFN_Add,id:3675,x:31952,y:32662,varname:node_3675,prsc:2|A-4507-UVOUT,B-5382-OUT;n:type:ShaderForge.SFN_TexCoord,id:4507,x:31133,y:32653,varname:node_4507,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:5382,x:32131,y:32908,varname:node_5382,prsc:2|A-791-OUT,B-2376-OUT;n:type:ShaderForge.SFN_Tex2d,id:8332,x:31582,y:32958,ptovrint:False,ptlb:Shapen,ptin:_Shapen,varname:node_8332,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-242-OUT;n:type:ShaderForge.SFN_ComponentMask,id:791,x:31919,y:32908,varname:node_791,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8332-RGB;n:type:ShaderForge.SFN_Slider,id:398,x:32053,y:33120,ptovrint:False,ptlb:Distortion,ptin:_Distortion,varname:node_398,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Add,id:242,x:31582,y:32743,varname:node_242,prsc:2|A-4507-UVOUT,B-5031-OUT;n:type:ShaderForge.SFN_Multiply,id:5031,x:31334,y:32916,varname:node_5031,prsc:2|A-8650-T,B-280-OUT;n:type:ShaderForge.SFN_Time,id:8650,x:31133,y:32804,varname:_Time,prsc:2;n:type:ShaderForge.SFN_Slider,id:9905,x:30793,y:32861,ptovrint:False,ptlb:OffsetX,ptin:_OffsetX,varname:node_9905,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.392599,max:1;n:type:ShaderForge.SFN_Slider,id:2451,x:30783,y:33014,ptovrint:False,ptlb:OffsetY,ptin:_OffsetY,varname:node_2451,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Append,id:280,x:31133,y:32932,varname:node_280,prsc:2|A-9905-OUT,B-2451-OUT;n:type:ShaderForge.SFN_RemapRange,id:2376,x:32441,y:33119,varname:node_2376,prsc:2,frmn:0,frmx:1,tomn:0,tomx:0.02|IN-398-OUT;n:type:ShaderForge.SFN_Multiply,id:8553,x:32440,y:32514,varname:node_8553,prsc:2|A-2156-RGB,B-2155-RGB,C-8599-RGB,D-8599-A,E-187-OUT;n:type:ShaderForge.SFN_Color,id:2156,x:32217,y:32467,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_2156,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_VertexColor,id:8599,x:32217,y:32304,varname:node_8599,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:187,x:32227,y:32229,ptovrint:False,ptlb:Intensity,ptin:_Intensity,varname:node_187,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:2155-8332-398-9905-2451-2156-187;pass:END;sub:END;*/

Shader "Lapis/Effect/Disturbance" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Shapen ("Shapen", 2D) = "white" {}
        _Distortion ("Distortion", Range(0, 1)) = 0
        _OffsetX ("OffsetX", Range(-1, 1)) = 0.392599
        _OffsetY ("OffsetY", Range(-1, 1)) = 0
        [HDR]_Color ("Color", Color) = (1,1,1,1)
        _Intensity ("Intensity", Float ) = 1
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
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _Shapen; uniform float4 _Shapen_ST;
            uniform float _Distortion;
            uniform float _OffsetX;
            uniform float _OffsetY;
            uniform float4 _Color;
            uniform float _Intensity;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                // float4 _Time = _Time;
                float2 node_242 = (i.uv0+(_Time.g*float2(_OffsetX,_OffsetY)));
                float4 _Shapen_var = tex2D(_Shapen,TRANSFORM_TEX(node_242, _Shapen));
                float2 node_3675 = (i.uv0+(_Shapen_var.rgb.rg*(_Distortion*0.02+0.0)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_3675, _MainTex));
                float3 emissive = (_Color.rgb*_MainTex_var.rgb*i.vertexColor.rgb*i.vertexColor.a*_Intensity);
                float3 finalColor = emissive;
                return fixed4(finalColor,_MainTex_var.a);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
