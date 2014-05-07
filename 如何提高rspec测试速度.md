# 如何提升rspec测试速度

## why?

随着我们的项目的不断累计，测试代码的不断增加，最终导致我们跑测试的速度越来越慢。为了节约跑测试的时间，所以需要提升rspec测试速度

## how?

#### 0. 删除无用的测试

我们的项目中存在大量的pending,其他大多数都是没有写测试的

### 1. zeus

#### introduce

rails环境预加载的gem包

#### questions

1. zeus 跑rspec 测试会遇见i18n的问题

解决: vim config/application.rb

<code>config.i18n.locale = 'zh-CN'</code>

原因：通过zeus跑rspec测试的时候执行过程中 <code>config.i18n.locale</code>的值为 :en

2. zeus 跑rspec测试会自动跑两次

解决： 注释掉<code>spec/spec_helper.rb</code> 中的 <code>require 'rspec/autorun'</code>, 然后重启zeus

#### 类似的gem

spork

referer: 
https://github.com/burke/zeus

https://github.com/sporkrb/spork


### 2. parallel_tests

#### introduce

以线程的方式将测试分为多个线程来跑程序

#### install

<pre>
gem "parallel_tests", :group => :development
</pre>

modify your <code>config/database.yml</code>

<pre>
test:
  database: yourproject_test<%= ENV['TEST_ENV_NUMBER'] %>
</pre>

然后创建数据库并导入表结构
<pre>
rake parallel:create  # 创建数据库
rake parallel:prepare # 将表结构导入测试数据库
</pre>

#### questions

1. 如果你的测试中进行了多库操作以及调用了memcache，redis操作都需要保证每个线程链接的库或者memcache是唯一的

比如： 项目测试中涉及了 数据A，B，memcache， 那么使用parallel_tests多线程（4核）的跑测试就需要创建数据库 A, A2, A3, A4, B, B2, B3, B4,  memcache, memcache2, memcache3, memcache4, 从而使每个线程的测试环境都独立。 

2. <code>rake parallel:prepare</code>执行后每完成后都会加载rails环境， 所以在创建数据表结构的时候，直接使用mysql客户端操作更快

3. 跑测试时报生成的图片没有该图片的错误

解决：最初是怀疑图片处理 carrierwave 是非线程安全的，然后试着去重写生成图片的方法，结果发现<code>spec/spec_helper.rb</code>中存在这样的代码

<pre>
    config.after(:all) do
      if Rails.env.test? || Rails.env.cucumber?
        FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/[^.]*"])
      end
    end
</pre>

这就导致多线程下所有关于图片处理这块的测试都会报错，因为一个线程结束后会干掉这个目录， 注释掉测试通过（需要定期清除掉目录，否则目录会很大）


#### 类似的gem

* ngauthier-hydra 

已停止开发，它现在也推荐parallel_tests

* specjour

分布式的跑rspec测试，也是多线程的一款，但是这款gem老是对mysql造成很高的负载

CentOS下装 specjour:

<pre>
yum install -y avahi avahi-compat-libdns_sd avahi-compat-libdns_sd-devel
</pre>

referer: 

https://github.com/grosser/parallel_tests

https://github.com/ngauthier/hydra/wiki

https://github.com/sandro/specjour

## zeus-parallel_tests

#### introduce

这款gem包将zeus和parallel_tests结合起来

#### Usage

refere: https://github.com/sevos/zeus-parallel_tests

#### question

暂时没有解决一个项目中多库的问题

分析：zeus 是最初就将环境给加载好了, 就导致我们的环境变量ENV['TEST_ENV_NUMBER'] 为定值，从而导致我们parallel_tests多线程跑测试使用了同一个数据库

这块需要看一下parallel_tests中关于环境变量ENV['TEST_ENV_NUMBER']的实现才能做



## refer

http://railscasts.com/episodes/413-fast-tests

http://grease-your-suite.herokuapp.com/

http://stackoverflow.com/questions/3663075/speeding-up-rspec-tests-in-a-large-rails-application

## FAQ

### 将rspec的版本升级到最新版本 2.14.2遇见的问题

#### 1. controller中请求json数据

在controller中请求json数据，如果生成的数据结构是由jbuilder生成的json数据，需要
<pre>
describe xxx do
	render_views  # 将模板渲染出来
end
</pre>
才能获取到json数据

#### 2. stub问题

* stub! 已经被弃用，换用stub

<pre>
Model.stub!(:a).and_return(1)
=> should be
Model.stub(:a).and_return(1)
</pre>

* stub 使用double替代

<pre>
controller.stub(:current_user).and_return(stub(:user => 1))
=>
controller.stub(:current_user).and_return(double(:user => 1))
</pre>

* stub 参数

<pre>
  Model.stub(:a, 1) => stub(:a).with(1)
</pre>

#### 3. 严格性判断
<pre>
Model.stub!(:a).and_return()
=> should be 

Model.stub!(:a)
</pre>

### mysql 升级到5.6后测试无法跑通

分析：mysql5.6后对字段做了严格行校验，导致我们的数据无法写入，但是基本上都是由于我们测试写的不正确造成的



## 附件：性能对比

* normal

rspec spec  385.25s user 14.18s system 92% cpu 7:09.53 total

* delete unlawful spec 

rspec spec  363.88s user 13.93s system 93% cpu 6:45.14 total

* parallel_tests 4 process

rake 'parallel:spec'  625.48s user 29.18s system 238% cpu 4:34.13 total




