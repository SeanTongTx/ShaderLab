using EditorPlus;
using SeanLib.CodeTemplate;
using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.ShaderLab
{
    //[CreateAssetMenu(fileName = "UV", menuName = "CodeTemplate/ShaderLab/UV", order = 50)]
    public class UV:ShaderElement
    {
        public const string K_UVIndex = "UV_INDEX";
        protected Space space=Space.Clip;
        [Multiline]
        public string Vert_ScreenSpace;
        public override void DefaultSetupElements()
        {
            base.DefaultSetupElements();
            var extension = UIRoot.Q("Extension");
            extension.Add(new IMGUIContainer(ExtensionGUI));
            //default
            space = Space.Clip;
        }

        protected virtual void ExtensionGUI()
        {
            EditorGUI.BeginChangeCheck();
            {
                space =(Space)EditorGUILayout.EnumPopup("¿Õ¼ä", space);
            }
            if (EditorGUI.EndChangeCheck())
            {
                SetSpace();
            }
        }
        public override ElementData Generate()
        {
            var generateData= base.Generate();
            switch(space)
            {
                case Space.Screen:
                    {
                        generateData.appdata = string.Empty;
                        generateData.vert = Generater.Generate(Vert_ScreenSpace, keyWords, ValueDic.Values);
                    }
                    break;
            }
            return generateData;
        }
        protected virtual void SetSpace()
        {
            var uvindex = UIRoot.Q<KeyWordInput>(K_UVIndex);
            switch (space)
            {
                case Space.Screen:
                    {
                        uvindex.style.display = DisplayStyle.None;
                    }
                    break;
                default:
                    uvindex.style.display = DisplayStyle.Flex;
                    break;
            }
        }
    }
}
