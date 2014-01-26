# ruby环境搭建，相关工具的配置使用

## 相关工具
* git* vim* nginx* mongodb* redis* memcached* mysql* rvm || rbenv* ruby* 系统库（Centos: yum, mac: brew, ubuntu: apt-get）本文档主要是：Centos环境的搭建 
* varnish

## 开发环境搭建前置条件

#### 网络配置

1. 安装CentOS 6.2 64bit 最小化系统

2. 配置网卡

vim /etc/sysconfig/network-scripts/ifcfg-eth0
<pre>
EVICE="eth0"
BOOTPROTO="dhcp"
HWADDR="08:00:27:86:A1:4A"
NM_CONTROLLED="yes"
ONBOOT="yes"
</pre>

重启网卡: service network restart

注：是否需要配置成静态ip， 相关配置：

<pre>
EVICE="eth0"
BOOTPROTO="static"
IPADDR="192.168.10.1" # ip地址
NETMASK="255.255.255.0" # 子网掩码
GATWAY="192.168.10.1"  #　网关
HWADDR="08:00:27:86:A1:4A"
NM_CONTROLLED="yes"
ONBOOT="yes"
</pre>

#### 更换yum源
<pre>
rpm -Uvh http://mirrors.sohu.com/fedora-epel/6/i386/epel-release-6-8.noarch.rpm 
</pre>

#### 安装基础软件包

<pre>
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel 
yum install -y openssl-devel make bzip2 autoconf automake libtool bison iconv-devel git-core ImageMagick 
yum install -y libxml libxml-devel libxslt libxslt-devel wget
yum install -y pcre-devel openssl openssl-devel 
yum install -y tcl
yum install -y libaio-devel
yum install -y ntpdate
</pre>


#### 同步时间
<pre>
/usr/sbin/ntpdate 0.centos.pool.ntp.org;/sbin/hwclock -w

crontab -e
* */12 * * * /usr/sbin/ntpdate 0.centos.pool.ntp.org;/sbin/hwclock -w
</pre>


## 1. vim

#### 简介

作为编辑神器：vim我就不用多介绍了，基本上初始化安装CentOS都会带vi 
vim的很多插件,但是管理不是很方便，这里我使用的是Vundle进行插件的管理。

具体可参考：http://blog.58share.com/?p=203

vim配置文件：https://github.com/huhongda/scripts/blob/master/vimrc
#### CentOS安装
<pre>
yum install -y vim
</pre>

## 2. git

#### git 版本控制器 CentOS安装 
<pre>
yum install -y git
</pre>


#### git 配置

<pre>
git config --global user.name "jerry"
#　或者　vim ~/.gitconfig

[user]
  name  =  jerry
  email =  your_email
[color] #配置git为色彩
  branch      = auto
  diff        = auto
  interactive = auto
  status      = auto
[core]
  editor = /usr/bin/vim
</pre>

#### git基本使用： 
<pre>
git clone https://github.com/huhongda/scripts.git  
git add .  || git add direct_file
git commit -m 'you commit'
git push origin your_branch  # 提交你的分支到远程分支
git push origin :your_branch # 删除你的远程分支
git push origin master -f 强行提交本地分支到远程

git pull origin your_branch
git checkout your_first_branch
git merge your_branch  

git remote update -p # 更新远程分支
git remote -v  # 查看git库地址
git remote add origin https://github.com/huhongda/scripts.git # 添加git库提交地址
git remote rm origin  # 删除git库提交地址

git log # 查看git提交
git log --graph 
git log -p app/xxxx.rb 查看历史版本记录（包括代码）

git diff commitA commitB # 查看版本之间的不同
git blame file # 查看文件的修改情况
git clean -df 删除untrack的文件

git stash 将修改文件存入缓存中
git stash pop 从缓存中释放出修改文件

git branch -a # 显示所有的分支（包括远程分支）
git branch -d your_branch # 删除本地分支

git status # 查看分支状态

git checkout -b new_branch # 根据当前分支创建一个新的分支
</pre>

#### 安装git-flow 

简介：http://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html
<pre>
wget https://raw.github.com/huhongda/scripts/master/gitflow-installer.sh
/bin/bash gitflow-installer.sh
  # 执行完成之后

git flow init 
 # 按照提示配置，不输入按照默认的配置
</pre>


#### git flow 基本使用
<pre>
## for developer
git checkout develop
git pull origin develop
git flow feature start new_branch

..develop..

git add .
git commit -m 'modify your branch'
git push origin new_branch

## base current branch 
git checkout old_branch
git pull origin  old_branch
git checkout -b new_branch
..

## for other
git flow feature publish new_branch
git remote update -p
git flow feature track new_branch

## for production
git flow feature track new_branch
git flow feature finish new_branch
git push origin :new_branch


### for release
git flow release start Version_1.02 
git flow release publish Version_1.02

# 追踪release分支
git flow release track Version_1.02 

# 完成release
#更新master (release finish完会自动切换到master分支)
git flow release finish -F -p Version_1.02 
 
git push origin master

# hotfix流程
git remote update -p
git checkout master
git pull origin master
git checkout develop
git pull origin develop

git flow hotfix start xxoo
改啊改
git add ..............
git commit -m "xxoo" 
git remote update -p
git flow hotfix finish xxoo

git remote update -p
git checkout master
git pull origin master
git push origin master
git checkout develop
git pull origin develop
git push origin develop

</pre>

## nginx

#### 安装
<pre>
cd /tmp
wget -c http://nginx.org/download/nginx-1.4.4.tar.gz
tar -zxf nginx-1.4.4.tar.gz
cd nginx-1.4.4

./configure --user=www --group=www --prefix=/usr/local/nginx \
 --with-http_ssl_module --with-http_realip_module --with-http_addition_module \ 
 --with-http_sub_module --with-http_gzip_static_module --with-http_realip_module \
 --with-http_gunzip_module --with-http_stub_status_module --with-pcre \
 --with-ipv6 --with-mail --with-mail_ssl_module --with-http_random_index_module  

make 
make test
make install

</pre>

#### 配置
* 创建www用户，用户组以及Nginx日志目录

<pre>
/usr/sbin/groupadd www
/usr/sbin/useradd -g www www

mkdir -p /data/pids/nginx/
mkdir -p /data/logs/nginx/
chmod +w /data/logs/nginx/
chmod +w /data/pids/nginx/
chown -R www:www /data/logs/nginx/
chown -R www:www /data/pids/nginx/
</pre>

* 创建Nginx配置文件

参考：https://github.com/huhongda/scripts/blob/master/nginx.conf

<pre>
wget https://raw.github.com/huhongda/scripts/master/nginx.conf
</pre>

* 启动nginx
<pre>
ulimit -SHn 65535
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
</pre>

* 配置开机启动nginx
vim /etc/rc.local
<pre>
ulimit -SHn 65535
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
</pre>

#### nginx常用命令

<pre>
/usr/local/nginx/sbin/nginx -t  # 检测配置文件是否正确
/usr/local/nginx/sbin/nginx -s reload # 平滑重启Nginx
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf # 启动nginx
</pre>

更多请参考：http://blog.58share.com/?p=158#more-158 以及nginx官网文档

## memcached

#### 安装
<pre>
wget https://memcached.googlecode.com/files/memcached-1.4.15.tar.gz
#memcached依赖包
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz

tar -zxf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure
make && make install

ln -sv /usr/local/lib/libevent-2.0.so.5 /usr/lib/
ln -sv /usr/local/lib/libevent-2.0.so.5 /usr/lib64/

cd ../
tar -zxf memcached-1.4.15.tar.gz
cd memcached-1.4.15/
./configure --prefix=/usr/local/memcached --with-libevent=/usr
make && make install
 
ln -sv /usr/local/memcached/bin/memcached /usr/bin/
source ~/.bashrc
/usr/sbin/useradd -g memcached memcached

# 启动
memcached -d -p 11211 -u memcached -m 64 -c 1024 -P /var/run/memcached/memcached.pid


#加入启动项
vim /etc/rc.local
memcached -d -p 11211 -u memcached -m 64 -c 1024 -P /var/run/memcached/memcached.pid
</pre>

#### 使用

rails,php版本客户端使用
参考：http://blog.58share.com/?p=176

## mysql

#### 安装

下载系统对应的版本：
<pre>
#查看系统位数（32位或者64位）
uname -m | sed -e 's/i.86/32/'

# 64bit 版本
wget -c http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.15-linux-glibc2.5-x86_64.tar.gz

# 32bit 版本
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.15-linux-glibc2.5-i686.tar.gz
</pre>

安装：
<pre>
groupadd mysql
useradd -r -g mysql mysql    
tar -zxf mysql-5.6.15-linux-glibc2.5-x86_64.tar.gz
mv mysql-5.6.15-linux-glibc2.5-x86_64 /usr/local/mysql
cd /usr/local
chown -R mysql:mysql mysql
</pre>

添加PATH路径：
<pre>
vim /etc/profile

# 添加下面文件
MYSQL_HOME=/usr/local/mysql
PATH=$PATH:$MYSQL_HOME/bin

source /etc/profile
</pre>

创建数据库存储目录：
<pre>
mkdir -p /data/data/mysql
mkdir -p /data/logs/mysql
chown -R mysql:mysql /data/data/mysql
chown -R mysql:mysql /data/logs/mysql
chmod -R go-rwx /data/data/mysql
chmod -R go-rwx /data/logs/mysql
</pre>

配置数据信息：
<pre>
scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/data/data/mysql/ --explicit_defaults_for_timestamp

cp support-files/mysql.server /etc/init.d/mysql #将mysql启动文件拷贝到启动项

/usr/local/mysql/bin/mysqladmin -u root password 'new-password' # 设置root密码

# 编辑启动文件
vim /etc/init.d/mysql

basedir=/usr/local/mysql
datadir=/data/data/mysql

</pre>

创建mysql配置文件：
<pre>
cp support-files/my-default.cnf /etc/my.cnf
</pre>

修改配置文件:

vim /etc/my.cnf

<pre>

[client]
port = 3306
socket = /tmp/mysql.sock
[mysqld]
port = 3306
socket = /tmp/mysql.sock
datadir   = /data/data/mysql
pid-file  = /data/data/mysql/mysql.pid
log-error = /data/logs/mysql/error.log
long_query_time  = 0.5          #慢查询超时时间
slow_query_log   = 1
slow_query_log_file = /data/logs/mysql/slowquery.log  #打开慢查询日志功能
min_examined_row_limit = 10000

skip-external-locking
key_buffer_size = 384M
max_allowed_packet = 1M
table_open_cache = 512
sort_buffer_size = 2M
read_buffer_size = 2M
read_rnd_buffer_size = 8M
myisam_sort_buffer_size = 64M
thread_cache_size = 8
query_cache_size = 32M
thread_concurrency = 8
log-bin=mysql-bin

server-id = 1

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 256M
sort_buffer_size = 256M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout
</pre>

参考：http://blog.58share.com/?p=141

<pre>
# 加入启动项
vim /etc/rc.local

/etc/init.d/mysql start
</pre>

## MongoDB

安装以及基本使用参考：http://blog.58share.com/?p=192

## Redis

#### 安装
参考：http://redis.io/download
<pre>
wget -c http://download.redis.io/releases/redis-2.8.4.tar.gz
tar xzf redis-2.8.4.tar.gz
cd redis-2.8.4
make 	

cp redis-server /usr/local/bin/
cp redis-cli /usr/local/bin/

mkdir /var/redis
mkdir /etc/redis
mkdir /var/redis/6379

cp utils/redis_init_script /etc/init.d/redis
cp redis.conf /etc/redis/6379.conf
</pre>

配置参考：http://redis.io/topics/quickstart

#### 启动

<pre>
/etc/init.d/redis start

# 开机启动
vim /etc/rc.local

/etc/init.d/redis start
</pre>

## rbenv

####  简介
一般我们通过rbenv或者rvm来管理ruby的多个版本

rvm 的安装使用参考： http://ruby-china.org/wiki/rvm-guide

一般我们使用rbenv来管理ruby版本

具体参考：http://ruby-china.org/wiki/rbenv-guide

#### 安装
<pre>
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
# 用来编译安装 ruby
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# 用来管理 gemset, 可选, 因为有 bundler 也没什么必要
git clone git://github.com/jamis/rbenv-gemset.git  ~/.rbenv/plugins/rbenv-gemset
# 通过 gem 命令安装完 gem 后无需手动输入 rbenv rehash 命令, 推荐
git clone git://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
# 通过 rbenv update 命令来更新 rbenv 以及所有插件, 推荐
git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
</pre>

然后把下面的代码放到 <code>~/.bash_profile</code> 里

<pre>
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
</pre>

执行： source ~/.bash_profile


#### 使用

<pre>
rbenv install --list  # 列出所有 ruby 版本
rbenv install 1.9.3-p392     # 安装 1.9.3-p392
rbenv versions               # 列出安装的版本
rbenv version                # 列出正在使用的版本
rbenv global 1.9.3-p392      # 默认使用 1.9.3-p392
rbenv shell 1.9.3-p392       # 当前的 shell 使用 1.9.3-p392, 会设置一个 `RBENV_VERSION` 环境变量
benv local jruby-1.7.3      # 当前目录使用 jruby-1.7.3, 会生成一个 `.rbenv-version` 文件

rbenv rehash                 # 每当切换 ruby 版本和执行 bundle install 之后必须执行这个命令
rbenv which irb              # 列出 irb 这个命令的完整路径
rbenv whence irb             # 列出包含 irb 这个命令的版本
</pre>

