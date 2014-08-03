# crop image for avatar

## Background

我们需要裁剪图像，并对图像进行裁剪处理


## Tool

Jquery
Jquery.Jcrop
carrierwave
mini_magick

## How?

1. 前端实现
	通过JCrop Jquery插件实现图像的选择以及avatar位置的选定，通过它可以获取裁剪图像的原坐标点以及宽度以及高度，通过ajax发送给后端
	
2. 后端实现
	
	* 根据上传的图像对原有图像进行缩放至450x450 图像
	* 根据前端返回的图像使用imagemagick进行图像裁剪
	

详细的代码请参考：

https://github.com/huhongda/avatar-crop

## Reference

http://deepliquid.com/content/Jcrop.html

http://railscasts.com/episodes/182-cropping-images-revised?view=asciicast
	

