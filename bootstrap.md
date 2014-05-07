# sass scss less bootstrap compass

### 名词解释

1. CSS预处器：CSS预处理器用一种专门的编程语言，进行Web页面样式设计，然后再编译成正常的CSS文件，以供项目使用

2. Sass：Sass是对CSS（层叠样式表）的语法的一种扩充，是最早最成熟的一款css预处理器。可以使用变量函数等功能，能更加有效更弹性的书写css。

3. Scss：sass的另外一套语法规则，从sass3.0开始，使用新的语法规则

4. Less：less是一种动态样式语言。

5. Bootstrap是一个用于前端开发的开源工具包。

6. Compass是一个sass的Framework。简单来说就是将sass中的很多样式，compass都已经帮忙写好了，	再加入了一些常用的功能，并且简化了写法，极大了提高了开发效率。

---

### sass

语法看demo

使用：
监控sass并生成css文件

> sass --watch --style expanded style.scss:style.css 

压缩生成：

> sass --watch --style compressed style.scss:style.css

官方文档： http://sass-lang.com/

预定义函数：http://sass-lang.com/docs/yardoc/_index.html


### compass

compass就是sass中的rails，语法同sass。

使用：

编译生产环境的文件：

compass compile --output-style compressed

自动编译：

compass watch

compass 的模块：
 
> reset
> css3
> layout
> typography
> utilities

compass sprite 

参考： http://compass-style.org/help/tutorials/spriting/

参考： http://compass-style.org/help/tutorials/production-css/


### less

语法和sass基本类似。具体可以看less官方文档。bootstrap就是用less写的。

less中文文档：http://www.lesscss.net/article/home.html

less官方文档：http://lesscss.org/

bootstrap git库：

git clone https://github.com/twbs/bootstrap.git

###  bootstrap

看demo

列了一些比较常用的用法。