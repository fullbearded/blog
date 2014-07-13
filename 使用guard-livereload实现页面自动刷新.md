# 使用guard-livereload 实现页面刷新

## install

#### 安装guard-livereload

1. 安装gem包

<pre>
$ vim Gemfile

gem 'guard-livereload'
</pre>

2. 生成配置

<pre>
$ bundle exec guard init
</pre>

3. 启动guard

<pre>
$ bundle exec guard start

23:59:41 - INFO - Guard is using TerminalTitle to send notifications.
23:59:41 - INFO - LiveReload is waiting for a browser to connect.
23:59:41 - INFO - Guard is now watching at '/private/tmp/demo'
[1] guard(main)>
</pre>

#### 安装chrome扩展组件

[Chrome liveReload](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei)

安装成功后，在chrome点击 livereload图标, 查看是否与guard链接成功

<pre>
23:59:41 - INFO - Guard is using TerminalTitle to send notifications.
23:59:41 - INFO - LiveReload is waiting for a browser to connect.
23:59:41 - INFO - Guard is now watching at '/private/tmp/demo'
[1] guard(main)> 00:00:31 - INFO - Browser connected.
</pre>

#### DONE

到此就可以修改scss, coffee文件，浏览器会自动刷新。即实现所见即所得

