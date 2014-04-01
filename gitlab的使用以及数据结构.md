# gitlab 的安装使用以及数据结构

## 简介
GitLab 是一个用于仓库管理系统的开源项目。使用Git作为代码管理工具，并在此基础上搭建起来的web服务。



## 安装

### 一键安装
gitlab installer

refer: http://bitnami.com/stack/gitlab/installer

### 手动安装


环境：
 
* CentOS6.5
* 基于 nignx + unicorn 搭建的应用环境， 如果想要换成passenger，可以参考网上的文档
* ruby环境是基于rbenv搭建的

#### 1: install vim

<code>yum install -y vim</code>

#### 2: install git > 1.7.10

* install git

<pre>
$ rpm -i 'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm'
$ rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt

$ vim /etc/yum.repos.d/rpmforge.repo  
# 将[rpmforge-extras] 下的enabled = 0 => enabled = 1

$ yum install -y git
$ git --version

git version 1.7.12.4

$ yum clean all
</pre>

reference: http://tecadmin.net/how-to-upgrade-git-version-1-7-10-on-centos-6/#

* git config

<pre>
git config --global user.name 'jerry'
git config --global user.email 'jerrery520@gmail.com'
git config --global color.branch 'auto'
git config --global color.diff 'auto'
git config --global color.interactive 'auto'
git config --global color.interactive 'auto'
git config --global core.editor '/usr/bin/vim'
</pre>

#### 3: install dependent rpm

* first: replace yum repo

<pre>
rpm -Uvh http://mirrors.sohu.com/fedora-epel/6/i386/epel-release-6-8.noarch.rpm
</pre>

* second: install

<pre>
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml libyaml-devel libffi libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel git-core libxml libxml-devel libxslt libxslt-devel wget pcre-devel openssl openssl-devel tcl tcl-devel libaio-devel ntpdate libicu-devel
</pre>

#### 4: install rbenv  && Ruby

* add users: git
<pre>
adduser --comment 'GitLab' --create-home --home-dir /home/git git
</pre>

* use rbenv-installer install rbenv

<pre>
cd /home/git/

sudo -u git sh -c "curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer > rbenv-installer"

su - git -c '/bin/bash rbenv-installer'

sudo -u git -H echo '
export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi
' >> /home/git/.bashrc

</pre>

* install Ruby

<pre>
su - git -c 'rbenv install 2.0.0-p353'
su - git -c 'rbenv global 2.0.0-p353'
</pre>

* install bundler
<pre>
su - git -c 'gem install bundler --no-ri --no-rdoc'
</pre>

#### 5: install gitlab

* install gitlab shell

<pre>
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-shell.git

cd gitlab-shell
sudo -u git -H cp config.yml.example config.yml
# 注：将下面的 your_git_domain替换成你的域名
sudo -u git -H sed -i 's/localhost/your_git_domain/g' config.yml
su - git -c '/home/git/gitlab-shell/bin/install'
</pre>

* install mysql, redis, nginx

refer: http://blog.58share.com/?p=291

* install gitlab

<pre>
cd /home/git
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-ce.git -b 6-6-stable gitlab

cd /home/git/gitlab

sudo -u git -H cp config/gitlab.yml.example config/gitlab.yml

# Make sure to change "localhost" to the fully-qualified domain name of your
# If you installed Git from source, change the git bin_path to /usr/local/bin/git
# 这里修改host(域名), email_from: (邮件)， support_email（邮件）
sudo -u git -H vim config/gitlab.yml

chown -R git log/
chown -R git tmp/
chmod -R u+rwX  log/
chmod -R u+rwX  tmp/
sudo -u git -H mkdir /home/git/gitlab-satellites
sudo -u git -H mkdir tmp/pids/
sudo -u git -H mkdir tmp/sockets/
chmod -R u+rwX  tmp/pids/
chmod -R u+rwX  tmp/sockets/
sudo -u git -H mkdir public/uploads
chmod -R u+rwX  public/uploads

sudo -u git -H cp config/unicorn.rb.example config/unicorn.rb

# Ex. change amount of workers to 3 for 2GB RAM server
sudo -u git -H vim config/unicorn.rb

sudo -u git -H cp config/initializers/rack_attack.rb.example config/initializers/rack_attack.rb

sudo -u git -H git config --global user.name "GitLab"
sudo -u git -H git config --global user.email "jerrery520@gmail.com"
sudo -u git -H git config --global core.autocrlf input

# mysql
sudo -u git cp config/database.yml.mysql config/database.yml

# 修改配置文件 config/database.yml

</pre>

* install gem

<pre>
su - git
cd /home/git/gitlab

# NOTES: RAM must be > 512M if your mysql on

bundle install --deployment --without development test postgres aws

# 确认数据库配置正确
# 创建数据库
bundle exec rake db:create RAILS_ENV=production

# 初始化gitlab数据 NOTES: need redis
bundle exec rake gitlab:setup RAILS_ENV=production
# 这里会执行清空数据库的操作，第一次请输入 yes

# install script

cp lib/support/init.d/gitlab /etc/init.d/gitlab

</pre>

* start server

<pre>
/etc/init.d/gitlab start
</pre>


* check env

<pre>
# 检测gitlab执行的环境
bundle exec rake gitlab:env:info RAILS_ENV=production

# 检测gitlab所依赖的东西
bundle exec rake gitlab:check RAILS_ENV=production

</pre>

* 编译静态文件配置nginx配置

<pre>
# 编译静态文件
bundle exec rake assets:precompile RAILS_ENV=production

#　配置nginx
# 注意： nginx的配置的用户为 git 

cp lib/support/nginx/gitlab /usr/local/nginx/conf/conf.d/gitlab.conf

</pre>

* 绑定host

<pre>
vim /etc/hosts

127.0.0.1 your_domain

</pre>

* 部署成功

<pre>
按照上面的部署：最终部署成功后： 访问域名

# that's all
# username: admin@local.host
# password: 5iveL!fe

# 第一次进入后，需要重设密码，设置成功后部署成功
</pre>

* 安装文档refer:

http://www.digitalsanctuary.com/tech-blog/general/installing-gitlab-on-redhat-enterprise-5-rhel-5.html

https://gitlab.com/gitlab-org/gitlab-ce/blob/6-6-stable/doc/install/installation.md

## 将gitolite迁移到gitlab步骤

#### 1. 初始化mysql 配置

<code>bundle exec rake gitlab:setup RAILS_ENV=production</code>

初始化后：即可以登陆超级管理员账户： 
<pre>
username: admin@local.host 
password: 5iveL!fe
</pre>

#### 2. 将现有的项目导入到gitlab中

<code>bundle exec rake gitlab:import:repos RAILS_ENV=production</code>

#### 3. 获取root的api密钥token 并写如客户端配置并执行api相关操作

*  创建用户并塞入对应的 ssh-key， 新创建的用户无创建分组的权限。
*  获取已经创建的 分组， 并根据分组，将用户写入不同的分组中
*  将admin 管理员加入所有的分组中, 手动将对应的用户设置为管理员，并允许创建分组
*  有邮箱的用户操作，涉及到线上数据库的更新，线上测试机器的拉取，手动创建虚拟用户并添加对应的权限
	<pre>
	线下机器是没有push权限的，设置为Reporter
	</pre>
* 合并人员需要设置为master 针对该项目
* 管理员账户，并修改他们对应的权限控制以及创建的项目数
	
#### 4. 写脚本将所有通过api创建的用户的确认状态修改为已确认状态，并在项目下执行操作
$ vim lib/task/gitlab/user.rake
<pre>
namespace :gitlab do
  desc "Update all users'confirmed is true"
  task :update_confirmed => :environment do.
     User.find_each do |user|
       user.confirmation_token = nil
       user.confirmed_at = Time.now
       user.save
     end
  end
end
</pre>
执行操作

<code>bundle exec rake gitlab:update_confirmed RAILS_ENV=production</code>


## 其他的相关配置 

* 配置smtp 邮件服务

<code>cd /home/git/gitlab</code>

$ vim config/environments/production.rb
<pre>
  config.action_mailer.delivery_method       = :smtp
  config.action_mailer.perform_deliveries    = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
    :address              => 'smtp.exmail.qq.com',
    :port                 => 465,
    :domain               => 'qq.com',
    :user_name            => 'your_email',
    :password             => 'password',
    :authentication       =>  :plain,
    :enable_starttls_auto => true
  }
</pre>

* 配置ldap 

<code>cd /home/git/gitlab</code>

$ vim config/gitlab.yml
<pre>
  ldap:
    enabled: true
    host: your_ldap_host
    base: 'ou=Accounts,dc=domain,dc=com'
    port: your_port
    uid: 'uid'
    method: 'plain' # "tls" or "ssl" or "plain"
    bind_dn: 'cn=binder,dc=domain,dc=com'
    password: 'your_password'
    allow_username_or_email_login: true  # 是否允许使用username或者email登陆，设置为false,登陆入口只会显示ldap入口
</pre>
 



## NOTES: 迁移项目遇到的坑

#### 1. 通过接口获取用户数据，默认只能获取20条， 可以分页，每页最多100条数据
#### 2. 通过接口获取项目，默认只能获取20条
#### 3. 如果是迁移项目，若以前的git项目是有多层级接口，需要修正为一层，比如 java/abc/aaa.git => java/abc_aaa.git, 因为gitlab是不支持多层级结构的
#### 4. 项目创建中有些带有关键字的项目是不能创建成功的，比如 java/admin.git , ruby/services.git
#### 5. gitlab clone项目无论是ssh, http 都会调用http请求，通过http请求判断用户的权限等操作。而我们的http请求是做了ldap访问权限设置的，因此需要对将本机（gitlab服务器）的IP加入ldap的白名单中


## 相关命令参考
* 将现有的项目导入到gitlab中去

<pre>bundle exec rake gitlab:import:repos RAILS_ENV=production</pre>

* 添加所有的用户到所有的分组中（admin的角色是owner）

<pre>bundle exec rake gitlab:import:all_users_to_all_groups RAILS_ENV=production</pre>

* 添加所有的用户到所有的项目中（admin的角色是master）

<pre>bundle exec rake gitlab:import:all_users_to_all_projects RAILS_ENV=production</pre>

* 添加一个特殊的用户到所有的分组中（角色为developer）

<pre>bundle exec rake gitlab:import:user_to_groups[email] RAILS_ENV=production</pre>

* 添加一个特殊的用户到所有的项目中（角色为developer）

<pre>bundle exec rake gitlab:import:user_to_projects[email] RAILS_ENV=production</pre>


## gitlab 其他相关参考

#### API相关

如果gitlab中有你的公钥，你就可以通过authentication_token来调用api

<pre>
curl --header "PRIVATE-TOKEN: ArTMXVSWjFEYn9DQrL7f" "http://git.tuan800-inc.com/api/v3/user/keys"
</pre>

#### gitlab api gem

refere: https://github.com/NARKOZ/gitlab

问题： 这个gem包的接口是v2的，但是gitlab 现在稳定版的是 V3了，但是部分功能能用，有些接口中描述的功能是需要自己去写的


## other helps

#### refer：http://mrk1869.com/blog/gitlab_installation/

#### git升级解决方案
How to Upgrade Git version >= 1.7.10 on CentOS 6

refer：http://tecadmin.net/how-to-upgrade-git-version-1-7-10-on-centos-6/#

#### git clone项目时报无环境变量

refer：http://thoughtpointers.net/2013/04/18/using-rbenv-with-gitlab-shell-on-os-x/

#### git push error

<pre>
test [master] % ggpush
Counting objects: 3, done.
Writing objects: 100% (3/3), 229 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: GitLab: An unexpected error occurred (redis-cli returned 127).
remote: error: hook declined to update refs/heads/master
To git@git.58share.com:huhongda/test.git
 ! [remote rejected] master -> master (hook declined)
error: failed to push some refs to 'git@git.58share.com:huhongda/test.git'
</pre>

解决：
修改 gitlab-shell/config/gitlab.yml 中的redis-cli 的路径为正确的路径

<pre>

#### 检测gitlab运行环境是否正确

bundle exec rake gitlab:check RAILS_ENV=production


#### errors

All migrations up? ... rake aborted!
Cannot allocate memory - git log --pretty=format:'%h' -n 1
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/core_ext/kernel/agnostics.rb:7:in ``'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/core_ext/kernel/agnostics.rb:7:in ``'
/home/git/gitlab/config/initializers/2_app.rb:3:in `<module:Gitlab>'
/home/git/gitlab/config/initializers/2_app.rb:1:in `<top (required)>'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/dependencies.rb:223:in `load'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/dependencies.rb:223:in `block in load'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/dependencies.rb:214:in `load_dependency'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/dependencies.rb:223:in `load'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/engine.rb:609:in `block (2 levels) in <class:Engine>'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/engine.rb:608:in `each'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/engine.rb:608:in `block in <class:Engine>'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/initializable.rb:30:in `instance_exec'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/initializable.rb:30:in `run'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/initializable.rb:55:in `block in run_initializers'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/initializable.rb:44:in `each'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/initializable.rb:44:in `tsort_each_child'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/initializable.rb:54:in `run_initializers'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/application.rb:215:in `initialize!'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/railtie/configurable.rb:30:in `method_missing'
/home/git/gitlab/config/environment.rb:5:in `<top (required)>'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/dependencies.rb:229:in `require'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/dependencies.rb:229:in `block in require'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/dependencies.rb:214:in `load_dependency'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/activesupport-4.0.3/lib/active_support/dependencies.rb:229:in `require'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/application.rb:189:in `require_environment!'
/home/git/gitlab/vendor/bundle/ruby/2.0.0/gems/railties-4.0.3/lib/rails/application.rb:250:in `block in run_tasks_blocks'
Tasks: TOP => db:migrate:status => environment
(See full trace by running task with --trace)
</pre>

解决： 是由于缺少内存导致的，如果用的是vps的话，用free -m 看看是否是内存太少，或者是没有使用swap内存，如果没有swap，需要加swap，一般是内存的1倍或者1.5倍

<pre>
# 加swap

mkdir -p /data/swapdir
cd /data/swapdir

dd if=/dev/zero of=swapfile bs=1024  count=1024000

mkswap /data/swapdir/swapfile

swapon swapfile  # 开启swap

swapoff swapfile # 关闭swap

# 可以使用free -m 查看内存情况

# 加入开启重启

echo '/data/swapdir/swapfile  swap  swap defaults 0 0' >> /etc/fstab

</pre>


## Reference

http://mrk1869.com/blog/gitlab_installation/

http://www.digitalsanctuary.com/tech-blog/general/installing-gitlab-on-redhat-enterprise-5-rhel-5.html

https://gitlab.com/gitlab-org/gitlab-ce/blob/6-6-stable/doc/install/installation.md

https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/README.md

# project for gitlab api
https://github.com/NARKOZ/gitlab

https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/groups.md





