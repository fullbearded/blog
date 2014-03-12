# gitlab 的安装使用以及数据结构

## 安装
参考：
http://www.digitalsanctuary.com/tech-blog/general/installing-gitlab-on-redhat-enterprise-5-rhel-5.html
# https://gitlab.com/gitlab-org/gitlab-ce/blob/6-6-stable/doc/install/installation.md

## 数据结构

#### keys 表
<pre>
user_id  	 integer 用户id
key      	 text    用户的公钥
title    	 varchar 公钥的标题
type     	 varchar 
fingerprint  varchar 
</pre>

插入语句：
<pre>
INSERT INTO `keys` (`created_at`, `fingerprint`, `key`, `title`, `updated_at`, `user_id`) VALUES ('2014-03-10 14:48:41', 'ff:35:ab:4c:cd:7c:85:e7:53:cf:04:e0:d7:25:b1:55', 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCtHP9kKxgPYtP+Sa4uXjg6Qfwg2ulLQwkliCkM3ZET1CWvSY84QBE618fD7SUvImCuidPiEQ/f+kERjXF7NYAHi4j+7c16VM+9NTBw45jYUwDpROq6hrOhqtLTWGOz6vN4XZ7fDcW3fq1xUe7uWYwfgO/ii/9V3vhMCR1wkDsM++1oG2AnXPS+051364sckcfHDXeKPdKXgi/00SHymv7O14h5ZtA0kOGGeELSu0XAaORQPeLUWD5DTcaKuWbBpslbs4NgltLxr2sM+4J/ONFC+xvXMMSGMl3qVkqW/aM5akp99aSS8xLTOM78xk9321f2ubJGNe3nEv3rXHsIC9 huhongda@jerry', 'huhongda-mac-company', '2014-03-10 14:48:41', 3)
</pre>


## API相关

如果gitlab中有你的公钥，你就可以通过authentication_token来调用api

<pre>
curl --header "PRIVATE-TOKEN: ArTMXVSWjFEYn9DQrL7f" "http://gitlab.tuan800.com/api/v3/user/keys"
</pre>




## Help

#### git升级解决方案
How to Upgrade Git version >= 1.7.10 on CentOS 6

参考：http://tecadmin.net/how-to-upgrade-git-version-1-7-10-on-centos-6/#

#### git clone项目时报无环境变量

参考：http://thoughtpointers.net/2013/04/18/using-rbenv-with-gitlab-shell-on-os-x/

#### bundle install 遇见问题

<pre>
[git@localhost gitlab]$ gem install charlock_holmes -v '0.6.9.4'
Fetching: charlock_holmes-0.6.9.4.gem (100%)
Building native extensions.  This could take a while...
ERROR:  Error installing charlock_holmes:
	ERROR: Failed to build gem native extension.

    /home/git/.rbenv/versions/2.1.0/bin/ruby extconf.rb
checking for main() in -licui18n... no
which: no brew in (/home/git/.rbenv/versions/2.1.0/bin:/home/git/.rbenv/libexec:/home/git/.rbenv/plugins/rbenv-bootstrap/bin:/home/git/.rbenv/plugins/rbenv-installer/bin:/home/git/.rbenv/plugins/rbenv-update/bin:/home/git/.rbenv/plugins/rbenv-use/bin:/home/git/.rbenv/plugins/rbenv-vars/bin:/home/git/.rbenv/plugins/rbenv-whatis/bin:/home/git/.rbenv/plugins/ruby-build/bin:/home/git/.rbenv/shims:/home/git/.rbenv/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/mysql55/bin:/home/git/bin)
checking for main() in -licui18n... no


***************************************************************************************
*********** icu required (brew install icu4c or apt-get install libicu-dev) ***********
***************************************************************************************
*** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of necessary
libraries and/or headers.  Check the mkmf.log file for more details.  You may
need configuration options.

Provided configuration options:
	--with-opt-dir
	--without-opt-dir
	--with-opt-include
	--without-opt-include=${opt-dir}/include
	--with-opt-lib
	--without-opt-lib=${opt-dir}/lib
	--with-make-prog
	--without-make-prog
	--srcdir=.
	--curdir
	--ruby=/home/git/.rbenv/versions/2.1.0/bin/ruby
	--with-icu-dir
	--without-icu-dir
	--with-icu-include
	--without-icu-include=${icu-dir}/include
	--with-icu-lib
	--without-icu-lib=${icu-dir}/lib
	--with-icui18nlib
	--without-icui18nlib
	--with-icui18nlib
	--without-icui18nlib

extconf failed, exit code 1

Gem files will remain installed in /home/git/.rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/charlock_holmes-0.6.9.4 for inspection.
Results logged to /home/git/.rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/extensions/x86_64-linux/2.1.0-static/charlock_holmes-0.6.9.4/gem_make.out
</pre>

解决：<code>yum -y install libicu-devel</code>

<pre>
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

    /home/git/.rbenv/versions/2.1.0/bin/ruby extconf.rb
checking for pg_config... no
No pg_config... trying anyway. If building fails, please try again with
 --with-pg-config=/path/to/pg_config
checking for libpq-fe.h... no
Can't find the 'libpq-fe.h header
*** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of necessary
libraries and/or headers.  Check the mkmf.log file for more details.  You may
need configuration options.

Provided configuration options:
	--with-opt-dir
	--without-opt-dir
	--with-opt-include
	--without-opt-include=${opt-dir}/include
	--with-opt-lib
	--without-opt-lib=${opt-dir}/lib
	--with-make-prog
	--without-make-prog
	--srcdir=.
	--curdir
	--ruby=/home/git/.rbenv/versions/2.1.0/bin/ruby
	--with-pg
	--without-pg
	--with-pg-dir
	--without-pg-dir
	--with-pg-include
	--without-pg-include=${pg-dir}/include
	--with-pg-lib
	--without-pg-lib=${pg-dir}/lib
	--with-pg-config
	--without-pg-config
	--with-pg_config
	--without-pg_config

extconf failed, exit code 1

Gem files will remain installed in /home/git/gitlab/vendor/bundle/ruby/2.1.0/gems/pg-0.15.1 for inspection.
Results logged to /home/git/gitlab/vendor/bundle/ruby/2.1.0/extensions/x86_64-linux/2.1.0-static/pg-0.15.1/gem_make.out
An error occurred while installing pg (0.15.1), and Bundler cannot continue.
Make sure that `gem install pg -v '0.15.1'` succeeds before bundling.
</pre>

解决: <code>yum install postgresql-devel</code>