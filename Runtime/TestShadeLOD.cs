using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class TestShadeLOD : MonoBehaviour
{
    public int LOD=601;

    private void OnValidate()
    {
        Shader.globalMaximumLOD = LOD;
    }

}
