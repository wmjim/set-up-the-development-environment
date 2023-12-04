" vim-plug 插件管理
call plug#begin('~/.vim/plugged')
" plug list
Plug 'scrooloose/nerdtree'              " 文件浏览器
Plug 'tomasr/molokai'			" 主题
Plug 'rust-lang/rust.vim' 		" rust 语法增强
Plug 'prabirshrestha/vim-lsp' 		" 代码补全、错误检查等
Plug 'mattn/vim-lsp-settings'           " vim-lsp 的语言服务器配置
Plug 'dense-analysis/ale' 		" 异步语法检查和代码格式化
" 状态栏
Plug 'youngyangyang04/PowerVim', {'branch': 'master', 'do': { ->'~/.vim/plugin/statusline.vim'}}	
Plug 'preservim/nerdcommenter' 		" 注释
Plug 'wfxr/minimap.vim' 		" 小窗口
call plug#end()

" === vim 基础配置
set nocompatible                        " 不与 Vi 兼容
set showmode                            " 底部显示当前模式
set showcmd                             " 底部显示当前指令
set encoding=utf-8                      " 使用 utf-8 编码
filetype on				" 开启文件类型检测
set t_Co=256                            " 启用 256 色

set autoindent                          " 缩进一致
set tabstop=4                           " 按下 tab 键，显示的空格数
set shiftwidth=4                        " 缩进字符数
set expandtab                           " 自动将 tab 转为空格
set softtabstop=4                       " tab 转为空格数

set number                              " 显示行号
set cursorline                          " 光标所在行高亮
set textwidth=80                        " 设置行宽
set wrap                                " 自动折行
set linebreak                           " 遇到指定符号发生折行
set wrapmargin=2 			" 折行处与编辑窗口右边缘空出的字符数
set scrolloff=5 			" 垂直滚动时，光标距离顶部/底部的位置
set sidescrolloff=15			" 水平滚动时，光标距离行首/行尾的位置
set laststatus=2			" 是否显示状态栏。0：不显示；1：多窗口显示；2：显示
set ruler				" 状态栏显示光标位置

set showmatch				" 光标遇到 ([{ 自动高亮另一个括号
set hlsearch				" 搜索时，高亮显示匹配结果

set spell spelllang=en_us		" 英文单词拼写检查
set nobackup				" 不创建备份文件
set noswapfile				" 不创建交换文件
set undofile				" 保留撤销历史

" 设置备份文件、交换文件、操作历史文件的保存文件
set backupdir=~/.vim/.backup//  
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo// 

set noerrorbells			" 出错时，别发声
set visualbell				" 出错时，屏幕闪烁
set history=1000			" 记住历史操作数
set autoread				" 打开文件监视

set wildmenu				
set wildmode=longest:list,full		" 命令模式下，按下 tab 自动补全


" === NERDTree 配置 ===
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" 当 NERDTree 是选项卡中剩下的唯一窗口，则退出 Vim。
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeShowHidden = 1		" 显示隐藏文件
let g:NERDTreeFileLines = 1		" 显示文件行数
let NERDTreeWinPos="left"		" 设置 NERDTree 子窗口位置
" 设置忽略的文件
let NERDTreeIgnore=['\.vim$', '\~$', '\.o$', '\.d$', '\.a$', '\.out$', '\.tgz$']
" 快捷键 Ctrl + t，打开/关闭目录
nnoremap <C-t> :NERDTreeToggle<CR>


" === rust.vim 配置 ===
syntax enable				" 打开语法高亮
filetype plugin indent on		" 启动文件类型插件、缩进和语法高亮功能

let g:rustfmt_autosave = 1 		" 保存时自动运行 :RustFmt 格式化代码
let g:rustfmt_command = "rustfmt" 	" 自定义格式化命令

" 快捷键 F5 编译运行 Rust 程序
autocmd filetype rust nnoremap <F5> : <bar> exec 'RustRun'<CR>
autocmd filetype rust nnoremap <F6> : <bar> exec 'RustTest'<CR>


" === 主题 tokyonight ===
colorscheme molokai

" === NERDCommenter 配置
let g:NERDCreateDefaultMappings = 1	" 创建默认映射
let g:NERDSpaceDelims = 1 		" 在注释分隔符后添加空格
let g:NERDCompactSexyComs = 1    	" 使用紧凑语法美化多行注释
let g:NERDDefaultAlign = 'left'         " 行式注释分隔符向左对齐
let g:NERDAltDelims_java = 1  		" 将设置默认使用 java 语言的分隔符
let g:NERDCommentEmptyLines = 1    	" 允许注释和反转空行
let g:NERDTrimTrailingWhitespace = 1 	" 在取消注释时去除尾随空白
let g:NERDToggleCheckAllLines = 1 	" 检查所有选定的行是否有注释
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" === Commenter使用 ===
" \cc 注释当前行和选中行
" \cn 没有发现和\cc有区别
" \c<空格> 如果被选区域有部分被注释，则对被选区域执行取消注释操作，其它情况执行反转注释操作
" \cm 对被选区域用一对注释符进行注释，前面的注释对每一行都会添加注释
" \ci 执行反转注释操作，选中区域注释部分取消注释，非注释部分添加注释
" \cs 添加性感的注释，代码开头介绍部分通常使用该注释
" \cy 添加注释，并复制被添加注释的部分
" \c$ 注释当前光标到改行结尾的内容
" \cA 跳转到该行结尾添加注释，并进入编辑模式
" \ca 转换注释的方式，比如： /**/和//
" \cl \cb 左对齐和左右对其，左右对其主要针对/**/
" \cu 取消注释


" === minimap 设置 ===
let g:minimap_width = 17		" 缩略图宽度
let g:minimap_auto_start = 1		" 启动时显示
let g:minimap_auto_start_win_enter = 1	" 进入窗口时自动启动 Minimap


