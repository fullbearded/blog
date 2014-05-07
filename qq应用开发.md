# QQ应用开发

## QQ应用开发背景
1. 更好的推广品牌
2. 利用腾讯海量用户，从而迅速积聚用户量
3. 其他

## QQ应用演示
我们公司有两个QQ应用

一个的调取地址是：http://qq.app.tao800.com/  	老版

另外一个是：http://qq.app.zhe800.com/qq_tao  新版


## QQ空间应用开发具体步骤

1. 申请成为QQ开放平台开发者 
   
   链接：http://wiki.open.qq.com/wiki/%E6%B3%A8%E5%86%8C%E6%88%90%E4%B8%BA%E5%BC%80%E5%8F%91%E8%80%85

2. 创建应用
	注：应用部署，腾讯托管和非腾讯托管
	链接：http://wiki.open.qq.com/wiki/%E5%BA%94%E7%94%A8%E6%8E%A5%E5%85%A5%E6%96%B0%E6%89%8B%E6%8C%87%E5%BC%95

3. 应用调试

4. 申请上线
	
#### QQ应用开发注意事项
 
1. 注： 填写平台信息中填入应用开发地址：http://demo.com

2. 在本地绑定 127.0.0.1 demo.com

3. 点击调试即可

注1：

因为QQ应用是将我们的项目以iframe的形式嵌入到页面中的，故需要在rails4项目中（rails3不用），加入配置：config.action_dispatch.default_headers = {'X-Frame-Options' => 'ALLOWALL'}

注2：

调用API需要appid, appkey

调用API测试环境： 119.147.19.43
	  生产环境：openapi.tencentyun.com
	  
注3：

QQ应用中的信任IP，这里需要填你服务器的IP，注意，这个IP只能加不能删，所以需要注意一下。

如果不填写信任IP，那么你的应用服务就不能获取到数据

#### api接口调用

QQ开放平台在调用应用时，跳到应用首页时url会带上参数：openid,openkey,pf,pfkey

我们在调用应用API时都需要openid,openkey,pf这三个参数，且需要用这三者和其他参数生成签名后调用。

需要生成签名：http://wiki.open.qq.com/wiki/%E8%85%BE%E8%AE%AF%E5%BC%80%E6%94%BE%E5%B9%B3%E5%8F%B0%E7%AC%AC%E4%B8%89%E6%96%B9%E5%BA%94%E7%94%A8%E7%AD%BE%E5%90%8D%E5%8F%82%E6%95%B0sig%E7%9A%84%E8%AF%B4%E6%98%8E

签名使用了HMAC-SHA1加密算法

HMAC_SHA1(Hashed Message Authentication Code, Secure Hash Algorithm)是一种安全的基于加密hash函数和共享密钥的消息认证协议。它可以有效地防止数据在传输过程中被截获和篡改，维护了数据的完整性、可靠性和安全性。

HMAC_SHA1消息认证机制的成功在于一个加密的hash函数、一个加密的随机密钥和一个安全的密钥交换机制。

HMAC_SHA1 其实还是一种散列算法,只不过是用密钥来求取摘要值的散列算法。

HMAC_SHA1算法在身份验证和数据完整性方面可以得到很好的应用，在目前网络安全也得到较好的实现。

api接口调试工具：

http://open.qq.com/tools



## QQ应用所使用到的相关技术

## rails engines
##### rails engines 是什么?

一个 Rails应用程序实际上就是一个 “加强版”engine, 我们可以把engine看作一个微型的应用程序 ,因为 Rails::Application 继承了来自 Rails::Engine 的更多习惯。

#####  为什么使用rails engines？
1. QQ应用的业务逻辑和主站基本相同，我们可以公用很多代码，从而提升维护性
2. 使用方便，操作简洁（就相当于一个小rails）

#### 创建步骤：

1. rails plugin new qq_app --mountable  创建qq_app engine
2. mount QqApp::Engine, at: 'qq_app'	 挂载路由
3. gem 'qq_app', path: 'qq_app'   		 挂载engine

这时，qq_app下就相当于一个独立的小rails
你可以在qq_app下执行创建controller，model等的操作

#### 使用：

migrations操作

* 子目录中：rails g model xxx / rails g migration xxx
* 拷贝父目录中的数据 cp db/migrate/20130911154334_create_users.rb qq_app/db/migrate/
* 修改代码数据（具体参考文档4.2）
* rake railties:install:migrations (拷贝子目录的migration到父目录)
* rake db:migrate


## ActiveSupport::Concern

缘由：因为我们空间应用中许多比如model,helper,controller等都是一样的，如果全部拷贝的话，可维护性差，所以我们把这部分可以公用的代码给提取了出来, 使用了 ActiveSupport::Concern 

源码：gems/activesupport-4.0.0/lib/active_support/concern.rb

ActiveSupport::Concern 主要用于模块的引用,作用：
1. 简化self.included 方法
2. 用于模块之间方法的相互调用

代码中 lib/concern/* 

相关model都引用了 lib/concern/* 下的模块

## ActiveRecord::Store

将任意格式的数据序列化保存到数据库中去。


参考文档：

腾讯应用开发文档：http://wiki.open.qq.com/wiki/PC%E5%BA%94%E7%94%A8%E6%8E%A5%E5%85%A5wiki%E7%B4%A2%E5%BC%95

rails engine文档：http://guides.rubyonrails.org/engines.html

active_record strore文档: http://api.rubyonrails.org/classes/ActiveRecord/Store.html