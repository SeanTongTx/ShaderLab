using EditorPlus;
using SeanLib.CodeTemplate;
using SeanLib.Core;
using System;
using System.Collections.Generic;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.ShaderLab
{
    public abstract class ShaderTemplate : TemplateAsset
    {
        public const string K_Name= "SHADER_NAME";
        [Multiline(3)]
        public string TemplateDes;
        public virtual ElementsFileAsset files => new ElementsFileAsset()
        { BaseType = this.GetType(), USS = "../ShaderTemplate.uss", UXML = "../ShaderTemplate.uxml" };

        public VisualElement UIRoot;
        public ShaderLibrary lab;
        public virtual void SetupElements(VisualElement container, ShaderLibrary Lab)
        {
            VisualTreeAsset nodeAsset = AssetDBHelper.LoadAsset<VisualTreeAsset>(files.BaseType, files.UXML);
            StyleSheet style = AssetDBHelper.LoadAsset<StyleSheet>(files.BaseType, files.USS);
            var tree= nodeAsset.CloneTree();
            container.Add(tree);
            tree.name = TemplateName;
            UIRoot = container;
            UIRoot.styleSheets.Add(style);
            this.lab = Lab;
            DefaultSetupElements();
        }
        public virtual void DefaultSetupElements()
        {
            var elementName = UIRoot.Q<Foldout>("TemplateName");
            elementName.text = TemplateName;
            UIRoot.Q<Button>("Delete").clickable.clicked += () => lab.Clear();
            var KEYWORDS = UIRoot.Q("KeyWords");
            KEYWORDS.Clear();
            foreach (var kw in keyWords)
            {
                if (kw._(KeyWord.Flag.HideInInspector)) continue;
                var kwInput = new KeyWordInput(lab, kw,this);
                kwInput.RegisterValueChangedCallback((e) =>
                {
                    if (e.newValue != e.previousValue)
                    {
                        if (kw._(KeyWord.Flag.Public))
                        {
                            lab.SetInput(kw.key, e.newValue);
                        }
                        else
                        {
                            this.SetValue(kw.key, e.newValue);
                        }
                    }
                });
                KEYWORDS.Add(kwInput);
            }
            var Des = UIRoot.Q<TextField>("Description");
            Des.value = TemplateDes;
            Des.SetEnabled(false);
        }
        public abstract string Generate(List<ShaderElement> elements, List<KeyWordValue> UserInput);
        public abstract ElementData GenerateDatas(List<ShaderElement> elements, List<KeyWordValue> UserInput);
        public virtual bool Verify(List<ShaderElement> elements, List<KeyWordValue> UserInput)
        {
            StringBuilder reportBuilder = new StringBuilder();

            this.MergeValues(UserInput);
            foreach (var item in KeyWords)
            {
                if (item._(KeyWord.Flag.Required)&&string.IsNullOrEmpty(GetValue(item.key)))
                {
                    reportBuilder.Append(item.key).Append("未赋值").Append(Environment.NewLine);
                }
            }
            if (reportBuilder.Length != 0)
            {
                HighLightAnim();
            }
            //检查子元素
            foreach (var item in elements)
            {
                var report= item.Verify(UserInput);
                if(!string.IsNullOrEmpty(report))
                {
                    reportBuilder.Append(item.TemplateName).Append(Environment.NewLine)
                        .Append(report).Append(Environment.NewLine);
                }
            }
            var flag= reportBuilder.Length==0;
            if (!flag) Debug.LogError(reportBuilder.ToString());
            return flag;
        }

        /// <summary>
        /// 处理引用型关键字
        /// </summary>
        /// <param name="UserInput"></param>
        public virtual void HandleRefKeyWords(List<KeyWordValue> UserInput)
        {
            var query = UIRoot.Query<KeyWordInput>();
            query.ForEach((kwi) =>
            {
                if (!kwi.isTextInput)
                {
                    SetValue(kwi.thisKeyWord.key, Generater.Generate(kwi.value, UserInput));
                }
            });
        }

        #region Animation

        private EditorTween.TweenHandle handle;
        public void HighLightAnim()
        {
            if (handle != null) return;
            var elementRoot = UIRoot.Q("", "shader-template_root");
#if UNITY_2019_3_OR_NEWER
            var orginColor = elementRoot.style.borderBottomColor.value;
#elif UNITY_2019_2_3
            var orginColor = elementRoot.style.borderColor.value;
#endif
            handle = EditorTween.Tween((f) =>
            {
#if UNITY_2019_3_OR_NEWER
                var color = UnityEngine.Color.Lerp(orginColor, UnityEngine.Color.red, f);
                elementRoot.style.borderBottomColor = color;
                elementRoot.style.borderLeftColor = color;
                elementRoot.style.borderTopColor = color;
                elementRoot.style.borderRightColor = color;
#elif UNITY_2019_2_3
                 elementRoot.style.borderColor = UnityEngine.Color.Lerp(orginColor, UnityEngine.Color.blue, f);
#endif
            }, 1, EditorTweenCurve.BuiltinCurve.pingpongInOut);
            handle.OnStop = () => handle = null;
        }

        #endregion
    }
}