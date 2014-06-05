# gitolite搭建git服务器

## 客户端

1. 生成密钥对

<pre>
	$ ssh-keygen -t rsa  # 生成一对公密钥对
 	id_rsa id_rsa.pub
</pre>
2. 上传公钥

<pre>
scp id_rsa.pub yourserver@ip:/tmp
</pre>

## Server端

1. 切换到git用户
<pre>
useradd git
su - git
</pre>

2. 安装gitolite

<pre>

  $ git clone git://github.com/sitaramc/gitolite

  $ mkdir -p $HOME/bin

  $ gitolite/install -ln
  
  $ mv /tmp/id_rsa.pub admin.pub

  $ $HOME/bin/gitolite setup -pk admin.pub # 根据公钥形成管理员

</pre>


## 客户端
进入 ~/.ssh/ 目录中

创建文件
<pre>
$ touch config

host git 
  user git 
  hostname YourHost name
  port  PORT
  identityfile ~/.ssh/id_rsa   # 注，这个是私钥，要形成对才的行
</pre>
然后就可以用域名的形式

git clone git:gitolite-admin  将管理员配置地址clone下来

## 通过gitolite-admin管理git仓库

<pre>
$ cd ~/gitolite-admin/
$ ls
conf/  keydir/
$ find conf keydir -type f
conf/gitolite.conf
keydir/scott.pub
$ cat conf/gitolite.conf

repo gitolite-admin
    RW+                 = scott

repo testing
    RW+                 = @all
</pre>


## Rerference

http://git-scm.com/book/zh/%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E7%9A%84-Git-Gitolite


