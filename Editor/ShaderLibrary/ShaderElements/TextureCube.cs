using EditorPlus;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;
using SeanLib.CodeTemplate;

namespace SeanLib.ShaderLab
{

   //[CreateAssetMenu(fileName = "TextureCube", menuName = "CodeTemplate/ShaderLab/TextureCube", order = 50)]
    public class TextureCube:Texture2D
	{
		[SerializeField]
		[HideInInspector]
		protected bool DecodeHDR;
		[SerializeField]
		[HideInInspector]
		protected bool UseReflectProbe;

		[Multiline]
        public string FragSimple;
        [Multiline]
		public string FragHDR;

		public override ElementData Generate()
		{
	    	var generateData= base.Generate();
			if (UseReflectProbe)
			{
				generateData.Pass_Properties = string.Empty;
			}
			if (DecodeHDR)
	    	{
		    	generateData.frag=Generater.Generate(FragHDR,KeyWords,ValueDic.Values);
	    	}
	    	else
	    	{
		    	generateData.frag=Generater.Generate(FragSimple,KeyWords, ValueDic.Values);
	    	}
            return generateData;
	    }
		protected override void ExtensionGUI()
		{

			EditorGUI.BeginChangeCheck();
			TexLod = EditorGUILayout.Toggle("Lod采样", TexLod);
			DecodeHDR = EditorGUILayout.Toggle("解码HDR贴图", DecodeHDR);
			UseReflectProbe = EditorGUILayout.Toggle("使用反射探针", UseReflectProbe);
			if (!UseReflectProbe)
			{
				EditorGUILayout.BeginHorizontal();
				{
					GUILayout.Label("默认值");
					DefaultTextures.OnGui(EditorStyles.miniButton);
				}
				EditorGUILayout.EndHorizontal();
			}
			if (EditorGUI.EndChangeCheck())
			{
				SetReflectProbe();
				SetDefaultValue();
				SetLod();
			}
		}
		protected void SetReflectProbe()
		{
			UIRoot.Q<KeyWordInput>(K_TexName).style.display= UseReflectProbe? DisplayStyle.None:DisplayStyle.Flex;
			if (UseReflectProbe)
			{
				SetValue(K_TexName, "unity_SpecCube0");
			}
			//UIRoot.Q<KeyWordInput>(K_DefaultTexture).style.display = UseReflectProbe ? DisplayStyle.None : DisplayStyle.Flex;
		}
        protected override void SetLod()
        {
            SetValue(K_TexFunction, TexLod ? "UNITY_SAMPLE_TEXCUBE_LOD" : "UNITY_SAMPLE_TEXCUBE");
        }
    }
}
