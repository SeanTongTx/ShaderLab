# ShaderLab/UnityPBR

Unity内部的PBR 解析
和大部分PBR模型是一致的,只是在部分项上进行了修改。
(https://blog.csdn.net/qq_35817700/article/details/88571270)

针对平行光的 PBR光照实现分为两种情况，一种是简化版的实现，位于"UnityStandardCoreForwardSimple.cginc"文件中
，一种是标准版的实现，位于"UnityStandardCore.cginc"文件中 。
代码中的"vertAdd"函数与"fragAdd"函数实际为Pass2中针对普通光源所采用的顶点与片段函数。
针对"UnityStandardCore.cginc"文件来查看"vertForwardBase"函数与"fragForwardBaseInternal"函数的实现，即标准版平行光光照下PBR的实现 。
