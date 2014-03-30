# rails3 升级到rails4所遇到的问题

## ruby -> 1.9.3 => 2.0.0

升级ruby版本, 将1.9.3 升级到2.0.0 , 一般本地开发使用的是rvm或者rbenv

## protected_attributes
<pre>
gem 'protected_attributes'
</pre>

## routes

因为rails4中路由中需要明确get or post， 去除了match路由

<pre>
match '/terms' => 'site#terms'  
</pre>
需要改成：
<pre>
get '/terms' => 'site#terms'
</pre>

## change gems

<pre>
gem 'rails', '4.0.4'
</pre>


## modify scope

rails4 中推荐使用 scope :abc, -> { where name: '111'} 的形式来写

<pre>
scope :valid_products, where('oos = 1')
</pre>

should be 
<pre>
scope :valid_products, -> { where oos: 1 }
</pre>

## FAQ
<pre>
wrong number of arguments (2 for 1)
(in /tmp/build_f664cf41-71b7-435d-b85e-8f607080a4d3/app/assets/stylesheets/application.css.scss)
/tmp/build_f664cf41-71b7-435d-b85e-8f607080a4d3/vendor/bundle/ruby/2.0.0/gems/sass-3.2.14/lib/sass/importers/filesystem.rb:16:in `initialize'
/tmp/build_f664cf41-71b7-435d-b85e-8f607080a4d3/vendor/bundle/ruby/2.0.0/gems/s
</pre>

解决：
<pre>
gem 'sass-rails', '4.0.2'
</pre>



