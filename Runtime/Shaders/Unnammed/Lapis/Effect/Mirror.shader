// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-1165-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32036,y:32717,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_ScreenPos,id:5745,x:31157,y:33408,varname:node_5745,prsc:2,sctp:0;n:type:ShaderForge.SFN_Tex2d,id:6811,x:32055,y:32897,ptovrint:False,ptlb:MainTexture,ptin:_MainTexture,varname:node_6811,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4826-OUT;n:type:ShaderForge.SFN_Multiply,id:1165,x:32249,y:32833,varname:node_1165,prsc:2|A-7241-RGB,B-6811-RGB,C-6575-OUT;n:type:ShaderForge.SFN_Time,id:3721,x:31179,y:32887,varname:node_3721,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:6123,x:31179,y:33070,ptovrint:False,ptlb:SrollX,ptin:_SrollX,varname:node_6123,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:400,x:31179,y:33148,ptovrint:False,ptlb:SrollY,ptin:_SrollY,varname:node_400,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:5892,x:31363,y:33104,varname:node_5892,prsc:2|A-6123-OUT,B-400-OUT;n:type:ShaderForge.SFN_Add,id:4826,x:31741,y:32908,varname:node_4826,prsc:2|A-5832-UVOUT,B-1975-OUT,C-3201-OUT;n:type:ShaderForge.SFN_Multiply,id:1975,x:31517,y:32908,varname:node_1975,prsc:2|A-3721-T,B-5892-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6575,x:32036,y:33076,ptovrint:False,ptlb:Intensity,ptin:_Intensity,varname:node_6575,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Rotator,id:5832,x:31755,y:32622,varname:node_5832,prsc:2|UVIN-6-UVOUT,ANG-7797-OUT;n:type:ShaderForge.SFN_Tex2d,id:3378,x:31050,y:32762,ptovrint:False,ptlb:Ramp,ptin:_Ramp,varname:node_3378,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6-UVOUT;n:type:ShaderForge.SFN_Multiply,id:7797,x:31430,y:32747,varname:node_7797,prsc:2|A-3378-R,B-9860-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9860,x:31237,y:32781,ptovrint:False,ptlb:Ang,ptin:_Ang,varname:node_9860,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_TexCoord,id:6,x:30839,y:32685,varname:node_6,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Negate,id:3201,x:31698,y:33421,varname:node_3201,prsc:2|IN-1933-OUT;n:type:ShaderForge.SFN_Divide,id:1933,x:31478,y:33421,varname:node_1933,prsc:2|A-5745-UVOUT,B-3288-OUT;n:type:ShaderForge.SFN_ViewPosition,id:6858,x:32766,y:33897,varname:node_6858,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:3288,x:31187,y:33769,ptovrint:False,ptlb:Depth Of Field,ptin:_DepthOfField,varname:node_3288,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:7241-6811-6123-400-6575-3378-9860-3288;pass:END;sub:END;*/

Shader "Lapis/Effect/Mirror" {
    Properties {
        _Color ("Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _MainTexture ("MainTexture", 2D) = "white" {}
        _SrollX ("SrollX", Float ) = 0
        _SrollY ("SrollY", Float ) = 0
        _Intensity ("Intensity", Float ) = 1
        _Ramp ("Ramp", 2D) = "white" {}
        _Ang ("Ang", Float ) = 1
        _DepthOfField ("Depth Of Field", Float ) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTexture; uniform float4 _MainTexture_ST;
            uniform float _SrollX;
            uniform float _SrollY;
            uniform float _Intensity;
            uniform sampler2D _Ramp; uniform float4 _Ramp_ST;
            uniform float _Ang;
            uniform float _DepthOfField;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
////// Lighting:
////// Emissive:
                float4 _Ramp_var = tex2D(_Ramp,TRANSFORM_TEX(i.uv0, _Ramp));
                float node_5832_ang = (_Ramp_var.r*_Ang);
                float node_5832_spd = 1.0;
                float node_5832_cos = cos(node_5832_spd*node_5832_ang);
                float node_5832_sin = sin(node_5832_spd*node_5832_ang);
                float2 node_5832_piv = float2(0.5,0.5);
                float2 node_5832 = (mul(i.uv0-node_5832_piv,float2x2( node_5832_cos, -node_5832_sin, node_5832_sin, node_5832_cos))+node_5832_piv);
                float4 node_3721 = _Time;
                float2 node_4826 = (node_5832+(node_3721.g*float2(_SrollX,_SrollY))+(-1*((sceneUVs * 2 - 1).rg/_DepthOfField)));
                float4 _MainTexture_var = tex2D(_MainTexture,TRANSFORM_TEX(node_4826, _MainTexture));
                float3 emissive = (_Color.rgb*_MainTexture_var.rgb*_Intensity);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
			Fallback "Hidden/Lapis/VertexLit"
    CustomEditor "ShaderForgeMaterialInspector"
}
