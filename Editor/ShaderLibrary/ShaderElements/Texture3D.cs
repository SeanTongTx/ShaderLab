using EditorPlus;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.ShaderLab
{

   //[CreateAssetMenu(fileName = "Texture3D", menuName = "CodeTemplate/ShaderLab/Texture3D", order = 50)]
    public class Texture3D:Texture2D
    {
        public override void DefaultSetupElements()
        {
            base.DefaultSetupElements();
            SetValue(K_TexFunction, "tex3D");
        }
        protected override void SetLod()
        {
            SetValue(K_TexFunction, TexLod ? "tex3Dlod" : "tex3D");
        }
    }
}
