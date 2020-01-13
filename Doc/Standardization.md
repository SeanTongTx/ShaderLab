# ShaderLab/Standardization
标准化
## 约定俗成

有些标准是长期使用下来的固定搭配。
准守这些大家约定俗成的标准，可以更好的兼容别人产品。


# ShaderLOD

VertexLit kind of shaders = 100
Decal, Reflective VertexLit = 150
Diffuse = 200
Diffuse Detail, Reflective Bumped Unlit, Reflective Bumped VertexLit = 250
Bumped, Specular = 300
Bumped Specular = 400
Parallax = 500
Parallax Specular = 600
为了可以统一管理，ShaderLab中所有Shader都应该符合这标准。
参考Unity ShaderLOD。
(https://docs.unity3d.com/Manual/SL-ShaderLOD.html)