using EditorPlus;
using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.ShaderLab
{

   // [CreateAssetMenu(fileName = "Texture", menuName = "CodeTemplate/ShaderLab/Texture", order = 50)]
    public class Texture2D:ShaderElement
    {
        public const string K_TexName = "TEXTURE_NAME";
        public const string K_TexFunction = "TEXTURE_FUNC";
        public const string K_DefaultTexture = "TEXTURE_DEFAULT";

        [SerializeField]
        [HideInInspector]
        protected bool TexLod;

        protected OnGUIUtility.TabGroup DefaultTextures = new OnGUIUtility.TabGroup(new string[] {"白","黑","灰" });

        public override void DefaultSetupElements()
        {
            base.DefaultSetupElements();

            var extension = UIRoot.Q("Extension");
            extension.Add(new IMGUIContainer(ExtensionGUI));
            //default
            SetValue(K_DefaultTexture, "White");
            SetLod();
        }
	    protected virtual void ExtensionGUI()
        {
            EditorGUI.BeginChangeCheck();
            {
                EditorGUILayout.BeginHorizontal();
                {
                    GUILayout.Label("默认值");
                    DefaultTextures.OnGui(EditorStyles.miniButton);
                }
                EditorGUILayout.EndHorizontal();
                TexLod = EditorGUILayout.Toggle("Lod采样", TexLod);
            }
            if(EditorGUI.EndChangeCheck())
            {
                SetDefaultValue();
                SetLod();
            }
        }
        protected virtual void SetDefaultValue()
        {
            string value = "White";
            switch (DefaultTextures.Index)
            {
                case 1: value = "Black"; break;
                case 2: value = ""; break;
            }
            SetValue(K_DefaultTexture, value);
        }
        protected virtual void SetLod()
        {
            SetValue(K_TexFunction, TexLod ? "tex2Dlod" : "tex2D");
        }
    }
}
