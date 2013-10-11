# vim 插件vim-jsbeautify格式化压缩js，css，html

###前言
现在网站上的js，css经常都是压缩状态，如果手工去一行一行的排版，那工作量就大了，故有很多排版工具，现在我们介绍一下vim的排版插件vim-jsbeautify 

### 环境支持
1. vim 

	yum install vim
2. nodejs（vim-jsbeautify是调用node来进行排版的） 

	yum install node
3. vim插件管理工具 Vundle 
   
   <a href="http://blog.58share.com/?p=203">安装Vundle</a>


### 安装
<pre>
vim ~/.vimrc

Bundle 'maksimr/vim-jsbeautify'

</pre>
vim命令行输入 :BundleInstall 
安装完成，配置

<pre>
".vimrc
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
</pre>

然后vim 1.min.js , 直接Ctrl+f 即可进行格式化
