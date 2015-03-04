syntax enable
syntax on                      "支持语法高亮
colorscheme darkblue
set background=dark
set nocompatible               " be iMproved 不要支持vi模式
filetype off                   " required!
set number                     " 开启行号

set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set termencoding=utf-8

" set encoding=gbk
" set fileencodings=gbk,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
" set termencoding=gbk

set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
" set autoindent
set tabstop=2 shiftwidth=2 softtabstop=2      " 设定<<和>>命令移动时的宽度为,使得按退格键时可以一次删掉2个空格
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.
set ignorecase smartcase                      " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set incsearch                                 " 输入搜索内容时就显示搜索结果
set nowrapscan                                " 禁止在搜索到文件两端时重新搜索
set hlsearch                                  " 搜索时高亮显示被找到的文本
set et                                        " 编辑时将所有tab替换为空格

"set nopaste                                   "取消粘贴模式,当粘贴时使用set paste ,取消粘贴模式 set nopaste
"set mouse=a

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" My Bundles here:
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'L9'
Bundle 'FuzzyFinder'
" Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/snipMate'
" Bundle 'mattn/zencoding-vim'
Bundle 'scrooloose/nerdtree'
" Bundle 'groenewege/vim-less'
" Bundle 'kchmck/vim-coffee-script'
" Bundle 'slim-template/vim-slim'
" Bundle 'yaymukund/vim-rabl'
" Bundle 'plasticboy/vim-markdown'
Bundle 'vim-scripts/AutoComplPop'
Bundle 'tComment'
" Bundle 'git://github.com/vim-scripts/taglist.vim.git'
" Bundle 'git://github.com/vim-scripts/winmanager.git'
" Bundle 'git://github.com/vim-scripts/SuperTab.git'
Bundle 'git://github.com/vim-scripts/bufexplorer.zip.git'
Bundle 'git://github.com/vim-scripts/Align.git'
" Bundle 'git://github.com/vim-scripts/txt.vim.git'
Bundle 'maksimr/vim-jsbeautify'
" make status line better
Bundle 'https://github.com/bling/vim-airline.git' 
" Bundle 'Lokaltog/vim-powerline'
" Bundle 'plasticboy/vim-markdown'
"Bundle 'shawncplus/php.vim'
Bundle 'https://github.com/szw/vim-ctrlspace.git'
" 代码对齐线
" Bundle 'https://github.com/nathanaelkane/vim-indent-guides.git'
filetype plugin indent on     " required!  加载插件支持缩进
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set nocindent " 去掉粘贴的自动缩进
set sw=2      " 缩进尺寸为2个空格
set ts=2      " tab宽度为2个字符
set expandtab

"Always show current position
set ruler
" Height of the command bar
set cmdheight=1

" Generic highlight changes 颜色配置
" highlight Comment cterm=none ctermfg=Gray
" highlight IncSearch cterm=none ctermfg=Black ctermbg=DarkYellow
" highlight Search cterm=none ctermfg=Black ctermbg=DarkYellow
" highlight String cterm=none ctermfg=DarkGreen
" highlight treeDir cterm=none ctermfg=Cyan
" highlight treeUp cterm=none ctermfg=DarkYellow
" highlight treeCWD cterm=none ctermfg=DarkYellow
" highlight netrwDir cterm=none ctermfg=Cyan
let g:airline_exclude_preview = 1

hi CtrlSpaceSelected term=reverse ctermfg=187   guifg=#d7d7af ctermbg=23    guibg=#005f5f cterm=bold gui=bold
hi CtrlSpaceNormal   term=NONE    ctermfg=244   guifg=#808080 ctermbg=232   guibg=#080808 cterm=NONE gui=NONE
hi CtrlSpaceSearch   ctermfg=220  guifg=#ffd700 ctermbg=NONE  guibg=NONE    cterm=bold    gui=bold
hi CtrlSpaceStatus   ctermfg=230  guifg=#ffffd7 ctermbg=234   guibg=#1c1c1c cterm=NONE    gui=NONE

" Set the value used for <leader> in mappings 
let g:mapleader = ","  " 修改<leader> 为逗号<,> 默认为<\>号

" <leader>ig use line
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" hi IndentGuidesOdd  ctermbg=lightgrey
" hi IndentGuidesEven ctermbg=white
" 窗口设定
" nmap <leader>g :vertical resize 48 <CR>
" nmap <Leader>m :vertical resize 180 <CR>

"自动记录上次打开文件位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
au BufRead,BufNewFile *  setfiletype txt  " 高亮显示普通txt文件（需要txt.vim脚本


"'''''''''''''''''''''
" markdown
"''''''''''''''''''''
let g:vim_markdown_folding_disabled=1


""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'    "定义ctags的命令目录
let Tlist_Show_One_File    = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow  = 1            "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1            "在右侧窗口中显示taglist窗口
let Tlist_Close_On_Select  = 1            "选择了tag后自动关闭taglist窗口
let Tlist_File_Fold_Auto_Close    = 1     "只显示当前文件tag，其它文件的tag都被折叠起来。
let Tlist_GainFocus_On_ToggleOpen = 1     "在使用:TlistToggle打开taglist窗口时，如果希望输入焦点在taglist窗口

""""""""""""""""""""""""""""""""
" winmanager
" """""""""""""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer|TagList'

""""""""""""""""""""""""""""""""
" SuperTab
" """""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
" 设置按下<Tab>后默认的补全方式, 默认是<C-P>,
" 现在改为<C-X><C-O>. 关于<C-P>的补全方式,
" 还有其他的补全方式, 你可以看看下面的一些帮助:
" :help ins-completion
" :help compl-omni
let g:SuperTabRetainCompletionType=2
" 0 - 不记录上次的补全方式
" 1 - 记住上次的补全方式,直到用其他的补全命令改变它
" 2 - 记住上次的补全方式,直到按ESC退出插入模式为止
let g:acp_behaviorRubyOmniMethodLength = -1

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" set mouse=a
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
" set selection=exclusive
" set selectmode=mouse,key
"快捷键
nnoremap <D-1> :NERDTreeToggle<cr>
nnoremap <D-1> <esc>:NERDTreeToggle<cr>
map  <D-e> :BufExplorer <CR>
imap <D-e> <esc> :BufExplorer <CR>
" map  func :TlistOpen<cr>
"nmap wm :WMToggle<cr>
"map  nu :set nu! <CR>
" 移除行尾空白字符
" map <c-c> :%s/\s*$//g<cr>:noh<cr> 
"""""""""""""""""""""""""""""""""""""""""""'
"  js, css, html beautify
"""""""""""""""""""""""""""""""""""""""""
".vimrc
" map <c-f> :call JsBeautify()<cr>
" map jsb :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-,> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-,> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-,> :call CSSBeautify()<cr>

" plugin for vim-powerline
" https://github.com/Lokaltog/vim-powerline
set laststatus=2
let g:Powerline_colorscheme='solarized256'
let g:Powerline_symbols = 'fancy'
set t_Co=256

" ========================================================================
" 插件的相关使用细节
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" (1) tComment插件的使用: 注：motion 回车键
" ***********************************************************************
"       gc{motion}          注释两行
"       gc<Count>c{motion}  按数字来定义注释的行数
"       gcc                 注释当前行
"       gC{motion}          注释两行
"       gCc                 注释当前行
"   <Leader>__ :: :TComment
"   <Leader>_p :: Comment the current inner paragraph
"   <Leader>_<space> :: :TComment <QUERY COMMENT-BEGIN ?COMMENT-END>
"   <Leader>_i :: :TCommentInline                 ***** 注释成一行
"   <Leader>_r :: :TCommentRight
"   <Leader>_b :: :TCommentBlock                  ***** 多行注释
"   <Leader>_a :: :TCommentAs <QUERY COMMENT TYPE> ***  指定文件注释类型
"   <Leader>_n :: :TCommentAs &filetype <QUERY COUNT>
"   <Leader>_s :: :TCommentAs &filetype_<QUERY COMMENT SUBTYPE> 
"
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" (2) fugitive vim的git插件
" ************************************************************************
"   :Git ,      运行git ...
"   :Gstatus ,  运行git status
"   :Gcommit ,  运行git commit
"   :Gdiff ,    运行git diff
"   :Glog ,     运行git log file
"   :Ge ,       运行e file
"   :Gread ,    运行git checkout file
"   :Gwrite ,   运行git add file
"
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" (3) vim-easymotion vim的查找插件
" ************************************************************************
" 首先:let mapleader=','(最好在vimrc中设置) <leader>改为,形式
" 然后输入,,f{char}, 从光标位置处向后查找所有{char}, 并且临时把它们替换成a,b,c...
" 最后输入b, 光标就跳到第二个{char}上了
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" (4) sparkup  替换html   XX
" ************************************************************************
" 按下Ctrl-e后, 以当前行为参数传递给sparkup.py脚本, 把返回的HTML替换掉原来的行.
" 按下Ctrl-n后, 自动跳到空Tag/Attr里面.
" 注意事项: 该插件只能在编辑HTML时才会生效, 也可以通过:set ft=html强制生效.
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" (5) TOhtml  直接将文件转换为html的形式 
" ************************************************************************
"  :TOhtml
"
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" (6) ctags
" (7) taglist  需要ctags的支持
" ************************************************************************
" <CR>          跳到光标下tag所定义的位置，用鼠标双击此tag功能也一样
" o             在一个新打开的窗口中显示光标下tag
" <Space>       显示光标下tag的原型定义
" u             更新taglist窗口中的tag
" s             更改排序方式，在按名字排序和按出现顺序排序间切换
" x             taglist窗口放大和缩小，方便查看较长的tag
" +             打开一个折叠，同zo
" -             将tag折叠起来，同zc
" *             打开所有的折叠，同zR
" =             将所有tag折叠起来，同zM
" [[            跳到前一个文件
" ]]            跳到后一个文件
" q             关闭taglist窗口
" <F1>          显示帮助
