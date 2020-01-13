using EditorPlus;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.Presets;
using UnityEngine;
using UnityEngine.UIElements;
namespace SeanLib.ShaderLab
{
    public class Color : ShaderElement
    {
        public const string DefaultColor = "COLOR_DEFAULT";
        public const string Attributes = "ATTRIBUTES";
        [SerializeField]
        protected Property_Attribute[] avaliableAttributes;
        [SerializeField]
        [HideInInspector]
        protected List<AttributeData> attributes = new List<AttributeData>();
        [SerializeField]
        [HideInInspector]
        protected UnityEngine.Color color = UnityEngine.Color.white;
        private OnGUIUtility.FadeGroup group_attribute = new OnGUIUtility.FadeGroup();
        public override void DefaultSetupElements()
        {
            attributes.Clear();
            foreach (var item in avaliableAttributes)
            {
                attributes.Add(new AttributeData() { attribute = item });
            }
            base.DefaultSetupElements();
            group_attribute.OnEnable(this.lab.window.Repaint);
            var extension = UIRoot.Q("Extension");
            extension.Add(new IMGUIContainer(ExtensionGUI));
        }
        private void ExtensionGUI()
        {
            EditorGUI.BeginChangeCheck();
            color = EditorGUILayout.ColorField("默认值", color);
            if (EditorGUI.EndChangeCheck())
            {
                SetValue(DefaultColor,Shader_Properties.DefaultColor(color));
            }
            if (group_attribute.OnGuiBegin("特性"))
            {
                EditorGUI.BeginChangeCheck();
                for (int i = 0; i < attributes.Count; i++)
                {
                    var item = attributes[i];
                    Shader_Properties.GUI(item, GUI.skin.button);
                }
                if (EditorGUI.EndChangeCheck())
                {
                    SetValue(Attributes, Shader_Properties.PropertyAttributes(attributes));
                }
            }
            group_attribute.OnGuiEnd();
        }
        public override void SetPreview()
        {
            SetValue(DefaultColor, Shader_Properties.DefaultColor(color));
            SetValue(Attributes, Shader_Properties.PropertyAttributes(attributes));

            base.SetPreview();
        }
        public override void OnDestory()
        {
            base.OnDestory();
            group_attribute.OnDisable(this.lab.window.Repaint);
        }
    }
}