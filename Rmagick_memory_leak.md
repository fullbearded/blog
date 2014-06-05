<h1>Rmagick memory leak</h1>
<h2>background</h2>
最近做图像处理上使用了Rmagick和MiniMagick, google了一下他们的区别，其中一段话印发了我一系列的思考。
Rmagick存在内存泄露问题。

<h2>开始调研</h2>
<h5>install Rmagick</h5>
在mac上安装Rmagick会存在一些问题，原因是因为<a href="https://github.com/rmagick/rmagick" title="Rmagick"
                              target="_blank">Rmagick</a>不支持最新的<a href="http://www.imagemagick.org/script/index.php"
                                                                  title="ImageMagick" target="_blank"></a>


解决： install pkgconfig, 这个工具会自动解决环境依赖
[bash]
brew install pkgconfig
brew uninstall imagemagick
brew install imagemagick
gem install rmagick
[/bash]

<h5>loop create 1000 times image</h5>
[bash]
require 'RMagick'
include Magick
filename = './1.png'
1000.times do |i|
    origpic = Image::read(filename).first
    newpic = origpic.auto_orient
    origpic.destroy!
    newpic.resize_to_fill!(720)
    new_path = "#{ROOT}/new_#{i}.png"
    newpic.write new_path
    newpic.destroy!
end
[/bash]

这个跑下来约会消耗30M内存,很消耗内存，会随着操作持续内存泄露

<h5>loop create 1000 times image use mini_magick</h5>
[bash]
require 'mini_magick'
include MiniMagick

ROOT = File.expand_path '../', __FILE__
1000.times { |i|
    filename = './logo.png'
    image = MiniMagick::Image::open(filename)
    image.resize('720')
    new_path = "#{ROOT}/new_#{i}.png"
    image.write new_path
    image.destroy!
}
[/bash]

使用mini_magick跑下来仅仅消耗15M内存，

<h5>解决内存不断增加的问题？</h5>
[bash]
# before loop
GC.start  # 释放无用内存
[/bash]

<h5>rmagick,mini_magick底层调用原理</h5>
rmagick,mini_magick都调用了imagemagick,所不同的是rmagick 底层是用C将imagemagick嵌入，而mini_magick是通过调用命令行的方式

<h2>reference</h2>

<a href="https://github.com/rmagick/rmagick/issues/12">https://github.com/rmagick/rmagick/issues/12</a>
<a href="http://markwhitcher.com/rmagick-and-memory-leaks:7328">http://markwhitcher.com/rmagick-and-memory-leaks:7328</a>
