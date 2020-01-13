
using EditorPlus;
using SeanLib.Core;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.CodeTemplate
{
 [CustomSeanLibEditor("ShaderLab/Lyle'Shader Lib",IsDoc=true)]
    public class LyleShaderLib : EditorMarkDownWindow
    {
          public override string RelativePath => "../../Lyle's Doc";
          public override string ColorSettings => "Color_Lyle'sLibDocHub";
        public override void OnEnable(SeanLibManager drawer)
        {
            base.OnEnable(drawer);
            this.window.wantsMouseMove = true;
        }
    }
}
