# CentOS6.2 min系统网卡配置

## 背景

由于测试需要需要装CentOS6.2版本的linux系统，但是装好系统后发现网卡没有启动(虚拟机)。于是导致的一系列问题

## 挣扎之路

#### 网卡没有启动？

解决：
<code>vim /etc/sysconfig/network-scripts/ifcfg-eth0 </code>
<pre>
DEVICE="eth0"
HWADDR="08:00:27:46:67:E6"
NM_CONTROLLED="yes"
ONBOOT="yes"     # 开机启动
BOOTPROTO='dhcp' # 设置为dhcp，自动获取网络
</pre>

重启网卡: <code>service network restart</code>

#### 实现内外网互访, 发现缺少网卡？

使用如下配置进行网卡配置以实现内外网互访 [mac下virtualbox实现内外网互访](https://github.com/huhongda/blog/blob/master/mac%E4%B8%8Bvirtualbox%E5%AE%9E%E7%8E%B0%E5%86%85%E5%A4%96%E7%BD%91%E4%BA%92%E8%AE%BF.md), 但是<code>ifconfig</code>只发现一个网卡

<pre>
$ ifconfig

eth0      Link encap:Ethernet  HWaddr 08:00:27:46:67:E6
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fe46:67e6/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:54 errors:0 dropped:0 overruns:0 frame:0
          TX packets:70 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:21150 (20.6 KiB)  TX bytes:8692 (8.4 KiB)
          
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:16 errors:0 dropped:0 overruns:0 frame:0
          TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:988 (988.0 b)  TX bytes:988 (988.0 b)

</pre>

解决：手动添加网卡 

<pre>
ifconfig eth1 192.168.1.123 netmask 255.255.255.0
ifconfig eth1 192.168.56.123 netmask 255.255.255.0
</pre>

添加DNS解析

vim /etc/resolv.conf
<pre>
nameserver 8.8.8.8
</pre>

-----

解决：

查找后发现原来是路由表没有定义导致 (未成功)

##### 临时添加路由表

* 使用route命令添加

<pre>
//添加到主機的路由
# route add –host 192.168.1.11 dev eth0
# route add –host 192.168.1.12 gw 192.168.1.1
//添加到網络的路由
# route add –net 192.168.1.11 netmask 255.255.255.0 dev eth0
# route add –net 192.168.1.11 netmask 255.255.255.0 gw 192.168.1.1
# route add –net 192.168.1.0/24 dev eth1
//添加默認網關
# route add default gw 192.168.2.1
//刪除路由
# route del –host 192.168.1.11 dev eth0
</pre>

* 使用ip命令添加

<pre>
ip route add default via 172.16.10.2 dev eth0
ip route add 172.16.1.0/24 via 172.16.10.2 dev eth0

格式如下：
ip route default via gateway dev interface
ip/netmask via  gateway dev interface
</pre>


##### 永久添加路由表

* 在/etc/rc.local中添加

<pre>
route add -net 192.168.3.0/24 dev eth0
route add -net 192.168.2.0/24 gw 192.168.2.254
</pre>

* 在/etc/sysconfig/network添加到末尾

<pre>
GATEWAY=gw-ip || GATEWAY=gw-dev
</pre>

* /etc/sysconfig/static-routes  (未验证)
<pre>
any net 192.168.3.0/24 gw 192.168.3.254
any net 10.250.228.128 netmask 255.255.255.192 gw 10.250.228.129
</pre>

* 在/etc/sysconfig/network-script/route-interface下添加路由 （为验证）



#### Reference

http://conkeyn.iteye.com/blog/1967072



