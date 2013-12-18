# CentOS搭建VNC远程可视化

## VNC简介
VNC（Virtual Network Computing）基本上是属于一种显示系统,也就是说它能将完整的窗口界面通过网络,传输到另一台计算机的屏幕上

## VNC安装

1.检查linux系统是否安装VNC
rpm -q vnc-server

2、运行以下命令进行安装：
yum install vnc vnc-server

3、启动VNC服务
vncserver

会提示输入密码

4、修改配置文件
su 到root用户

vi /etc/sysconfig/vncservers

VNCSERVERS="10000:root" # 把前面的#取消了 10000:root （桌面号:用户）

5、配置防火墙，允许10000+5900=15900端口通过防火墙（否则远程连不上VNC服务器）
vi /etc/sysconfig/iptables
-A INPUT -m state --state NEW -m tcp -p tcp --dport 15900 -j ACCEPT（允许15900端口通过防火墙）
6、重启vnc服务器
 /etc/init.d/vncserver restart

7、重启防火墙，使刚才的端口配置生效
/etc/init.d/iptables restart
service iptables restart

8、 设置vnc服务器开机自动启动
第一种方法：使用“ntsysv”命令启动图形化服务配置程序，在vncserver服务前加上星号，点击确定，配置完成。
第二种方法：使用“chkconfig”在命令行模式下进行操作，命令使用如下
chkconfig vncserver on
chkconfig --list vncserver
vncserver       0:off   1:off   2:on    3:on    4:on    5:on    6:off

9、更改vnc连接密码
vncpasswd

到此，VNC服务端设置完成，用VNC客户端可以连接了
vnc服务器：你的ip:15900


## FAQ
重启时报错：

/usr/bin/Xvnc: symbol lookup error: /usr/bin/Xvnc: undefined symbol: 
pixman_composite_trapezoids
/usr/bin/Xvnc: symbol lookup error: /usr/bin/Xvnc: undefined symbol: 
pixman_composite_trapezoids


这是因为版本原因导致字体问题，需要安装、更新X11的包，或者看提示pixman安装此包。
命令如下：yum install pixman pixman-devel libXfont －y


## 使用mac链接vnc

下载 realvnc 

下载地址：http://dl.vmall.com/c0pukryio0


密钥：

WHJRK-UXY7V-Q34M9-CZU8L-8KGFA 
S4J7A-XWXY5-KXAJW-54KRA-TP3QA 
48R4P-NFZ46-NBCWY-Q2ZJT-3H9RA 
NGNW9-7Q8BK-UQGY7-J3KAA-6G39 
Z456C-LMKTC-NLGWQ-H5CUR-ZVWEA 
A5HDP-LXKYN-UK4W6-XACZJ-ENWLA 
NRDX9-ZF9C5-JLGY7-CUC5J-77J2A 
579R9-9B92W-4QHM9-6TK6D-H6F9A 
VETPD-HHC3S-63AH9-YAA26-8WVDA 
SSEWK-HBDM6-YYCWC-M3BQV-9XMDA 
LFKRU-DCTWH-6GJH2-7SWYR-D4CPA 
CQUTS-S5RDR-VT2WJ-9B6TU-DLHPA 
RR36V-7V29A-EVGJA-AYNEC-3DZYA 
UNLZ3-EHBVR-VACLK-S8QDH-JZMHA 
