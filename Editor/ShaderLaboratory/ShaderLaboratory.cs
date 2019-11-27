using EditorPlus;
using SeanLib.Core;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.CodeTemplate
{
    [CustomSeanLibEditor("ShaderLab/ShaderLaboratory")]
    public class ShaderLaboratory : CodeGenerator
    {
        protected override string UXML => "../ShaderLaboratory";
        protected override bool DefaultLayout => false;
        [MenuItem("Assets/Create/CodeTemplate/ShaderGenerator",priority =50)]
        public static void ShowThis()
        {
            var seanwindow = EditorWindow.GetWindow<SeanLibManager>();
            var Item = seanwindow.SeachIndex("ShaderLab/ShaderLaboratory");
            seanwindow.SelectIndex(Item.id);
        }

        ScrollView ShaderElementsContainer;

        VisualTreeAsset elementsNode;
        StyleSheet elementsNode_styles;
        public override void EnableUIElements()
        {
            base.EnableUIElements();
            //SetupElements
            var SaveDirGUI = this.EditorContent_Elements.Q<IMGUIContainer>("savedir-view");
            SaveDirGUI.onGUIHandler = () =>
            {
                EditorGUILayout.LabelField("TODO:工具栏");
            };
            elementsNode = AssetDatabase.LoadAssetAtPath<VisualTreeAsset>(PathTools.RelativeAssetPath(typeof(ShaderElement), "../ShaderElement.uxml"));
            elementsNode_styles = AssetDatabase.LoadAssetAtPath<StyleSheet>(PathTools.RelativeAssetPath(typeof(ShaderElement), "../ShaderElement.uss"));


            ShaderElementsContainer = this.EditorContent_Elements.Q<ScrollView>("ElementContainer");
            var genrateButton = this.EditorContent_Elements.Q<Button>("btn-generate");
            genrateButton.clickable.clicked += OnGenerate;



        }
        public override void OnGUI()
        {
            base.OnGUI();
            EditorGUILayout.LabelField("这里应该是各种模板编辑了吧");
        }
    }
}