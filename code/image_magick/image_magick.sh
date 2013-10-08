#!/bin/bash
# image_magick 的使用
current_path=`pwd`
demo_path=`echo ${current_path}/demo`

src_file='1.jpg'

echo $demo_path
if [ ! -d "$demo_path" ]
then
  mkdir "$demo_path"
fi
# 1.将原图格式切换为png格式文件
convert $src_file "${demo_path}/1.png"

# 2.调整图像为原图的90%
convert -resize 90% $src_file "${demo_path}/2.png"

# 3.旋转图像90,180,270度
convert -rotate 90 $src_file "${demo_path}/3.png"
convert -rotate 180 $src_file "${demo_path}/4.png"
convert -rotate 270 $src_file "${demo_path}/5.png"
convert -rotate 30 $src_file "${demo_path}/6.png"

# 4.加边框
convert -mattecolor "#FF3399" -frame 100x100 $src_file "${demo_path}/a.png"
convert -border 60x60 -bordercolor "#FF99CC" $src_file "${demo_path}/b.png"

# 5. 添加文字
# -fill 用什么颜色填充字母
# -pointsize 字母的大小   
# -draw 'text 10,50 "xxx"' 绘图命令
# -font xx.ttf 字体库 （这里字体库不存在有可能导致报错）
convert -font fonts/arial.ttf -fill "#FF3399" -pointsize 50 -draw "text 10,50 'hello world!'" $src_file "${demo_path}/c.png"

# 6.图片合成
# 三种方式
# 1.使用convert命令加 +append或-append参数, 处理图片只能左右或上下来拼接图片
# 2.使用convert命令加 -composite参数, 比较灵活,可以一次性把多张图片合成在一起
# 3.直接使用composite命令来完成，需要一张一张合成
convert +append "${demo_path}/1.png" "${demo_path}/5.png" "${demo_path}/6.png" "${demo_path}/d.png"
convert -append "${demo_path}/1.png" "${demo_path}/5.png" "${demo_path}/6.png" "${demo_path}/f.png"

# -size 尺寸大小 
# xc:none 背景色为透明
# -strip 移除图片描述信息
# -colors 图片的色阶
# -depth 8 像素深度

# 生成一张底图
convert -size 800x800 -strip -colors 256 -depth 8 xc:none "${demo_path}/g.png"

# 生成底图并加直线
# -stroke 线条颜色 -strokewidth 线的宽度
convert -size 800x800 -strip -colors 256 -depth 8 xc:none -stroke white -strokewidth 4 -draw "line 10,25 500,25" "${demo_path}/ga.png"

convert -size 800x800 -strip -colors 256 -depth 8 xc:none -stroke white -strokewidth 4 -draw "circle 70,70 5,70" "${demo_path}/gb.png"
convert -size 800x800 -strip -colors 256 -depth 8 xc:none -stroke white -strokewidth 4 -draw "ellipse  70,70 60,30 90,270" "${demo_path}/gc.png"
convert -size 800x800 -strip -colors 256 -depth 8 xc:none -stroke white -strokewidth 4 -draw "Rectangle 10,10 140,140" "${demo_path}/gd.png"
convert -size 800x800 -strip -colors 256 -depth 8 xc:none -stroke white -strokewidth 4 -draw "Rectangle 10,10 140,140" "${demo_path}/ge.png"

# 合成图片
# -geometry 定义坐标原点
# -geometry 指定合成图偏坐标位置
# -gravity 指定的位置：NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast.
convert -size 1800x1800 -strip -colors 256 -depth 8 xc:none "${demo_path}/5.png" -geometry +0+0 -composite "${demo_path}/c.png"  -gravity center -composite "${demo_path}/a.png" -gravity SouthEast -composite  "${demo_path}/h.png" 

# 合成图片并添加文字
convert -size 1800x1800 -strip -colors 256 -depth 8 xc:white "${demo_path}/5.png" -geometry +0+0 -composite "${demo_path}/c.png"  -gravity center -composite "${demo_path}/a.png" -gravity SouthEast -composite  -font fonts/arial.ttf -fill "#FF3399" -pointsize 150  -gravity West -draw "text 10,50 'hello world!'"  "${demo_path}/j.png" 


# 第三种方式
convert -size 1800x1800 -strip -colors 256 -depth 8 xc:black "${demo_path}/i.png"
composite -geometry +0+0 "${demo_path}/5.png" "${demo_path}/i.png" "${demo_path}/i.png"
composite -gravity center "${demo_path}/c.png" "${demo_path}/i.png" "${demo_path}/i.png"
composite -gravity SouthEast "${demo_path}/a.png" "${demo_path}/i.png" "${demo_path}/i.png"

# 制作gif图片
# 分两步合成
convert -charcoal 1 $src_file "${demo_path}/tmp.png"
convert -negate $src_file "${demo_path}/tmp2.png"
convert -delay 50 $src_file "${demo_path}/c.png" "${demo_path}/a.gif"
convert -delay 100 "${demo_path}/tmp.png" "${demo_path}/tmp2.png" "${demo_path}/b.gif"
convert "${demo_path}/a.gif" "${demo_path}/b.gif" "${demo_path}/c.gif"


# 其他效果
# 素描 -charcoal 参数越大碳效越高
convert -charcoal 1 $src_file "${demo_path}/7.png"
convert -charcoal 5 $src_file "${demo_path}/8.png"

# 着色 -colorize 
convert -colorize 255 $src_file "${demo_path}/9.png"
convert -colorize 302010 $src_file "${demo_path}/10.png"

# 内爆 -implode 参数为内爆效果量
convert -implode 1 $src_file "${demo_path}/11.png"

# 曝光 -solarize
convert -solarize 80 $src_file "${demo_path}/12.png"

# 散射 -spread
convert -spread 4 $src_file "${demo_path}/13.png"

# 模糊 -blur 
convert -blur 30x5 $src_file "${demo_path}/14.png"

# 反转
  # 上下反转 -flip
  convert -flip $src_file "${demo_path}/15.png"
  # 左右反转 -flop 
  convert -flop $src_file "${demo_path}/16.png"

# 反色 -negate 
convert -negate $src_file "${demo_path}/17.png"

# 单色 把图片变为黑白颜色 -monochrome
convert -monochrome $src_file "${demo_path}/18.png"

# 噪声 -noise
convert -noise 10 $src_file "${demo_path}/19.png"

# 油画效果 -paint
convert -paint 4 $src_file "${demo_path}/20.png"

# 漩涡 -swirl
convert -swirl 87 $src_file "${demo_path}/21.png"

# 凸起效果  -raise 加边框效果
convert -raise 20x20 $src_file "${demo_path}/22.png"


##### 把多张图片转换为pdf格式文件
# convert "${demo_path}/*.png" demo.pdf


