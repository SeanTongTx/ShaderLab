using EditorPlus;
using SeanLib.CodeTemplate;
using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.ShaderLab
{
   //[CreateAssetMenu(fileName = "Normal", menuName = "CodeTemplate/ShaderLab/Normal", order = 50)]
    public class Normal:ShaderElement
    {
        [SerializeField]
        [HideInInspector]
        protected Space space = Space.Object;

        public string Vert_space_obj;
        public string Vert_space_world;
        public string Vert_space_screen;
        public override ElementData Generate()
        {
            var data= base.Generate();
            switch(space)
            {
                case Space.Object:data.vert =Generater.Generate(Vert_space_obj,Values);break;
                case Space.World: data.vert = Generater.Generate(Vert_space_world, Values); break;
                case Space.Screen: data.vert = Generater.Generate(Vert_space_screen, Values); break;
            }
            return data;
        }
        public override void DefaultSetupElements()
        {
            base.DefaultSetupElements();
            var extension = UIRoot.Q("Extension");
            extension.Add(new IMGUIContainer(ExtensionGUI));
        }

        private void ExtensionGUI()
        {
            space = (Space)EditorGUILayout.EnumPopup("空间",space);
        }
    }
}
