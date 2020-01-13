# UV 
采样坐标
## 关键字 

1·网格UV编号 ：模型uv编号。uv,uv1,uv2,uv3 正常情况最多4套uv。
2·贴图名称 ：关联贴图平铺/平移(_ST)数据。
3·uv输出 ：变形(平铺/偏移)后的uv输出。可以直接拿来采样贴图。
## 空间
1·裁剪空间(默认)：通过模型uv处理。
2·屏幕空间：屏幕空间不需要模型uv输入。因此uv编号无效。
其次屏幕空间uv 在采样时需要额外除以screen.w。参考文献
>>Article/UnityBuiltIn/ComputeScreenPos函数