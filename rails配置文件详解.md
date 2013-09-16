# rails的框架结构与常用配置
## (一) rails的框架结构
### rails的三种模式 
*. 开发模式 development<br />
*. 测试模式 test<br />
*. 生产模式 production <br />
> config/environments/development.rb  配置文件
> config/environments/test.rb         配置文件 
> config/environments/production.rb   配置文件

开发环境里注重代码的调试运行，测试提供了一种可以重复的环境，且产品环境下当然就注重了代码运行的性能问题了
### rails MVC 模式 
1. MVC软件架构模式 <br />
  Model(模型层): 处理数据及业务逻辑 <br />
  Controller(控制层): 处理用户请求及应用逻辑 <br />
  View(视图层): 显示用户界面 <br />
2. rails 的MVC <br />
    ActiveRecord <br />
      实现对数据库的抽象，ORM(bject/Relation Mapping) 对象-关系映射模型  <br />
    ActionController <br />
      决定了如何处理用户的请求, 并生成响应 <br />
    ActionView <br />
      显示用户的界面 <br />
3. rails 的模块 <br />
  actionpack : 是一个独立的gem，包括以下三部分,是MVC 的VC层 <br />
    -- action\_controller <br />
    -- action\_dispatch : 处理web请求的路由等 <br />
    -- action\_view <br />
  activemodel <br />
  activerecord <br />
  activeresource <br />
  activesupport : 工具类和ruby标准库的扩展<br />
  actionmailer : 收发邮件模块 <br />
  railties :是rails framework的核心，用来提供各种回调方法以及扩展，或者修改初始化的process. 实际上每个rails组件(ActionMailer,Action Controller)都是一个railtie, 每个组件都有自己的初始化代码，这样rails就不用去专门把初始化工作都自己来做，只要在正确的时候调用各组件的初始化代码就可以了。

4. rails 加载顺序
> boot.rb: 配置Bundler以及加载路径 <br />
> application.rb: 根据不同的启动环境（Rails.env）加载不同的rails gems, 配置应用程序 <br />
> environment.rb: 加载所有的initializers <br />
> 这三个文件都在启动整个rails环境时加载。
> 
> 1. require 'config/boot.rb' 配置Bundler以及加载路径
> 2. 载入相关的railties和engines
> 3. 定义项目 Define Rails.application as "class MyApp::Application < Rails::Application
> 4. Run config.before_configuration callbacks
> 5. Load config/environments/ENV.rb
> 6. Run config.before_initialize callbacks
> 7. Run Railtie#initializer defined by railties, engines and application.  its config/initializers/* files
> 8. Custom Railtie#initializers added by railties, engines and applications are executed  ## 载入 相关的加载项 autoload_paths
> 9.  Build the middleware stack and run to_prepare callbacks
> 10. Run config.before_eager_load and eager_load if cache classes is true
> 11. Run config.after_initialize callbacks
>
> 源码文件： /usr/local/rvm/gems/ruby-1.9.3-p194/gems/railties-3.2.11/lib/rails/application.rb

5. 使用rack构建rails中间件
1). Rack: rack 提供了用ruby开发web应用的一个接口。 <br />
规范：接受一个env, 返回http的全部,(status, header, body)

2). rack 和 web framework 中间件middleware <br />
查看rails的middleware: rake middleware <br />
> use ActionDispatch::Static   <br />
> use Rack::Lock  <br />
> use ActiveSupport::Cache::Strategy::LocalCache::Middleware:0x007f926db35978 <br />
> use Rack::Runtime  <br />
> use Rack::MethodOverride <br />
> use ActionDispatch::RequestId <br />
> use Rails::Rack::Logger <br />
> use ActionDispatch::ShowExceptions <br />
> use ActionDispatch::DebugExceptions <br />
> use ActionDispatch::RemoteIp <br />
> use ActionDispatch::Reloader <br />
> use ActionDispatch::Callbacks <br />
> use ActiveRecord::ConnectionAdapters::ConnectionManagement <br />
> use ActiveRecord::QueryCache <br />
> use ActionDispatch::Cookies <br />
> use ActionDispatch::Session::CookieStore <br />
> use ActionDispatch::Flash <br />
> use ActionDispatch::ParamsParser <br />
> use ActionDispatch::Head <br />
> use Rack::ConditionalGet <br />
> use Rack::ETag <br />
> use ActionDispatch::BestStandardsSupport <br />
> run Demo::Application.routes <br />

参考：http://robbinfan.com/blog/40/ruby-off-rails

config.middleware.delete(middleware) 删除中间件
Railtie为所有rails组件提供了和Rails整合的接口，使他们可以定义自己的初始化内容，可以有自己的配置。 Engine继承于Railtie, 提供了一个功能最小化的Rails文档结构，Application继承于Engine, 在Engine的基础上定义了一个完整Rails所需要的Initializers和middleware,同时在启动时负责加载Rails程序中其他组件的所有Initializers。

## (二).rails常用配置

### rails_config
> gem "rails_config" <br />
> rails g rails_config:install <br />
> config/initializers/rails_config.rb  <br />
> 层级: <br />
> config/settings.yml < config/settings.local.yml           < config/environments/development.local.yml <br />
> config/settings.yml < config/environments/development.yml < config/environments/development.local.yml <br />
> Settings.reload! 修改settings文件后重载 

### application.rb 配置文件, development,test,production三种环境都会加载


(1). 
config.root 
>项目路径

(2)
config.autoload\_paths += %W(#{config.root}/lib #{config.root}/others ) 
> 接受一个路径数组, Rails将会自动加载这些路径内的常量. 默认是app目录下的所有目录.

(3) 一般没用 <br />
config.plugins = [ :exception\_notification, :ssl\_requirement, :all ]
> 正常情况,rails会按照字母顺序加载插件，但如果你遇到了问题，需要改变加载顺序，上面的配置代码可以完成这一点。 折800好像没有用插件机制 <br />
> 插件的安装：rails plugin install git://github.com/newrelic/rpm.git # 回到vendor/plugins下面
> Rails3以后，已经不建议使用插件。而应该把插件做成 gem 来安装

(3) 
config.filter\_parameters += [:password]
> 从日志中移除password的参数,用"[FILTERED]" 替代，出于安全考虑

(4) 
config.time\_zone
> 设置应用程序 Active Record 可用的默认时区 <br />
> rake time:zones:all 运行可以知道具体的时区设置

(5) 
config.i18n.default\_locale  
> 设置某个使用 i18n 应用程序的默认本地语言环境 

config.i18n.load\_path

> 设置 Rails 用来搜索本地化文件的路径。

(6)
config.encoding 
> 设置整个应用程序的编码. 默认是 UTF-8

(7)
config.active\_support.escape\_html\_entities\_in\_json 
> 设置在 JSON 序列化中是否剔除 HTML 实体。默认为 true <br />
> source:  activesupport-3.2.11/lib/active\_support/json/encoding.rb <br />
> ActiveSupport::escape\_html\_entities\_in\_json = true
> 好像没效果~

(10)
config.active\_record.schema\_format = :sql
> schema的格式 默认是ruby格式, sql为纯sql的形式

(11)
config.active\_record.whitelist\_attributes = true
> 将会创建一个空白的白名单，这个名单包含了在批量赋值 (mass assignment) 防护下可进行批量赋值的模型属性,取消则失去防护效果 <br />
> rails 4 好像没得这个问题了, config.active\_record.whitelist\_attributes 设定被移除了，预设改为可以设定大量赋值(Mass assignment)

(12)
config.assets.enabled = true
> 控制是否使用 asset pipeline
> 可以通过命令：rake assets:clean  清除编译后的静态文件
>               rake assets:precompile  编译静态文件

### config/environments/development.rb 文件
(1) 
config.cache\_classes = false
> 开发模式的环境配置为config.cache_classes = fasle 每次都会重新加载类
> 生产模式下设置为true，每次请求过来不会重新加载类

(2)
config.whiny\_nils = true
> 如果调用的nil.abc 会抛出rails的异常
> eg: Called id for nil, which would mistakenly be 4 -- if you really wanted the id of nil, use object_id

config.whiny\_nils = false
> 抛出普通异常
> eg: undefined method `id' for nil:NilClass
> rails 4 好像已经去掉这个配置

(3) 
config.consider\_all\_requests\_local = true
> 如果为 true 则任何携带详细调试信息的错误信息都会被添加到 HTTP 回应(response) 里
> 生产模式下设置为 false

(4)
config.action\_controller.perform\_caching
> 配置应用程序是否在controller和views里进行缓存。因为Rails.cache, 开发模式默认关闭，在生产模式默认开启.
> 注：默认的缓存模式是文件模式，tmp/cache/* 
> 如果需要改缓存模式
> config.action\_controller.cache_store 针对action缓存和片段缓存
> config.cache\_store 配置Rails缓存要使用什么缓存存储 页面缓存

(5)
config.action\_mailer.raise\_delivery\_errors 
> 发送邮件失败时是否抛出异常，默认true 开发false


(6) config.active\_support.deprecation  :log, :notify, :stderr
> 可选的设置器，它能配置 Rails 废弃警告的动作。

(7) config.action\_dispatch.best\_standards\_support = :builtin 
> 参考：http://ihower.tw/rails3/environments-and-bundler.html

（8） config.active\_record.mass\_assignment\_sanitizer = :strict
> 将会判断 Rails 中对批量赋值(mass assignment)清理的严格程度。默认为 :strict. 在这个模式下，调用 create 或者 update\_attributes 并对任何不是attr\_accessible的属性进行批量赋值的话，将会抛出一个异常。如果设置这个选项为 :logger的话，只会将某个属性被赋值时的异常信息打印到日志文件，并不抛出异常。

(9) config.active\_record.auto\_explain\_threshold\_in\_seconds = 0.5 
> 配置自动执行(sql指令)EXPLAIN的临界值。所有逼近临界值的查询会把它们的查询计划进行日志记录。在开发模式下默认是 0.5。

(10)
config.assets.compress 标记是否压缩已经编译好的资源 <br />
config.assets.debug 不合并压缩资源 

### production.rb 
(1)
不用更改
config.serve\_static\_assets = false 
> 配置rails自己处理静态资源，开发模式下没有必要，因为我们已经有nginx了，我们一般的做法是将静态资源放到public下面,然后通过nginx去处理这些静态资源

(2) 
config.assets.compress = true
> 标记是否压缩已经编译好的资源 (这玩意没用过)

(3)
config.assets.compile = false 
> 可以用于让Sprockets 在生产环境即时执行编译。一般不建议开启，因为编译的时候会增加服务器负担，对于一个线上环境是不可靠的

(4) config.assets.digest = true
> 使资源的名字使用 MD5 指纹, 

(5)  config.assets.manifest = YOUR\_PATH
> 指定资源预编译器的待编译列表文件所在目录完整的路径。
> 默认使用 config.assets.prefix

(6) config.force\_ssl = true 
> 强制所有的请求使用ActionDispath::SSL中间件走 HTTPS 协议.

(7) config.log\_level 定义日志的级别
> production模式为:info, :debug最大

(8) config.action\_controller.asset\_host = "http://assets.example.com"  
> 设置资源主机。当CDNs被用于资源主机而不是应用程序自己处理资源时很有用.

(9) config.assets.precompile 
> 让你指定其它（application.css 和 application.js以外的）资源，这些资源会在 rake assets:precompile 执行时被预编译.

(10) config.i18n.fallbacks = true  
> 当I18n.default_locale 没有找到时会在所有的locals下面去找


参考：<br />
http://ihower.tw/rails3/security.html             rails安全性 <br />
http://guides.rubyonrails.org/rails\_on\_rack.html  rack指导 <br />
http://guides.rubyonrails.org/configuring.html    rails configure详细解析





