using EditorPlus;
using SeanLib.CodeTemplate;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.ShaderLab
{
   //[CreateAssetMenu(fileName = "View", menuName = "CodeTemplate/ShaderLab/View", order = 50)]
    public class View:ShaderElement
    {
        [SerializeField]
        [HideInInspector]
        protected Space space = Space.Object;
        [Multiline]
        public string Vert_space_obj;
        [Multiline]
        public string Vert_space_world;
        [Multiline]
        public string Vert_space_tangent;


        public override ElementData Generate()
        {
            var data = base.Generate();
            switch (space)
            {
               case Space.Object: data.vert = Generater.Generate(Vert_space_obj, Values); break;
               case Space.World: data.vert = Generater.Generate(Vert_space_world, Values); break;
                case Space.Tangent: data.vert = Generater.Generate(Vert_space_tangent, Values); break;
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
            space = (Space)EditorGUILayout.EnumPopup("空间", space);
        }
    }
}
