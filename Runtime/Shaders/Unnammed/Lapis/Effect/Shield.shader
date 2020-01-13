// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33073,y:31895,varname:node_3138,prsc:2|emission-8819-OUT;n:type:ShaderForge.SFN_Multiply,id:6031,x:32034,y:32366,varname:node_6031,prsc:2|A-3016-RGB,B-2526-RGB,C-6964-OUT;n:type:ShaderForge.SFN_Tex2d,id:3016,x:31648,y:32130,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_3016,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:cbb378fa4fd94b84eaaf1228933bdc9e,ntxv:0,isnm:False|UVIN-6450-OUT;n:type:ShaderForge.SFN_Tex2d,id:2526,x:31648,y:32327,ptovrint:False,ptlb:SweepTex,ptin:_SweepTex,varname:node_2526,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6bbc7a7d63adc194293bdb9a5a4828d9,ntxv:0,isnm:False|UVIN-6130-OUT;n:type:ShaderForge.SFN_Add,id:9374,x:32034,y:32131,varname:node_9374,prsc:2|A-3016-RGB,B-6031-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6964,x:31648,y:32505,ptovrint:False,ptlb:Sweep,ptin:_Sweep,varname:node_6964,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Color,id:8530,x:32179,y:31604,ptovrint:False,ptlb:Color1,ptin:_Color1,varname:node_8530,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.3304112,c2:0.9339623,c3:0.6956853,c4:1;n:type:ShaderForge.SFN_Color,id:7806,x:32179,y:31771,ptovrint:False,ptlb:Color2,ptin:_Color2,varname:node_7806,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.3037113,c2:0.5547726,c3:0.990566,c4:1;n:type:ShaderForge.SFN_Multiply,id:8819,x:32478,y:32253,varname:node_8819,prsc:2|A-8394-OUT,B-9374-OUT,C-2769-OUT,D-1140-RGB;n:type:ShaderForge.SFN_Lerp,id:8394,x:32435,y:31700,varname:node_8394,prsc:2|A-8530-RGB,B-7806-RGB,T-4679-OUT;n:type:ShaderForge.SFN_Fresnel,id:4679,x:32179,y:31933,varname:node_4679,prsc:2|EXP-6358-OUT;n:type:ShaderForge.SFN_Slider,id:6358,x:31823,y:31714,ptovrint:False,ptlb:ColorOffset,ptin:_ColorOffset,varname:node_6358,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.026,max:2;n:type:ShaderForge.SFN_ValueProperty,id:8261,x:30864,y:32670,ptovrint:False,ptlb:SweepSpeed,ptin:_SweepSpeed,varname:node_8261,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:-0.3;n:type:ShaderForge.SFN_Vector1,id:8251,x:30864,y:32594,varname:node_8251,prsc:2,v1:0;n:type:ShaderForge.SFN_Append,id:4682,x:31038,y:32626,varname:node_4682,prsc:2|A-8251-OUT,B-8261-OUT;n:type:ShaderForge.SFN_Time,id:1729,x:31007,y:32237,varname:node_1729,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1643,x:31228,y:32552,varname:node_1643,prsc:2|A-1729-T,B-4682-OUT;n:type:ShaderForge.SFN_TexCoord,id:3237,x:31007,y:32358,varname:node_3237,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:6130,x:31378,y:32426,varname:node_6130,prsc:2|A-3237-UVOUT,B-1643-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7881,x:30867,y:32036,ptovrint:False,ptlb:XSpeed,ptin:_XSpeed,varname:node_7881,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:6206,x:30867,y:32118,ptovrint:False,ptlb:YSpeed,ptin:_YSpeed,varname:node_6206,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Add,id:6450,x:31355,y:32202,varname:node_6450,prsc:2|A-8942-OUT,B-3237-UVOUT;n:type:ShaderForge.SFN_Append,id:3664,x:31056,y:32060,varname:node_3664,prsc:2|A-7881-OUT,B-6206-OUT;n:type:ShaderForge.SFN_Multiply,id:8942,x:31259,y:32060,varname:node_8942,prsc:2|A-3664-OUT,B-1729-T;n:type:ShaderForge.SFN_ValueProperty,id:2769,x:32239,y:32287,ptovrint:False,ptlb:Opactity,ptin:_Opactity,varname:node_2769,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:1140,x:32034,y:32567,ptovrint:False,ptlb:MaskTex,ptin:_MaskTex,varname:node_1140,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;proporder:3016-2526-8530-7806-6358-6964-8261-7881-6206-2769-1140;pass:END;sub:END;*/

Shader "Lapis/Effect/Shield" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _SweepTex ("SweepTex", 2D) = "white" {}
        [HDR]_Color1 ("Color1", Color) = (0.3304112,0.9339623,0.6956853,1)
        [HDR]_Color2 ("Color2", Color) = (0.3037113,0.5547726,0.990566,1)
        _ColorOffset ("ColorOffset", Range(0, 2)) = 1.026
        _Sweep ("Sweep", Float ) = 1
        _SweepSpeed ("SweepSpeed", Float ) = -0.3
        _XSpeed ("XSpeed", Float ) = 0
        _YSpeed ("YSpeed", Float ) = 0
        _Opactity ("Opactity", Float ) = 1
        _MaskTex ("MaskTex", 2D) = "white" {}
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
            //#pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _SweepTex; uniform float4 _SweepTex_ST;
            uniform float _Sweep;
            uniform float4 _Color1;
            uniform float4 _Color2;
            uniform float _ColorOffset;
            uniform float _SweepSpeed;
            uniform float _XSpeed;
            uniform float _YSpeed;
            uniform float _Opactity;
            uniform sampler2D _MaskTex; uniform float4 _MaskTex_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 node_1729 = _Time;
                float2 node_6450 = ((float2(_XSpeed,_YSpeed)*node_1729.g)+i.uv0);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_6450, _MainTex));
                float2 node_6130 = (i.uv0+(node_1729.g*float2(0.0,_SweepSpeed)));
                float4 _SweepTex_var = tex2D(_SweepTex,TRANSFORM_TEX(node_6130, _SweepTex));
                float4 _MaskTex_var = tex2D(_MaskTex,TRANSFORM_TEX(i.uv0, _MaskTex));
                float3 emissive = (lerp(_Color1.rgb,_Color2.rgb,pow(1.0-max(0,dot(normalDirection, viewDirection)),_ColorOffset))*(_MainTex_var.rgb+(_MainTex_var.rgb*_SweepTex_var.rgb*_Sweep))*_Opactity*_MaskTex_var.rgb);
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
