// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-8696-OUT,alpha-4917-R;n:type:ShaderForge.SFN_Color,id:7241,x:31997,y:32584,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:9796,x:31997,y:32757,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_9796,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:22cb8815d50a07a46917c2abc78a46aa,ntxv:0,isnm:False|UVIN-7242-OUT;n:type:ShaderForge.SFN_Multiply,id:8696,x:32231,y:32738,varname:node_8696,prsc:2|A-7241-RGB,B-9796-RGB;n:type:ShaderForge.SFN_Vector4Property,id:3695,x:31230,y:33028,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_3695,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Multiply,id:5473,x:31554,y:32893,varname:node_5473,prsc:2|A-9392-T,B-1048-OUT;n:type:ShaderForge.SFN_Time,id:9392,x:31257,y:32667,varname:node_9392,prsc:2;n:type:ShaderForge.SFN_Append,id:1048,x:31447,y:33042,varname:node_1048,prsc:2|A-3695-X,B-3695-Y;n:type:ShaderForge.SFN_Add,id:7242,x:31764,y:32653,varname:node_7242,prsc:2|A-9470-UVOUT,B-5473-OUT;n:type:ShaderForge.SFN_TexCoord,id:9470,x:31486,y:32544,varname:node_9470,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:4917,x:31997,y:33010,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_4917,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;proporder:7241-3695-9796-4917;pass:END;sub:END;*/

Shader "Lapis/Effect/Ripple" {
    Properties {
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Speed ("Speed", Vector) = (0,0,0,0)
        _MainTex ("MainTex", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}
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
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Speed;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
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
                float4 node_9392 = _Time;
                float2 node_7242 = (i.uv0+(node_9392.g*float2(_Speed.r,_Speed.g)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_7242, _MainTex));
                float3 emissive = (_Color.rgb*_MainTex_var.rgb);
                float3 finalColor = emissive;
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                return fixed4(finalColor,_Mask_var.r);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
