# centos搭建selenium自动化测试
### selenium简介
google一下你就知道

### 安装selenium

1. 安装java环境
<pre>
yum -y install java-1.7.0-openjdk
</pre>

2. 下载selenium安装包
<pre>

mkdir -p /etc/selenium/logs

cd /etc/selenium

wget http://selenium.googlecode.com/files/selenium-server-standalone-2.37.0.jar


</pre>

下载地址：http://code.google.com/p/selenium/downloads/list

3. 下载启动脚本并加入启动项并启动selenium服务
<pre>
cd /etc/init.d/

wget https://raw.github.com/huhongda/blog/master/code/selenium/selenium

 # 注意脚本中的selenium版本信息

chmod o+x /etc/init.d/selenium

chkconfig selenium on

</pre>

4. 启动selenium

<pre>
service selenium start
</pre>

5. 测试
使用浏览器访问 http://localhost:4444 

到这里安装就结束了

### 使用selenium操作firefox

1. 安装firefox，注不要使用centos自带的firefox，需要安装
<pre>
yum -y install firefox
</pre>

2. 启动firefox脚本端口

<pre>
 # 查看firefox的版本呢
/usr/bin/firefox --version

 #执行
java -jar /etc/selenium/selenium-server-standalone-2.37.0.jar -role node -hub http://localhost:4444/grid/register -browser browserName=firefox,firefox_binary=/usr/bin/firefox,version=17.0.10 platform=LINUX -port 5553 -registerCycle=60000 &

</pre>

3. 测试

使用浏览器访问http://{grid_hub_server_address}:4444/grid/console 就可以看见firefox已经配置了


### 简单的ruby测试脚本

<pre>
require 'rubygems'
require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
driver.get "http://www.baidu.com"
sleep 3

driver.find_element(:id, 'kw').send_keys "58分享"
driver.find_element(:id, 'su').click
 
 # 截屏保存
driver.save_screenshot "/tmp/baidu.png"
puts driver.title

driver.quit
</pre>


## 参考脚本

<pre>
java -jar /etc/selenium/selenium-server-standalone-2.37.0.jar -role hub -DPOOL_SIZE 512 &

java -jar /etc/selenium/selenium-server-standalone-2.37.0.jar -role node -hub http://localhost:4444/grid/register -browser browserName=firefox,firefox_binary=/usr/bin/firefox,version=17.0.10 platform=LINUX  -port 5553 -registerCycle=60000 &
</pre>

## 相关链接

http://ptylr.com/2013/01/26/configuring-running-the-selenium-grid-from-centos/
http://code.google.com/p/selenium/downloads/list
http://docs.seleniumhq.org/docs/03_webdriver.jsp  官方网站