# mac下virtualbox实现内外网互访



## virtualbox虚拟网络的设置的四种形式

[virtualbox网络设置四种形式](http://www.douban.com/group/topic/15558388/)

## 实现环境

宿主机(mac) + 虚拟机(Centos)

## 实现方式:  host-only + bridged

#### virtualbox 设置 host-only

1. add adapter for host-only  

进入 virtualbox - Preferences 设置

![virtbox-1.png](https://raw.githubusercontent.com/huhongda/blog/master/images/virtualbox-1.png)

如果host-only networks中没有adapter, 需要添加一个

2. set network

![virtualbox-2.png](https://raw.githubusercontent.com/huhongda/blog/master/images/virtualbox-2.png)

![virtualbox-3.png](https://raw.githubusercontent.com/huhongda/blog/master/images/virtualbox-3.png)


自此启动虚拟机即可实现宿主机互ping，虚拟机能访问互联网

#### 虚拟机与主机共享文件夹

![virtualbox-3.png](https://raw.githubusercontent.com/huhongda/blog/master/images/virtualbox-4.png)





