// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32821,y:32682,varname:node_4795,prsc:2|emission-2393-OUT;n:type:ShaderForge.SFN_Tex2d,id:6074,x:31989,y:32326,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:2393,x:32523,y:32783,varname:node_2393,prsc:2|A-1958-OUT,B-2053-RGB,C-797-RGB,D-2053-A,E-9248-OUT;n:type:ShaderForge.SFN_VertexColor,id:2053,x:32044,y:32801,varname:node_2053,prsc:2;n:type:ShaderForge.SFN_Color,id:797,x:32044,y:32956,ptovrint:True,ptlb:Color,ptin:_TintColor,varname:_TintColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Vector1,id:9248,x:32235,y:33081,varname:node_9248,prsc:2,v1:2;n:type:ShaderForge.SFN_Tex2d,id:9777,x:31989,y:32557,ptovrint:False,ptlb:Add_Tex,ptin:_Add_Tex,varname:node_9777,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8032-UVOUT;n:type:ShaderForge.SFN_Panner,id:8032,x:31796,y:32557,varname:node_8032,prsc:2,spu:0.5,spv:0.5|UVIN-4063-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:4063,x:31352,y:32456,varname:node_4063,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:1958,x:32270,y:32531,varname:node_1958,prsc:2|A-6074-RGB,B-9777-RGB;n:type:ShaderForge.SFN_Time,id:2979,x:31155,y:32604,varname:node_2979,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8078,x:31582,y:32688,varname:node_8078,prsc:2|A-2979-T,B-7121-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7298,x:31193,y:32873,ptovrint:False,ptlb:node_7298,ptin:_node_7298,varname:node_7298,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:6998,x:31193,y:32795,ptovrint:False,ptlb:node_6998,ptin:_node_6998,varname:node_6998,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:7121,x:31358,y:32804,varname:node_7121,prsc:2|A-6998-OUT,B-7298-OUT;proporder:6074-797-9777;pass:END;sub:END;*/

Shader "Shader Forge/Oz_Particle_NightSkyGlow" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _TintColor ("Color", Color) = (0.5,0.5,0.5,1)
        _Add_Tex ("Add_Tex", 2D) = "white" {}
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
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _TintColor;
            uniform sampler2D _Add_Tex; uniform float4 _Add_Tex_ST;
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
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 node_7566 = _Time;
                float2 node_8032 = (i.uv0+node_7566.g*float2(0.5,0.5));
                float4 _Add_Tex_var = tex2D(_Add_Tex,TRANSFORM_TEX(node_8032, _Add_Tex));
                float3 emissive = ((_MainTex_var.rgb+_Add_Tex_var.rgb)*i.vertexColor.rgb*_TintColor.rgb*i.vertexColor.a*2.0);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(0,0,0,1));
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
