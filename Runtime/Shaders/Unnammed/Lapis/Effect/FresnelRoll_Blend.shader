// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:False,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33703,y:32887,varname:node_4013,prsc:2|diff-4858-OUT,emission-4858-OUT,alpha-7510-OUT;n:type:ShaderForge.SFN_Fresnel,id:8565,x:32250,y:33306,varname:node_8565,prsc:2|EXP-9305-OUT;n:type:ShaderForge.SFN_Slider,id:9305,x:31879,y:33326,ptovrint:False,ptlb:Fres Int,ptin:_FresInt,varname:node_9305,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Color,id:4348,x:32025,y:33100,ptovrint:False,ptlb:Fres Color,ptin:_FresColor,varname:node_4348,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4386792,c2:0.6970649,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:9150,x:32392,y:33146,varname:node_9150,prsc:2|A-4348-RGB,B-8565-OUT,C-8532-RGB;n:type:ShaderForge.SFN_Tex2d,id:7867,x:31991,y:32487,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_7867,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4694-OUT;n:type:ShaderForge.SFN_Add,id:6277,x:32903,y:33072,varname:node_6277,prsc:2|A-7619-OUT,B-9150-OUT,C-5159-OUT;n:type:ShaderForge.SFN_Multiply,id:7619,x:32384,y:32607,varname:node_7619,prsc:2|A-7867-RGB,B-6717-OUT,C-4745-RGB,D-8532-A;n:type:ShaderForge.SFN_Color,id:4745,x:31991,y:32725,ptovrint:False,ptlb:MainTex Color,ptin:_MainTexColor,varname:node_4745,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:6717,x:32114,y:32636,ptovrint:False,ptlb:Vein Int,ptin:_VeinInt,varname:node_6717,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:4858,x:33347,y:32940,varname:node_4858,prsc:2|A-6277-OUT,B-2297-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2297,x:33228,y:33194,ptovrint:False,ptlb:Opcity,ptin:_Opcity,varname:node_2297,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_TexCoord,id:467,x:31450,y:32410,varname:node_467,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:5558,x:31069,y:32616,varname:node_5558,prsc:2;n:type:ShaderForge.SFN_Append,id:419,x:31293,y:32776,varname:node_419,prsc:2|A-8901-OUT,B-1864-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8901,x:31069,y:32809,ptovrint:False,ptlb:U Speed,ptin:_USpeed,varname:node_8901,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:1864,x:31069,y:32899,ptovrint:False,ptlb:V Speed,ptin:_VSpeed,varname:_node_8901_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:2001,x:31450,y:32593,varname:node_2001,prsc:2|A-5558-T,B-419-OUT;n:type:ShaderForge.SFN_Add,id:4694,x:31642,y:32547,varname:node_4694,prsc:2|A-467-UVOUT,B-2001-OUT;n:type:ShaderForge.SFN_TexCoord,id:4047,x:31943,y:33578,varname:node_4047,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_Time,id:1128,x:31562,y:33784,varname:node_1128,prsc:2;n:type:ShaderForge.SFN_Append,id:7331,x:31786,y:33944,varname:node_7331,prsc:2|A-981-OUT,B-5281-OUT;n:type:ShaderForge.SFN_ValueProperty,id:981,x:31562,y:33977,ptovrint:False,ptlb:Vein U Speed,ptin:_VeinUSpeed,varname:_USpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:5281,x:31562,y:34067,ptovrint:False,ptlb:Vein V Speed,ptin:_VeinVSpeed,varname:_VSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:7072,x:31943,y:33761,varname:node_7072,prsc:2|A-1128-T,B-7331-OUT;n:type:ShaderForge.SFN_Add,id:8379,x:32135,y:33715,varname:node_8379,prsc:2|A-4047-UVOUT,B-7072-OUT;n:type:ShaderForge.SFN_Tex2d,id:2930,x:32567,y:33556,ptovrint:False,ptlb:VeinTex,ptin:_VeinTex,varname:node_2930,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8379-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6763,x:32594,y:33759,ptovrint:False,ptlb:VeinIns,ptin:_VeinIns,varname:node_6763,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:5159,x:32905,y:33444,varname:node_5159,prsc:2|A-2930-RGB,B-6763-OUT,C-2010-RGB,D-8532-A;n:type:ShaderForge.SFN_Color,id:2010,x:32594,y:33854,ptovrint:False,ptlb:VeinColor,ptin:_VeinColor,varname:node_2010,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_VertexColor,id:8532,x:32392,y:33346,varname:node_8532,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7510,x:33423,y:33284,varname:node_7510,prsc:2|A-2297-OUT,B-8532-A;proporder:7867-4745-6717-9305-4348-2297-8901-1864-981-5281-2930-6763-2010;pass:END;sub:END;*/

Shader "Lapis/Effect/FresnelRoll_Blend" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _MainTexColor ("MainTex Color", Color) = (0.5,0.5,0.5,1)
        _VeinInt ("Vein Int", Float ) = 0
        _FresInt ("Fres Int", Range(0, 10)) = 1
        [HDR]_FresColor ("Fres Color", Color) = (0.4386792,0.6970649,1,1)
        _Opcity ("Opcity", Float ) = 1
        _USpeed ("U Speed", Float ) = 0
        _VSpeed ("V Speed", Float ) = 0
        _VeinUSpeed ("Vein U Speed", Float ) = 0
        _VeinVSpeed ("Vein V Speed", Float ) = 0
        _VeinTex ("VeinTex", 2D) = "white" {}
        _VeinIns ("VeinIns", Float ) = 0
        [HDR]_VeinColor ("VeinColor", Color) = (0.5,0.5,0.5,1)
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
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float _FresInt;
            uniform float4 _FresColor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _MainTexColor;
            uniform float _VeinInt;
            uniform float _Opcity;
            uniform float _USpeed;
            uniform float _VSpeed;
            uniform float _VeinUSpeed;
            uniform float _VeinVSpeed;
            uniform sampler2D _VeinTex; uniform float4 _VeinTex_ST;
            uniform float _VeinIns;
            uniform float4 _VeinColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
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
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 node_5558 = _Time;
                float2 node_4694 = (i.uv0+(node_5558.g*float2(_USpeed,_VSpeed)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_4694, _MainTex));
                float4 node_1128 = _Time;
                float2 node_8379 = (i.uv1+(node_1128.g*float2(_VeinUSpeed,_VeinVSpeed)));
                float4 _VeinTex_var = tex2D(_VeinTex,TRANSFORM_TEX(node_8379, _VeinTex));
                float3 node_4858 = (((_MainTex_var.rgb*_VeinInt*_MainTexColor.rgb*i.vertexColor.a)+(_FresColor.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresInt)*i.vertexColor.rgb)+(_VeinTex_var.rgb*_VeinIns*_VeinColor.rgb*i.vertexColor.a))*_Opcity);
                float3 diffuseColor = node_4858;
                float3 diffuse = directDiffuse * diffuseColor;
////// Emissive:
                float3 emissive = node_4858;
/// Final Color:
                float3 finalColor = diffuse + emissive;
                return fixed4(finalColor,(_Opcity*i.vertexColor.a));
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
