// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32807,y:32543,varname:node_3138,prsc:2|emission-8744-OUT,alpha-2700-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:31712,y:32545,ptovrint:False,ptlb:Main_Color,ptin:_Main_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:0.5019608;n:type:ShaderForge.SFN_Fresnel,id:1021,x:31711,y:33119,varname:node_1021,prsc:2|EXP-8250-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8250,x:31530,y:33212,ptovrint:False,ptlb:Fresnel_intensity,ptin:_Fresnel_intensity,varname:_node_8250,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:7041,x:31952,y:33092,varname:node_7041,prsc:2|IN-1021-OUT;n:type:ShaderForge.SFN_Tex2d,id:6305,x:31712,y:32738,ptovrint:False,ptlb:Main_Tex,ptin:_Main_Tex,varname:_node_6305,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7e3236a37405ca248bcdc082fd8f49b3,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3513,x:31940,y:32781,varname:node_3513,prsc:2|A-7241-A,B-6305-A;n:type:ShaderForge.SFN_Multiply,id:8654,x:31964,y:32602,varname:node_8654,prsc:2|A-7241-RGB,B-6305-RGB;n:type:ShaderForge.SFN_VertexColor,id:8247,x:32376,y:32687,varname:node_8247,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8744,x:32586,y:32602,varname:node_8744,prsc:2|A-8247-RGB,B-5527-OUT;n:type:ShaderForge.SFN_Multiply,id:2700,x:32586,y:32804,varname:node_2700,prsc:2|A-8247-A,B-4766-OUT;n:type:ShaderForge.SFN_Multiply,id:4766,x:32376,y:32952,varname:node_4766,prsc:2|A-4593-OUT,B-6847-OUT;n:type:ShaderForge.SFN_Color,id:7797,x:31712,y:32154,ptovrint:False,ptlb:Add_Color,ptin:_Add_Color,varname:node_7797,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:2339,x:31712,y:32347,ptovrint:False,ptlb:Add_Tex,ptin:_Add_Tex,varname:node_2339,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6b3f0ff0320fba8479684cc5c35aacce,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:5068,x:31964,y:32224,varname:node_5068,prsc:2|A-7797-RGB,B-2339-RGB;n:type:ShaderForge.SFN_Multiply,id:6811,x:31964,y:32396,varname:node_6811,prsc:2|A-7797-A,B-2339-A;n:type:ShaderForge.SFN_Add,id:5527,x:32172,y:32340,varname:node_5527,prsc:2|A-5068-OUT,B-8654-OUT,C-4638-OUT;n:type:ShaderForge.SFN_Add,id:4593,x:32177,y:32663,varname:node_4593,prsc:2|A-6811-OUT,B-3513-OUT,C-9298-OUT;n:type:ShaderForge.SFN_Power,id:6847,x:32217,y:33108,varname:node_6847,prsc:2|VAL-7041-OUT,EXP-1346-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1346,x:32014,y:33295,ptovrint:False,ptlb:Fresnel_Power,ptin:_Fresnel_Power,varname:node_1346,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Color,id:3971,x:31709,y:31749,ptovrint:False,ptlb:Add_Color2,ptin:_Add_Color2,varname:_Add_Color_copy,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:1287,x:31709,y:31942,ptovrint:False,ptlb:Add_Tex2,ptin:_Add_Tex2,varname:_Add_Tex_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6b3f0ff0320fba8479684cc5c35aacce,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4638,x:31961,y:31819,varname:node_4638,prsc:2|A-3971-RGB,B-1287-RGB;n:type:ShaderForge.SFN_Multiply,id:9298,x:31961,y:31991,varname:node_9298,prsc:2|A-3971-A,B-1287-A;proporder:7241-6305-8250-7797-2339-1346-3971-1287;pass:END;sub:END;*/

Shader "ShaderLab/Lapis/Effect/FresnelRoll02" {
    Properties {
        [HDR]_Main_Color ("Main_Color", Color) = (0.5,0.5,0.5,0.5019608)
        _Main_Tex ("Main_Tex", 2D) = "white" {}
        _Fresnel_intensity ("Fresnel_intensity", Float ) = 1
        [HDR]_Add_Color ("Add_Color", Color) = (0.5019608,0.5019608,0.5019608,1)
        _Add_Tex ("Add_Tex", 2D) = "white" {}
        _Fresnel_Power ("Fresnel_Power", Float ) = 2
        [HDR]_Add_Color2 ("Add_Color2", Color) = (0.5019608,0.5019608,0.5019608,1)
        _Add_Tex2 ("Add_Tex2", 2D) = "white" {}
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
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase 
            #pragma target 3.0
            uniform float4 _Main_Color;
            uniform float _Fresnel_intensity;
            uniform sampler2D _Main_Tex; uniform float4 _Main_Tex_ST;
            uniform float4 _Add_Color;
            uniform sampler2D _Add_Tex; uniform float4 _Add_Tex_ST;
            uniform float _Fresnel_Power;
            uniform float4 _Add_Color2;
            uniform sampler2D _Add_Tex2; uniform float4 _Add_Tex2_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _Add_Tex_var = tex2D(_Add_Tex,TRANSFORM_TEX(i.uv0, _Add_Tex));
                float4 _Main_Tex_var = tex2D(_Main_Tex,TRANSFORM_TEX(i.uv0, _Main_Tex));
                float4 _Add_Tex2_var = tex2D(_Add_Tex2,TRANSFORM_TEX(i.uv0, _Add_Tex2));
                float3 emissive = (i.vertexColor.rgb*((_Add_Color.rgb*_Add_Tex_var.rgb)+(_Main_Color.rgb*_Main_Tex_var.rgb)+(_Add_Color2.rgb*_Add_Tex2_var.rgb)));
                float3 finalColor = emissive;
                return fixed4(finalColor,(i.vertexColor.a*(((_Add_Color.a*_Add_Tex_var.a)+(_Main_Color.a*_Main_Tex_var.a)+(_Add_Color2.a*_Add_Tex2_var.a))*pow((1.0 - pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel_intensity)),_Fresnel_Power))));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
