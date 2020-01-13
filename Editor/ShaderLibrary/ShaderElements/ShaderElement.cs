using SeanLib.CodeTemplate;
using System;
using System.Collections.Generic;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;
using SeanLib.Core;
using EditorPlus;
using System.Collections;

namespace SeanLib.ShaderLab
{
    //[CreateAssetMenu(fileName = "NewElement", menuName = "CodeTemplate/ShaderLab/ShaderElement", order = 50)]
    public class ShaderElement : TemplateAsset
    {
        public string TemplateDes;
        /// <summary>
        /// 0 is unlimited
        /// </summary>
        public int AllowMultipleCount = 0;

        [SerializeField]
        protected new ElementData Template;
        public string DocPage = "ShaderLaboratory/ShaderElements";
        public virtual ElementData GenerateTemplate => Template;
        /// <summary>
        /// 隐藏基类模板
        /// </summary>
        [NonSerialized]
        [InspectorPlus.HideInInspector]
        protected new string template;
        public virtual ElementsFileAsset files => new ElementsFileAsset() { BaseType = typeof(ShaderElement), USS = "../ShaderElement.uss", UXML = "../ShaderElement.uxml" };
        protected ShaderLibrary lab;
        protected VisualElement UIRoot;
        public virtual void SetupElements(VisualElement container, ShaderLibrary Lab)
        {
            this.lab = Lab;
            VisualTreeAsset nodeAsset = AssetDatabase.LoadAssetAtPath<VisualTreeAsset>(PathTools.RelativeAssetPath(files.BaseType, files.UXML));
            StyleSheet style = AssetDatabase.LoadAssetAtPath<StyleSheet>(PathTools.RelativeAssetPath(files.BaseType, files.USS));
            UIRoot = nodeAsset.CloneTree();
            UIRoot.styleSheets.Add(style);
            UIRoot.name = TemplateName;
            container.Add(UIRoot);
            DefaultSetupElements();
        }
        public virtual void DefaultSetupElements()
        {
            var elementName = UIRoot.Q<Foldout>("ElementName");
            elementName.text = TemplateName;
            var ElementsContainer = UIRoot.Q<VisualElement>("ElementsContainer");
            UIRoot.Q<Button>("Delete").clickable.clicked += () => lab.DeleteElement(this);
            UIRoot.Q<Button>("Help").clickable.clicked += () =>
            {
                EditorCoroutine.Start(OpenHelper());
            };

            var ToolBox = ElementsContainer.Q("ToolBox");
            var KEYWORDS = UIRoot.Q("KeyWords");
            KEYWORDS.Clear();
            foreach (var kw in keyWords)
            {
                if (kw._(KeyWord.Flag.HideInInspector)) continue;
                var kwInput = new KeyWordInput(lab, kw, this);
                kwInput.RegisterValueChangedCallback((e) =>
                {
                    this.SetValue(kw.key, e.newValue);
                });
                KEYWORDS.Add(kwInput);
            }
            var Des = ElementsContainer.Q<TextField>("Description");
            Des.value = TemplateDes;
            Des.SetEnabled(false);
            //工具箱
            ToolBox.Q<Button>("Preview").clickable.clicked += () => SetPreview();
        }
        public IEnumerator OpenHelper()
        {
            var window = SeanLibDocHub.ShowDocWindow();
            var item = window.SeachIndex("ShaderLab");
            window.SelectIndex(item.id);
            yield return new SeanLibEditorYields.WaitForEditorEnabled(window, item.editor);
            var docEditor = item.editor as EditorMarkDownWindow;
            docEditor.changeDoc(DocPage);
            window.Focus();
        }
        public virtual ElementData Generate()
        {
            //在校验时已经合并过一次
            ///this.MergeValues(UserInput);
            ElementData generateData = new ElementData();
            generateData.Shader_Properties = Generater.Generate(GenerateTemplate.Shader_Properties, keyWords, ValueDic.Values);
            generateData.Shader_Tags = Generater.Generate(GenerateTemplate.Shader_Tags, keyWords, ValueDic.Values);
            generateData.Pass_Tags = Generater.Generate(GenerateTemplate.Pass_Tags, keyWords, ValueDic.Values);
            generateData.Pass_Pragmas = Generater.Generate(GenerateTemplate.Pass_Pragmas, keyWords, ValueDic.Values);
            generateData.appdata = Generater.Generate(GenerateTemplate.appdata, keyWords, ValueDic.Values);
            generateData.v2f = Generater.Generate(GenerateTemplate.v2f, keyWords, ValueDic.Values);
            generateData.Pass_Properties = Generater.Generate(GenerateTemplate.Pass_Properties, keyWords, ValueDic.Values);
            generateData.vert = Generater.Generate(GenerateTemplate.vert, keyWords, ValueDic.Values);
            generateData.frag = Generater.Generate(GenerateTemplate.frag, keyWords, ValueDic.Values);
            return generateData;
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
        public virtual string Verify(List<KeyWordValue> UserInput)
        {
            this.MergeValues(UserInput);
            StringBuilder sb = new StringBuilder();
            foreach (var item in KeyWords)
            {
                if (item._(KeyWord.Flag.Required) && string.IsNullOrEmpty(GetValue(item.key)))
                {
                    sb.Append(item.key).Append("未赋值").Append(Environment.NewLine);
                }
            }
            if (sb.Length != 0) HighLightAnim();
            return sb.ToString();
        }
        public virtual void SetPreview()
        {
            this.MergeValues(lab.UserInputKV.Values);
            lab.PreviewElementData(Generate(), string.Empty);
        }
        public virtual void OnDestory()
        {

        }
        #region Animation

        private EditorTween.TweenHandle handle;
        public void HighLightAnim()
        {
            if (handle != null) return;
            var elementRoot = UIRoot.Q("", "shader-element_root");
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
        public override string ToString()
        {
            return TemplateDes+base.ToString();
        }
    }
}
