# imagemagic 使用
### identify

> $ identify zhe800_logo.png
> 
> zhe800_logo.png PNG 171x45 171x45+0+0 8-bit sRGB 10.1KB 0.000u 0:00.009
>
> $ identify -quiet -format "%w %h" zhe800_logo.jpg
>  171 45

> $  identify -verbose zhe800_logo.jpg
> 

相关参数：

-quiet 抑制警告信息

-format 输入指定格式的图像特征

1. %w 当前图像的宽度（像素）
2. %h 当前图像的高度（像素） 
3. %m 图像的文件格式 (JPEG PNG..)
4. %r image class and colorspace 图像类和色彩
5. %b 图像大小(字节)

更多的format参数：http://www.imagemagick.org/script/escape.php

-verbose 查看图片的详细信息

更多的identify参数：
http://www.imagemagick.org/script/identify.php

### mogrify

> $ identify -format '%w %h' 1.jpg
> 
> 1600 1200 
>
> $ mogrify -resize 300 1.jpg
> 
> $ identify -format '%w %h' 1.jpg
> 
> 300 225
> 
> $ mogrify -resize x200 1.jpg
> 
> $ identify -format '%w %h' 1.jpg
> 
> 267x200
> 
> $ mogrify -resize '300x300^' 1.jpg
> 
> 400x300
> 
> $ mogrify -resize 50% 1.jpg
> 
> $ mogrify -resize 256x256 1.jpg
> 
> $ mogrify -format jpg 1.png

相关参数：
 
-resize 调整图像

1. scale% 高度和宽度安装百分比调整
2. scale-x%xscale-y% 高度和宽度分别指定百分比
3. width  指定宽度，高度自适应
4. xheight 指定高度，宽度自适应
5. widthxheight 最大高度和宽度值给定,长宽自适应保存, 即长或者宽达到最大，对应的宽活高自适应
6. widthxheight^  最小高度和宽度值给定，长宽自适应保存
7. widthxheight! 高度和宽度给定，忽略长宽比 (这种会失真，一般不采纳)
8. widthxheight> 缩小图的尺寸大于指定宽度或高度参数（即自适应高度或者宽度） 300x-1> 宽度给定，高度自适应
9. widthxheight< 缩小图的尺寸小于指定宽度或高度参数

-format 修改图片类型

参考：http://www.imagemagick.org/script/mogrify.php

