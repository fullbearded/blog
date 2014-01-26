# 诡异的SSH认证登陆

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

![]