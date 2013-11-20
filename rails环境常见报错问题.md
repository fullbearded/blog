#rails环境常见报错问题

### 一

<pre>
/usr/local/rvm/gems/ruby-2.0.0-p247/gems/mysql2-0.3.13/lib/mysql2.rb:8:in `require': libmysqlclient.so.18: cannot open shared object file: No such file or directory - /usr/local/rvm/gems/ruby-2.0.0-p247/gems/mysql2-0.3.13/lib/mysql2/mysql2.so (LoadError)
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/mysql2-0.3.13/lib/mysql2.rb:8:in `<top (required)>'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:72:in `require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:72:in `block (2 levels) in require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:70:in `each'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:70:in `block in require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:59:in `each'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:59:in `require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler.rb:132:in `require'
        from /root/gdt_visitor/config/application.rb:7:in `<top (required)>'
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/railties-4.0.0/lib/rails/commands.rb:62:in `require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/railties-4.0.0/lib/rails/commands.rb:62:in `<top (required)>'
        from bin/rails:4:in `require'
        from bin/rails:4:in `<main>'
</pre>
解决：
查看你的centos版本是64位还是32位
32位：
ln -s /usr/local/mysql/lib/libmysqlclient.so.18 /usr/lib/libmysqlclient.so.18
64位：
ln -s /usr/local/mysql/lib/libmysqlclient.so.18 /usr/lib64/libmysqlclient.so.18


### 二

<pre>
/usr/local/rvm/gems/ruby-2.0.0-p247/gems/execjs-2.0.2/lib/execjs/runtimes.rb:51:in `autodetect': Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/execjs-2.0.2/lib/execjs.rb:5:in `<module:ExecJS>'
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/execjs-2.0.2/lib/execjs.rb:4:in `<top (required)>'
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/uglifier-2.2.1/lib/uglifier.rb:3:in `require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/uglifier-2.2.1/lib/uglifier.rb:3:in `<top (required)>'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:72:in `require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:72:in `block (2 levels) in require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:70:in `each'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:70:in `block in require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:59:in `each'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler/runtime.rb:59:in `require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247@global/gems/bundler-1.3.5/lib/bundler.rb:132:in `require'
        from /root/gdt_visitor/config/application.rb:7:in `<top (required)>'
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/railties-4.0.0/lib/rails/commands.rb:62:in `require'
        from /usr/local/rvm/gems/ruby-2.0.0-p247/gems/railties-4.0.0/lib/rails/commands.rb:62:in `<top (required)>'
        from bin/rails:4:in `require'
        from bin/rails:4:in `<main>'
</pre>
解决：
gem install execjs
gem install therubyracer

