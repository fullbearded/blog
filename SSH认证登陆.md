# 诡异的SSH认证登陆

## 解码学* 对称加密 des
Eg:同样的东西,密码两个人都知道,不安全 2)非对称加密* rsaEg;一把钥匙(私钥)配多把锁(公钥 ),只有拿了钥匙的人能打开 3)单向不可逆加密* md5口令登录:我拿了服务器的公钥,我加密一段数据到服务器 服务器要考虑你的公钥是否可信 ,用户名,密码密钥登录:你把你的锁给了服务器 ,服务器加密了一段随即数据给了你 ,如果服务器看见你 拿你的钥匙解开了,则你是可信的。分歧点:两者的区别不是发生 c 去访问 s 的时候,而是发生在 s 验证 c 是否是可信的。 情形一:我拿了服务器的公钥,我去登录服务器,服务器检测我是否可信 ,(口令登录) 情形二:我也有一把钥匙一把锁 ,我把锁给了服务器 ,我登录服务器的时候 ,服务器不弹出 输入用户名或密码 ,服务器自己用你的锁加密一段随即数据 ,拷贝到你的计算机中来 ,如果 你的钥匙能匹配上,则你是可信的(密钥登录)

## 概念

ssh 协议提供两种用户认证方式

* 口令登陆
	与telnet类似，提供正确的用户口令后可以登陆远程服务器
	
<code>
ssh username@192.168.100.1
</code>

查看口令的钥匙情况：

(1) <code>cd ~/.ssh/ </code>

(2) <code> cat know_hosts </code>

![ssh_1](https://github.com/huhongda/blog/blob/master/images/ssh_1.png?raw=true)

* 密钥登陆

使用公钥和私钥对的方式对用户进行认证
![ssh_2](https://github.com/huhongda/blog/blob/master/images/ssh_2.png?raw=true)

## 使用

#### 客户端
<pre>
# （1） 在客户端形成一个钥锁对
$ ssh-keygen -t rsa #（全部回车）

# （2） 进入<code>.ssh/</code>目录查看生成的文件
$ cd .ssh
$ ls

id_rsa id_rsa.pub known_hosts 

# 注：没有生成钥匙对之前只有一个文件，known_hosts, id_rsa.pub为公钥， id_rsa为私钥

# （3）使用samba或者其他的软件将公钥 id_rsa.pub移到服务器
$ scp id_rsa.pub username@192.168.100.1:/home/username

# 要提示你输入密码
</pre>

#### 服务器端

<pre>
$  cd ~/
$  mkdir ~/.ssh
mv id_rsa.pub ~/.ssh/authorized_keys
</pre>

## 注意事项
(1)服务器权限

$HOME 权限只能自己可写 (0755 或者 0750) <code>.ssh</code>设置成 0700， <code>authorized_keys</code> 和<code>id_rsa.pub</code> 0644, <code>id_rsa</code> 0600

(2)sshd配置

vim /etc/ssh/sshd_config
<pre>

StrictModes no  
######## StrictModes no #修改为no,默认为yes.如果不修改用key登陆是出现server refused our key(如果StrictModes为yes必需保证存放公钥的文件夹的拥有与登陆用户名是相同的.“StrictModes”设置ssh在接收登录请求之前是否检查用户家目录和rhosts文件的权限和所有权。这通常是必要的，因为新手经常会把自己的目录和文件设成任何人都有写权限。)

PubkeyAuthentication no -> yes
</pre>

重启ssh
<code>service sshd restart</code>

(3) 关闭SELinux 

问题：检测上面所有的配置都为正确
<pre>
Permission denied (publickey,gssapi-keyex,gssapi-with-mic).  
</pre>

解决：关闭SELinux

暂时关闭(重启后恢复)
<pre>
setenforce 0  
</pre>

永久关闭(需要重启)
<pre>
vi /etc/selinux/config  
SELINUX=disabled  
</pre>

参考：http://serverfault.com/questions/230771/ssh-configuration-publickeys-permission-denied-publickey-password-error
 


