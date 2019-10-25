using SeanLib.Core;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialFX : MonoBehaviour
{
    public MaterialAnimator[] anims;

    private void Start()
    {
        CollectAnimators();
    }
    public void CollectAnimators()
    {
        anims = gameObject.GetComponentsInChildren<MaterialAnimator>();
    }
    public string state;
    [InspectorPlus.Button]
    public void Play()
    {
        foreach (var anim in anims)
        {
            anim.Play(state);
        }
    }
}
