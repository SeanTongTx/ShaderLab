// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32779,y:32591,varname:node_3138,prsc:2|emission-5814-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32083,y:32670,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_Multiply,id:4932,x:32440,y:32807,varname:node_4932,prsc:2|A-7241-RGB,B-4380-RGB,C-4511-OUT,D-7060-OUT,E-168-A;n:type:ShaderForge.SFN_Tex2d,id:4380,x:32083,y:32839,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_4380,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:1f2830feb08323643858d27b20d9c472,ntxv:0,isnm:False|UVIN-125-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:8108,x:31392,y:32582,ptovrint:False,ptlb:Uv Switch,ptin:_UvSwitch,varname:node_8108,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-1820-UVOUT,B-5382-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:5382,x:31093,y:32529,varname:node_5382,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:1820,x:31093,y:32383,varname:node_1820,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:4511,x:31982,y:33043,ptovrint:False,ptlb:Vein Ins,ptin:_VeinIns,varname:node_4511,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:8156,x:31769,y:33089,ptovrint:False,ptlb:MaskTex,ptin:_MaskTex,varname:node_8156,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:29993803be2123f4898e1b772e45eb8b,ntxv:0,isnm:False|UVIN-3384-OUT;n:type:ShaderForge.SFN_VertexColor,id:168,x:32241,y:33454,varname:node_168,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:9037,x:31116,y:33399,ptovrint:False,ptlb:Mask VSpeed,ptin:_MaskVSpeed,varname:node_9037,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:5601,x:31116,y:33471,ptovrint:False,ptlb:Mask Uspeed,ptin:_MaskUspeed,varname:node_5601,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:1486,x:31292,y:33399,varname:node_1486,prsc:2|A-9037-OUT,B-5601-OUT;n:type:ShaderForge.SFN_Time,id:6949,x:31292,y:33252,varname:node_6949,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6746,x:31513,y:33347,varname:node_6746,prsc:2|A-6949-T,B-1486-OUT;n:type:ShaderForge.SFN_Add,id:3384,x:31683,y:33305,varname:node_3384,prsc:2|A-1822-OUT,B-6746-OUT;n:type:ShaderForge.SFN_Multiply,id:5814,x:32512,y:33028,varname:node_5814,prsc:2|A-4932-OUT,B-168-RGB;n:type:ShaderForge.SFN_ValueProperty,id:2034,x:30856,y:32724,ptovrint:False,ptlb:Main USpeed,ptin:_MainUSpeed,varname:node_2034,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:1601,x:30856,y:32823,ptovrint:False,ptlb:Main VSpeed,ptin:_MainVSpeed,varname:node_1601,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:4228,x:31040,y:32764,varname:node_4228,prsc:2|A-2034-OUT,B-1601-OUT;n:type:ShaderForge.SFN_Multiply,id:1118,x:31224,y:32774,varname:node_1118,prsc:2|A-4228-OUT,B-6949-T;n:type:ShaderForge.SFN_Add,id:125,x:31772,y:32591,varname:node_125,prsc:2|A-8108-OUT,B-1118-OUT;n:type:ShaderForge.SFN_Max,id:7060,x:32079,y:33171,varname:node_7060,prsc:2|A-8156-RGB,B-3171-OUT;n:type:ShaderForge.SFN_Slider,id:3171,x:31799,y:33414,ptovrint:False,ptlb:Mask Intensity,ptin:_MaskIntensity,varname:node_3171,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_SwitchProperty,id:1822,x:31394,y:32966,ptovrint:False,ptlb:Mask Switch,ptin:_MaskSwitch,varname:node_1822,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-1820-UVOUT,B-5382-UVOUT;proporder:7241-4380-8108-4511-8156-9037-5601-2034-1601-3171-1822;pass:END;sub:END;*/

Shader "Lapis/Effect/Mask_Add" {
    Properties {
        [HDR]_Color ("Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _MainTex ("MainTex", 2D) = "white" {}
        [MaterialToggle] _UvSwitch ("Uv Switch", Float ) = 0
        _VeinIns ("Vein Ins", Float ) = 1
        _MaskTex ("MaskTex", 2D) = "white" {}
        _MaskVSpeed ("Mask VSpeed", Float ) = 0
        _MaskUspeed ("Mask Uspeed", Float ) = 0
        _MainUSpeed ("Main USpeed", Float ) = 0
        _MainVSpeed ("Main VSpeed", Float ) = 0
        _MaskIntensity ("Mask Intensity", Range(0, 1)) = 0
        [MaterialToggle] _MaskSwitch ("Mask Switch", Float ) = 0
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
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform fixed _UvSwitch;
            uniform float _VeinIns;
            uniform sampler2D _MaskTex; uniform float4 _MaskTex_ST;
            uniform float _MaskVSpeed;
            uniform float _MaskUspeed;
            uniform float _MainUSpeed;
            uniform float _MainVSpeed;
            uniform float _MaskIntensity;
            uniform fixed _MaskSwitch;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord2 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 node_6949 = _Time;
                float2 node_125 = (lerp( i.uv0, i.uv2, _UvSwitch )+(float2(_MainUSpeed,_MainVSpeed)*node_6949.g));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_125, _MainTex));
                float2 node_3384 = (lerp( i.uv0, i.uv2, _MaskSwitch )+(node_6949.g*float2(_MaskVSpeed,_MaskUspeed)));
                float4 _MaskTex_var = tex2D(_MaskTex,TRANSFORM_TEX(node_3384, _MaskTex));
                float3 emissive = ((_Color.rgb*_MainTex_var.rgb*_VeinIns*max(_MaskTex_var.rgb,_MaskIntensity)*i.vertexColor.a)*i.vertexColor.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
	Fallback "Hidden/Lapis/VertexLit"
    CustomEditor "ShaderForgeMaterialInspector"
}
