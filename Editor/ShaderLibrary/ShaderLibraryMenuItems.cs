
using EditorPlus;
using UnityEditor;

namespace SeanLib.CodeTemplate
{
    public partial class CustomMenuItems
    {
        /*[MenuItem("Assets/Create/CodeTemplate/ShaderLab/Laboratory", priority = 50)]
        public static void ShowThis()
        {
            var seanwindow = EditorWindow.GetWindow<SeanLibManager>();
            var Item = seanwindow.SeachIndex("ShaderLab/ShaderLaboratory");
            seanwindow.SelectIndex(Item.id);
        }*/

        [MenuItem("Assets/Create/CodeTemplate/ShaderElementType", priority = 50)]
        public static void CreateShaderElementType()
        {
            ProjectWindowUtil.StartNameEditingIfProjectWindowExists(0, new EndNameActions.SetFileName2FirstKeyWord(), "NewShaderElementType.cs", EditorGUIUtility.FindTexture("cs Script Icon"), "ShaderElementType t:TemplateAsset");

        }
    }
}