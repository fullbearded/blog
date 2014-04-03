# 淘宝U站开发注意事项
## 淘宝环境搭建
#### 开发指南
http://newwiki.zx.taobao.com/index.php?title=TAE_PHP%E5%BA%94%E7%94%A8%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97#.E5.90.AF.E5.8A.A8SDK.E5.B7.A5.E5.85.B7

#### 配置环境
1. 下载地址：http://bbs.zx.taobao.com/read.php?tid=22997
2. 使用：
	<code>svn checkout http://tae-sdk-2.googlecode.com/svn/trunk/</code>

3. svn后进入F:\tae-sdk-2\TAE_SDK\bin  即bin目录， 然后点那个淘宝的图片启动服务（需要安装java的jdk）按照提示安装即可，进入apps页面，

4. 绑定host
<pre>
127.0.0.1 demo.taobaoapps.net
</pre>

5. 有个demo：http://bangpai.taobao.com/group/thread/15146155-278171087.htm?spm=0.0.0.0.mf49DD

## 开发中遇见的坑

在使用taobao的sdk的过程中你可能会遇到很多问题，因为它规则繁多，所以在开发之前最好仔细阅读下TAE PHP应用开发指南 下面是我们在开发过程中遇到的一些问题：

#### Url无法展示，链接失效？

这是因为taobao对外链的过滤，淘宝禁止一切外链包括图片地址,下面域名是淘宝给出的url白名单：
<pre>
.taobao.com
.taobao.net
.alipay.com
.alibaba.com
.alimama.com
.koubei.com
.alisoft.com
.taobaocdn.com
.taobaocdn.net
.tbcdn.cn
.tmall.com
.etao.com
.juhuasuan.com
.hitao.com
.alicdn.com
</pre>

#### Jquery使用不了？Alert没法用？
淘宝对js的控制也是相当的下功夫：http://newwiki.zx.taobao.com/index.php?title=JS_API
#### Html的class标签大写字母不显示?”tb-”,”sns-”开头被过滤？
请参考：http://newwiki.zx.taobao.com/index.php?title=HTML_WHITELIST 中的class命名规范
#### 经常用的css样式不生效？
css也有白名单：http://newwiki.zx.taobao.com/index.php?title=CSS_WHITELIST 并且淘宝规定布局规范如下：
<pre>
z-index
0 >= z-index <= 99

950控制
所有模板宽度不超过950
</pre>


并且最好尽量少的使用复合型的样式属性，如：font在本次项目开发中就遇到这个问题：font：blod 14px/40px “”;这种样式在线下的测试环境毫无问题上线之后taobao对css进行压缩的时候就会自动把这个属性给干掉；


#### 使用php循环函数（for，foreach，while等）的时候有些值没有遍历出来？

这也是本次项目中遇到的一个相当坑爹的事件：uzhan后台我们做了一个删除全部memcache缓存的功能（当然缓存类也是淘宝封装好了的），必须调取淘宝的缓存类，由于我们的key很多所以封装成数组，然后foreach遍历，在测试的时候发现有很多数据缓存根本无法清理。经过反复的实验才发现是taobao对php的循环函数都做了限制循环100个之后自动跳出循环。
