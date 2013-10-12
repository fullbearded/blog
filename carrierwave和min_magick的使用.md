#carrierwave和min_magick的使用

##安装


### 安装imagemagick

<pre>
mac:
	brew install ImageMagick

centos:
	yum install ImageMagick
</pre>

### 安装gem包
<pre>
gem install carrierwave
gem install mini_magick
</pre>

## ruby相关源码
代码片段

<pre>

  def compisite_images
    manipulate! do |img|..
      c = MiniMagick::CommandBuilder.new(:convert)
      
      # mini_magick 的 combine_options 方法，如果使用 convert 命令，那么会把文件路径放在第一个参数。
      # 这样不适合在画布上绘制，所以参照其实现，修改了一下。
      c.push %Q(-size 440x629 xc:white)   # 白色背景
	  
	    
      c << img.path

      img.run(c)

      img = yield(img) if block_given?
      img
    end
  end
  
</pre>

相关源码：

1. manipulate! 方法:

<pre>
	ruby-1.9.3-p194/gems/carrierwave-0.8.0/lib/carrierwave/processing/mini_magick.rb
</pre>

2. combine_options 方法:

<pre>
	ruby-1.9.3-p194/gems/mini_magick-3.4/lib/mini_magick.rb +256
</pre>

## 相关知识点
1. mini_magick 实现原理
	调用系统的convert,identify,mogrify等命令处理图片。先把图片写入到临时文件，然后再操作，再保存。

2. 如何查看mini_magick 执行的命令？

ruby-1.9.3-p194/gems/mini_magick-3.4/lib/mini_magick.rb
<pre>

402     def run(command_builder)
403       command = command_builder.command
404       puts command  # 打印命令
405
406       sub = Subexec.run(command, :timeout => MiniMagick.timeout)
407
408       if sub.exitstatus != 0
409         # Clean up after ourselves in case of an error
410         destroy!
411
412         # Raise the appropriate error
413         if sub.output =~ /no decode delegate/i || sub.output =~ /did not return an image/i
414           raise Invalid, sub.output
415         else
416           # TODO: should we do something different if the command times out ...?
417           # its definitely better for logging.. otherwise we dont really know
418           raise Error, "Command (#{command.inspect.gsub("\\", "")}) failed: #{{:status_code => sub.exitstatus, :output => sub.output}.inspect}"
419         end
420       else
421         sub.output
422       end
423     end

</pre>


3. mini_magick防止注入
	调用系统命令时，要注意防止注入。在mini_magick里是使用了shellescape。
	比如：
	<pre>
		path = '/tmp/1.jpg;rm /tmp/1.jpg'
		a    = `identify -format '%w,%h' #{path}` # 路径是拼接的
	</pre>
	
	解决可参考 
	
	http://ruby-china.org/topics/12435
	
	http://hooopo.writings.io/articles/1-Shell-Out-Best-Practice-In-Ruby
	
4. 脱离carrierwave, 独立使用 mini_magick 

比如想得到deal.image 图片的高度和宽度。先使用 tempfile 创建临时文件，然后把图片从gridfs读出来写入该临时文件。然后用 MiniMagick 调用系统命令（这里是 identify).
<pre>
 dst = Tempfile.new(RUBY_VERSION < '1.9' ? "deal": ['deal', ".jpg"])
 dst.binmode
 dst.write deal.image.file.read
 dst.close
 image = ::MiniMagick::Image.new(dst.path,dst)
 p image['dimensions']
</pre>

https://github.com/minimagick/minimagick minimagick使用
