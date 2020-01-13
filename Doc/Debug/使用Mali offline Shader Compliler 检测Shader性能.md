# 使用Mali offline Shader Compliler 检测Shader性能 


## 简介 

Malisc 是ARM提供的offline Shader编译器，可以方便的使用它验证自己Shader代码的语法和性能。
Malisc并且可以给出其在不同的Mali GPU上的指令执行数量以及所需要的Circle数。
可以从ARM的官方Graphics Development Tool中下载到。
参考官方文档
(https://developer.arm.com/docs/101863/latest/introduction)

## 简单使用教程

### 检测Shader中片段运算效率
·下载并安装Malisc
·选择要检测的unity Shader。点击Compile and show code。
!(img/Malisc/1.jpg)
·查找编译后Shader中gles部分代码，如图
!(img/Malisc/2.jpg)
·复制Fragment中代码，存储到Malisc文件夹中，重命名为f.frag。
注意.frag文件中 #version必须放第一行
!(img/Malisc/3.jpg)
·回到Malisc目录中用命令行运行(win10 powershell)
执行 Malisc f.frag
!(img/Malisc/4.gif)

### 简单注释

|关键字|	解释
|--:|--:
|A|	算数计算,在片段中算数计算决定了GPU执行的指令量。大量算数运算会导致大量发热。
|L/S|	寄存器存取 GPU的寄存器的数量是有上限的。过多的存取指令会印象并行效率。
|T|	贴图采样 贴图采样是非常慢的，这主要影响字带宽占用上。

