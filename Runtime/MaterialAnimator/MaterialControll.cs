using SeanLib.Core;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialControll : MonoBehaviour
{
    public Animator[] anims;

    private void Start()
    {
        anims=gameObject.GetComponentsInChildren<Animator>();
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
