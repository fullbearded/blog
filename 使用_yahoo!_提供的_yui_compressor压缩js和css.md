#使用 Yahoo! 提供的 YUI Compressor压缩js和css
### 官方文档

http://yui.github.io/yuicompressor/

### 安装

1. 按照java执行环境
mac： 已经自带了java环境
centos: yum install java
ubuntu: apt-get install sun-java6-jre

2. 下载稳定版的YUI Compressor
https://github.com/yui/yuicompressor/releases

<pre>
wget https://github.com/yui/yuicompressor/releases/download/v2.4.8/yuicompressor-2.4.8.jar
</pre>

### 使用

压缩js：
<pre>
java -jar yuicompressor-x.y.z.jar myfile.js -o myfile-min.js --charset utf-8 --type js
</pre>
压缩css：
<pre>
java -jar yuicompressor-x.y.z.jar myfile.css -o myfile-min.css --charset utf-8 --type css
</pre>

参数说明：

--type js|css
	压缩类型：（不用加也可以自动判断）
	
--charset 
	压缩成什么编码的文件
	
-o file
	压缩输出的文件地址
	
only javascript:

--nomunge
	只压缩，不混淆
	
--preserve-semi
	保留不重要的分号(比如'}'前面的分号
	
--disable-optimizations
	禁用细微优化
	
在线压缩：
http://ganquan.info/yui/?hl=zh-CN
