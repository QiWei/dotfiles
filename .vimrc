" ===========================================================
"                   vimrc —— Vim 配置文件
" ===========================================================

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Introduction {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =================================================
"     FileName: .vimrc
"       Author: QiWei <QiWei.Email@gmail.com>
"   LastChange: 2012-03-30 08:32:18
"       Readme:
"        Usage:
" =================================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          _
"      __ | \
"     /   | /
"     \__ | \
" by Amix - http://amix.dk/
"
" Maintainer:	Amir Salihefendic <amix3k at gmail.com>
" Version: 2.7
" Last Change: 12/10/06 00:09:21
" Modify: QiWei
" Last Change: 24/09/09 01:34:36
"
" Sections:
" ----------------------
"	*> Encode
"	*> General
"	*> Theme/Colors
"	*> Fonts
"	*> Fileformats
"	*> Files/Backups
"	*> Vim userinterface
"		---- *> Statusline
"	*> Visual Cues
"	*> Print Options
"	*> Text Formatting/Layout
"		---- *> Indent
"	*> Folding
"	*> Plugin configuration
"		---- *> Environment Variable
"		---- *> GNU Programs
"		---- *> 2html.vim
"		---- *> bash-support.vim
"		---- *> buf2html.Vim
"		---- *> c.vim
"		---- *> Calendar.vim
"		---- *> DoxygenToolkit.vim
"		---- *> File Explorer
"		---- *> Grep
"		---- *> HTML.vim
"		---- *> fencview.vim
"		---- *> Intellisense
"		---- *> javacomplete.vim - Omni Completion for JAVA
"		---- *> LaTeX Suite things
"		---- *> Matchit.vim
"		---- *> Minibuffer
"		---- *> NERD_commenter.vim
"		---- *> Perl
"		---- *> perl-support.vim
"		---- *> Sketch.vim
"		---- *> Tag List(CTags)
"		---- *> Tags Menu(CTags)
"		---- *> txtbrowser.vim
"		---- *> Viki - A Pseudo Local Wiki Tool
"		---- *> Win Manager
"	*> Filetype generic
"		---- *> Todo
"		---- *> VIM
"		---- *> HTML related
"		---- *> Ruby & PHP section
"		---- *> Python section
"		---- *> Cheetah section
"		---- *> Vim section
"		---- *> Java section
"		---- *> JavaScript section
"		---- *> HTML
"		---- *> C mappings
"		---- *> SML
"		---- *> Scheme bidings
"		---- *> SVN section
"		---- *> NSIS section
"	*> Snippets
"		---- *> Python
"		---- *> JavaScript
"		---- *> HTML
"		---- *> Java
"	*> Moving around and tabs
"	*> General Autocommands
"	*> Parenthesis/bracket expanding
"	*> General Abbrevs
"	*> Editing mappings etc.
"	*> Command-line config
"	*> Buffer realted
"	*> Cope
"	*> MISC
"	*> Custom Functions
"	*> Mappings
"	*> Autocommands
"	*> Useful abbrevs
"
"  Tip:
"   If you find anything that you can't understand than do this:
"   help keyword OR helpgrep keywords
"  Example:
"   Go into command-line mode and type helpgrep nocompatible, ie.
"   :helpgrep nocompatible
"   then press <leader>c to see the results, or :botright cw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff I have decided I don't like
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set ignorecase -- turns out, I like case sensitivity
" set list " turns out, I don't like listchars -- show chars on end of line, whitespace, etc
" autocmd GUIEnter * :simalt ~x -- having it auto maximize the screen is annoying
" autocmd BufEnter * :lcd %:p:h -- switch to current dir (breaks some scripts)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Initialization {{{1
" 初始化
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" => [" ====	init: Vim/Vi Compatible	==== {{{2"]
	" =================================================
	" Use Vim settings, rather then Vi settings (much better!).
	" This must be first, because it changes other options as a side effect.
	" 不要使用vi的键盘模式，而是vim自己的
	if has('vim_starting')
		set nocompatible
	endif

	" ============================================= }}}2
	" => [" ====	runtime: Windows Compatible ==== {{{2"]
	" =================================================
	" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
	" across (heterogeneous) systems easier.
	" 设定一个目录存放所有plugin，通常是 ~/.vim（视环境调整）下的 bundle 目录。
	" {{{
	if has('vim_starting')
		if has('win32') || has('win64')
			if has("gui_win32")
				" g:gvim_rtp should be set by gvimrc
				if exists('g:gvim_rtp') && isdirectory(fnamemodify(g:gvim_rtp, ':p'))
					let s:rtp = g:gvim_rtp
				else
					" echoerr "You must set runtimepath (for plugin bundling) manually."
					" finish
					let s:rtp = "~/.vim"
				endif
			else
				let s:rtp = "~/.vim"
			endif
		else
			let s:rtp = "~/.vim"
		endif

		if !isdirectory(fnamemodify(s:rtp, ':p'))
			try
				call mkdir(fnamemodify(s:rtp, ':p'), "p")
			catch /^Vim\%((\a\+)\)\=:E739/
				echoerr "Error detected while processing: " . v:throwpoint . ":\n  " . v:exception .
							\  "\nCan't make runtime directory. Skipped sourcing vimrc.\n"
				finish
			endtry
		endif

		" set runtimepath=$HOME\.vim,$VIM\vimfiles,$VIMRUNTIME,$VIM\vimfiles\after,$HOME\.vim\after
		" set runtimepath+=~/.vim,~/.vim/after
		execute "set runtimepath+=" . fnamemodify(s:rtp, ':p')
		execute "set runtimepath+=" . fnamemodify(s:rtp, ':p') . 'after'
	endif
	" }}}

	" ============================================= }}}2
	" => [" ====	init: Environment Variable	==== {{{2"]
	" 环境变量
	" =================================================
	if $OSTYPE == 'cygwin'
		" set cdpath+=/cygdrive/g/web/
		" set path+=/home/www/
	elseif $OSTYPE == 'linux-gnu'
		set cdpath+=/home/www/
		set path+=/home/www/
	elseif $OS == 'Windows_NT'
		if !exists("$COMMONFILES")
			let $VIM_DRIVE = strpart($VIM, 0, 2)
			let $COMMONFILES = $VIM . '\..\..\..\CommonFiles'
			let $COMMONFILES = (($VIMRUNTIME =~? "PortableApps") ? $VIM . '\..\..\..' : strpart($VIMRUNTIME, 0, 2) . '\PortableApps') . '\CommonFiles'
			let $COMMONFILES = $VIM_DRIVE . '\PortableApps\CommonFiles'
			let $JAVA = $COMMONFILES . '\Java\bin'
			let $MinGW = $COMMONFILES . '\MinGW\bin'
			let $MSYS = $COMMONFILES . '\MSYS\bin'
			let $PERL = $COMMONFILES . '\Perl\bin'
			let $UnxUtils = $COMMONFILES . '\UnxUtils\usr\local\wbin'
	
			" GNU的应用程序相关的设定
			let $GNU = $VIM . '\GnuWin32'
			let $CoreUtils = $VIM . '\GnuWin32\CoreUtils'

			let $VIM_PATH = $VIM

			let $VIM_PATH .= ';' . $VIM . '\bin'
			let $VIM_PATH .= ';' . $VIM . '\vimfiles'
			let $VIM_PATH .= ';' . $VIM . '\GnuWin32'
			let $VIM_PATH .= ';' . $VIM . '\GnuWin32\CoreUtils'

			let $VIM_PATH .= ';' . $HOME
			let $VIM_PATH .= ';' . $HOME . '\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . 'vim\bin'

			let $VIM_PATH .= ';' . $COMMONFILES
			let $VIM_PATH .= ';' . $COMMONFILES . '\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\GNU'
			let $VIM_PATH .= ';' . $COMMONFILES . '\GNU\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\MinGW\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\GnuWin32\bin'

			" Git {{{3
			let $VIM_PATH .= ';' . $COMMONFILES . '\Git\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Git\MinGW\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Git\cmd'
			" }}}3

			let $VIM_PATH .= ';' . $COMMONFILES . '\GTK\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Java\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Mercurial'
			let $VIM_PATH .= ';' . $COMMONFILES . '\MSYS\bin'
			" let $VIM_PATH .= ';' . $COMMONFILES . '\MSYS\MinGW\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\NirSoft'
			let $VIM_PATH .= ';' . $COMMONFILES . '\NSIS'
			let $VIM_PATH .= ';' . $COMMONFILES . '\OpenSSL\bin'
			" let $VIM_PATH .= ';' . $COMMONFILES . '\Perl\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Python27'
			let $PythonPath =  $COMMONFILES . '\Python27\Lib;' . $COMMONFILES . '\Python27\DLLs;' . $COMMONFILES . '\Python27\Lib\lib-tk'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Ruby\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\StrawberryPerl\c\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\StrawberryPerl\perl\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Subversion\bin'
			let $VIM_PATH .= ';' . $COMMONFILES . '\SysinternalsSuite'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Windows Resource Kits'

			" WinXP & Visual C++ 6.0 {{{3
			let $VIM_PATH .= ';' . $COMMONFILES . '\Microsoft Visual Studio\VC98\BIN'
			let $VIM_PATH .= ';' . $COMMONFILES . '\Microsoft Visual Studio\COMMON\MSDev98\Bin'
			let $INCLUDE .= ';' . $COMMONFILES . '\Microsoft Visual Studio\VC98\INCLUDE'
			let $INCLUDE .= ';' . $COMMONFILES . '\Microsoft Visual Studio\VC98\MFC\INCLUDE'
			let $LIB .= ';' . $COMMONFILES . '\Microsoft Visual Studio\VC98\LIB'
			let $LIB .= ';' . $COMMONFILES . '\Microsoft Visual Studio\VC98\MFC\LIB'
			let $MSDevDir .= ';' . $COMMONFILES . '\Microsoft Visual Studio\VC98'
			" }}}3

			" MiKTeX {{{3
			let MIKTEX_BINDIR = $COMMONFILES . '\MiKTeX\miktex\bin'
			let MIKTEX_COMMONSTARTUPFILE = $COMMONFILES . '\MiKTeX\miktex\config\miktexstartup.ini'
			let MIKTEX_GS_LIB = $COMMONFILES . '\MiKTeX\ghostscript\base;%CommonFiles\MiKTeX\fonts'
			let MIKTEX_USERSTARTUPFILE = $COMMONFILES . '\MiKTeX\miktex\config\miktexstartup.ini'
			let $VIM_PATH .= ';' . $COMMONFILES . '\MiKTeX\miktex\bin'
			" }}}3

			"Highlight converts sourcecode to HTML, XHTML, RTF, LaTeX, TeX, SVG, BBCode, XML
			"and terminal escape sequences with coloured syntax highlighting.
			let $VIM_PATH .= ';' . $COMMONFILES . '\Highlight' "

			" Setting up for Java {{{3
			if !exists($JAVA_HOME)
				let $JAVA_HOME = $COMMONFILES . '\jdk1.6.0_25'
				let $VIM_PATH .= ';' . $JAVA_HOME . '\bin'
				let $CLASSPATH = '.;'
				let $CLASSPATH = $CLASSPATH . ';' . $JAVA_HOME . '\lib\dt.jar'
				let $CLASSPATH = $CLASSPATH . ';' . $JAVA_HOME . '\lib\tools.jar'
				let $CLASSPATH = $CLASSPATH . ';' . $COMMONFILES . '\rhino1_7R3\js.jar'
			endif
			" }}}3

			" Add to environment variable
			let $PATH = $VIM_PATH . ";" . $PATH
		endif
	endif

	" ============================================= }}}2
	" => [" ====	init: Startup	==== {{{2"]
	" =================================================
	if has('vim_starting')
		set all&
		" mapclear
		" mapclear!
	endif

	" ============================================= }}}2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Options configuration {{{1
" 选项相关配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" => [" ====	option: Encode	 ==== {{{2"]
	" 语言编码设置
	" =================================================
	"" 编码 {{{
	" 这一块比较乱，因为要配合 balloon 特性一起使用。
	" Multi-encoding setting, MUST BE IN THE BEGINNING OF .vimrc!
	if has("multi_byte")
		set nolinebreak
		" When 'fileencodings' starts with 'ucs-bom', don't do this manually
		" set bomb
		" 设置文件编码检测类型及支持格式
		" set fileencodings=ucs-bom,chinese,taiwan,japan,korea,utf-8,latin1
		" set fileencodings=ucs-bom,chinese,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin-1
		set fileencodings=ucs-bom,utf-8,gbk,gb2312,cp936,gb18030,big5,euc-jp,euc-kr,latin1
		" CJK environment detection and corresponding setting
		if v:lang =~ "^zh_CN" || v:lang =~ "utf8$" || v:lang =~ "UTF-8$" || v:lang =~ "^en_US"
			" Simplified Chinese, on Unix euc-cn, on MS-Windows cp936
			let &termencoding = &encoding

			" 会乱码
			" set encoding=chinese
			set encoding=utf-8

			"" 设置终端编码 {{{
			if has("win32")
				" set fileencoding=chinese
				" set termencoding=GBK
			else
				" set fileencoding=utf-8
				" set termencoding=utf-8
				let &termencoding = &encoding
			endif
			" }}}

			" 设定默认解码 {{{
			if &fileencoding == ''
				set fileencoding=utf-8
			else
				set fileencoding=chinese
			endif
			" }}}

			"" 解决乱码 {{{
			if has("win32")
				" 解决consle输出乱码
				language messages zh_CN.utf-8
				" language messages POSIX

				" 解决菜单乱码
				" set langmenu=none
				" source $VIMRUNTIME/delmenu.vim
				" 指定菜单语言
				" set langmenu=zh_CN.utf-8
				" source $VIMRUNTIME/menu.vim
			endif
			" }}}
		elseif v:lang =~ "^zh_TW"
			" Traditional Chinese, on Unix euc-tw, on MS-Windows cp950
			set encoding=taiwan
			set termencoding=taiwan
			if &fileencoding == ''
				set fileencoding=taiwan
			endif
		elseif v:lang =~ "^ja_JP"
			" Japanese, on Unix euc-jp, on MS-Windows cp932
			set encoding=japan
			set termencoding=japan
			if &fileencoding == ''
				set fileencoding=japan
			endif
		elseif v:lang =~ "^ko"
			" Korean on Unix euc-kr, on MS-Windows cp949
			set encoding=korea
			set termencoding=korea
			if &fileencoding == ''
				set fileencoding=korea
			endif
		endif
		" Detect UTF-8 locale, and override CJK setting if needed
		if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
			set encoding=utf-8
		endif
	else
		echoerr 'Attention!! This version of (g)Vim was not compiled with "multi_byte".'
	endif
	" }}}

	"" 判断 Vim 是否包含多字节语言支持，并且版本号大于 7.3 {{{
	if has('multi_byte') && v:version > 703
		" 如果 Vim 的语言（受环境变量 LANG 影响）是中文（zh）、日文（ja）
		" 或韩文（ko）的话，将模糊宽度的 Unicode 字符的宽度设为双宽度（double）
		if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
			set ambiwidth=double
		endif
	endif
	" }}}

	"" 在 shell 中指定要打开文件的编码 {{{
	" vim file_name -c "e ++enc=cp936"
	" }}}

	"" 中文帮助 {{{
	set helplang=cn
	" }}}


	" ============================================= }}}2
	" => [" ====	option: General	==== {{{2"]
	" 一般设置
	" =================================================
	" 侦测文件类型
	filetype on

	" 设定文件浏览器目录为当前目录
	set autochdir

	" 使用相关缓冲区的目录作为文件浏览器使用的目录
	set browsedir=buffer

	" 在处理未保存或只读文件的时候，弹出确认
	set confirm

	" 与windows共享剪贴板
	set clipboard+=unnamed

	" 保存全局变量
	set viminfo+=!

	" 带有如下符号的单词不要被换行分割
	set iskeyword+=_,$,@,%,#,-

	" 标识符字符
	" isident+=
	" 文件名字符
	" isfname+=
	" 可显示字符
	" isprint+=


	" ============================================= }}}2
	" => [" ====	option: Theme/Colors	==== {{{2"]
	" 主题/色彩
	" =================================================
	" enable 256 colors
	if has('unix') && !has('mac')
		set t_Co=256
	endif

	" 颜色主题
	if (has("gui_running")) " 图形界面下的设置
		set background=dark
		colorscheme desert
		" colorscheme evening
		" colorscheme torte
	else " 字符界面下的设置
		" colo ron
		colorscheme murphy
	endif

	" 语法高亮显示
	syntax on

	" 高亮字符，让其不受100列限制
	" :highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
	" :match OverLength '\%101v.*'

	" 高亮当前行
	if has("gui_running")
		set cursorline
		highlight cursorline guibg=#333333
		highlight CursorColumn guibg=#333333
	endif

	" 高亮 'textwidth' 之后的列
	set colorcolumn=+1
	
	" 高亮'colorcolumn' 设置的列
	highlight ColorColumn ctermbg=lightgrey guibg=lightgrey


	" ============================================= }}}2
	" => [" ====	option: Fonts	==== {{{2"]
	" 字体设置
	" =================================================
	if has('gui_running')
		if has('gui_gtk')
			set guifont=Monospace\ 11
		elseif has('gui_macvim')
			set guifont=Monaco:h11
		elseif has('gui_win32')
			set guifont=Consolas:h11:cANSI
			" exec 'set guifont=' . iconv('Courier_New', &enc, 'gbk') . ':h11:cANSI'
			" exec 'set guifontwide=' . iconv('微软雅黑', &enc, 'gbk') . ':h11'
		endif
	endif
	
	" set guifont=Courier_New:h8:w5
	" set guifont=Consolas:h10:cANSI
	" set guifontwide=NSimSun:h
	" set guifontwide=微软雅黑:h10
	" set guifontwide=YaHei\ Consolas\ Hybrid:h10
	" set guifontwide=新宋体:h12:cGB2312
	" set guifontwide=新宋体:h12
	" set gfw=YouYuan:h10

	" ClearType 启用 – 11pt/14px
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h10.5:cANSI
				" 插件Powerline相关的字体
	set guifont+=Menlo\ Regular\ for\ Powerline:h11
	set guifont+=Envy_Code_R:h11:cANSI
	set guifont+=Inconsolata:h11:cANSI
				" Inconsolata是个人最喜欢的字体，而且它是免费的。
				" 很漂亮，关键是在中英文混排的时候能使中文也显示得很好。但有的时候感觉太窄了，两个字母的间距太小。
	set guifont+=Consolas:h10.5:cANSI
				" Consolas是一个商业字体，也就是说它不是免费的，但它与很多微软的产品捆绑在一起。如果它能免费提供，应该会成为此名单上的第一名！
				" 11号粗体会变形
	set guifont+=DejaVu_Sans_Mono:h11:cANSI
				" Deja Vu是个人最喜爱的免费的系列字体之一，在任何尺寸下的表现都很好。
	set guifont+=Droid_Sans_Mono:h11:cANSI
				" Droid 系列字体是一套不错的字体，尤其是在小屏的手持设备中表现更佳，例如Android，它基于Apache license。
				" 间距很合适，就是中英文混排的时候会把中文拉扁，不过有的时候也可以容忍。
	set guifont+=Proggy:h11:cANSI
				" Proggy是一个看上去很干净的等宽字体，很受Windows用户的亲睐，在Mac上的效果也还不错。一般在字体尺寸比较小的情况下使用。
	set guifont+=Monofur:h11:cANSI
				" Monofur是一个比较独特的宽字体，在任何尺寸下的效果都很不错。不管是在大尺寸还是小尺寸中，都要开启anti-aliasing效果。
	set guifont+=Profont:h11:cANSI
				" Profont是一个类似于Monaco的字体，可以在Mac，Windows，Linux下使用，在尺寸较小的情况下效果最佳。
	set guifont+=Monaco:h11:cANSI
				" Monaco一直都是Mac上默认的等宽字体，个人认为这个字体在9-10号大小，不使用anti-aliasing 的情况下效果最佳。
	set guifont+=Andale_Mono:h11:cANSI
				" 它比Courier系列的字体看上去要舒服一点，由于在很多系统中都表现的非常友好，所以也经常被作为默认字体使用。不过字体间的距离还是让人不太满意。
	set guifont+=Bitstream_Vera_Sans_Mono:h11:cANSI
	set guifont+=Lucida_Sans_Typewriter:h11:cANSI
	set guifont+=Pragmata:h11:cANSI
	set guifont+=Envy_Code_R:h11:cANSI

	" ClearType 未启用 – 9pt/12px
	set guifont+=Courier_New:h9:cANSI,
				\Lucida_Sans_Typewriter:h9:cANSI,
				\Andale_Mono:h9:cANSI,
				\CodingFontTobi:h12:cANSI,
				\ProFontWindows:h9:cANSI,
				\Microsoft_YaHei_Mono:h10.5,
				\Yahei_Mono:h10.5

	set guifontwide=
					\Microsoft_YaHei_Mono,
					\YaHei_Consolas_Hybrid,
					\Yahei_Mono
	" 当guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h10 时 YaHei_Consolas_Hybrid 和 Yahei_Mono 中英文字体不一般高

	if &encoding == "utf-8"
		set guifontwide+=
						\Microsoft_Yahei:cGB2312,
						\NGK_YuanTi:cGB2312,
						\XHei_Mono:cGB2312,
						\WenQuanYi_Zen_Hei_Mono:cGB2312,
						\WenQuanYi_Micro_Hei_Mono:cGB2312,
						\Yahei_Mono:cGB2312,
						\FZZhunYuan-M02:cGB2312,
						\FangSong:cGB2312,
						\KaiTi:cGB2312,
						\SimHei:cGB2312,
						\LiSu:cGB2312,
						\nSimSun:cGB2312,
						\SimSun-ExtB:cGB2312,
						\YouYuan:cGB2312
	else
		set guifontwide+=
						\微软雅黑:cGB2312,
						\新浪漫雅圆:cGB2312,
						\XHei_Mono:cGB2312,
						\文泉驿等宽微米黑:cGB2312,
						\文泉驿等宽微正黑:cGB2312,
						\雅黑_Mono:cGB2312,
						\方正准圆_GBK:cGB2312,
						\仿宋:cGB2312,
						\楷体:cGB2312,
						\黑体:cGB2312,
						\隶书:cGB2312,
						\新宋体:cGB2312,
						\SimSun-ExtB:cGB2312,
						\幼圆:cGB2312
	endif

	" map for guifont
	nmap ,fi :set guifont=Inconsolata:h11:cANSI<cr>
	nmap ,fc :set guifont=Consolas:h10.5:cANSI<cr>
	nmap ,fd :set guifont=DejaVu_Sans_Mono:h11:cANSI<cr>
	nmap ,fD :set guifont=Droid_Sans_Mono:h11:cANSI<cr>
	nmap ,fp :set guifont=Proggy:h11:cANSI<cr>
	nmap ,fm :set guifont=Monofur:h11:cANSI<cr>
	nmap ,fP :set guifont=Profont:h11:cANSI<cr>
	nmap ,fM :set guifont=Monaco:h11:cANSI<cr>
	nmap ,fa :set guifont=Andale_Mono:h11:cANSI<cr>
	nmap ,fb :set guifont=Bitstream_Vera_Sans_Mono:h11:cANSI<cr>
	nmap ,fl :set guifont=Lucida_Sans_Typewriter:h11:cANSI<cr>
	nmap ,fg :set guifont=Pragmata:h11:cANSI<cr>
	nmap ,fe :set guifont=Envy_Code_R:h11:cANSI<cr>
	nmap ,fy :set guifont=Yahei_Mono:h10.5:cANSI<cr>
	nmap ,fY :set guifont=Microsoft_Yahei_Mono:h10.5:cANSI<cr>

	" map for guifontwide
	nmap ,fwmy :set guifontwide=Microsoft_Yahei:cGB2312<cr>
	nmap ,fwyt :set guifontwide=NGK_YuanTi:cGB2312<cr>
	nmap ,fwxh :set guifontwide=XHei_Mono:cGB2312<cr>
	nmap ,fwwz :set guifontwide=WenQuanYi_Zen_Hei_Mono:cGB2312<cr>
	nmap ,fwwm :set guifontwide=WenQuanYi_Micro_Hei_Mono:cGB2312<cr>
	nmap ,fwyh :set guifontwide=Yahei_Mono:cGB2312<cr>
	nmap ,fwYH :set guifontwide=Microsoft_Yahei_Mono:cGB2312<cr>
	nmap ,fwzy :set guifontwide=FZZhunYuan-M02:cGB2312<cr>
	nmap ,fwfs :set guifontwide=FangSong:cGB2312<cr>
	nmap ,fwkt :set guifontwide=KaiTi:cGB2312<cr>
	nmap ,fwsh :set guifontwide=SimHei:cGB2312<cr>
	nmap ,fwls :set guifontwide=LiSu:cGB2312<cr>
	nmap ,fwns :set guifontwide=nSimSun:cGB2312<cr>
	nmap ,fwss :set guifontwide=SimSun-ExtB:cGB2312<cr>
	nmap ,fwyy :set guifontwide=YouYuan:cGB2312<cr>

	" map for guifontwide (utf-8)
	if has("gui_win32")
		 nmap ,fuyh :exec 'set guifontwide=' . iconv('微软雅黑', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuyy :exec 'set guifontwide=' . iconv('新浪漫雅圆', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuxh :exec 'set guifontwide=' . iconv('XHei_Mono', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuwm :exec 'set guifontwide=' . iconv('文泉驿等宽微米黑', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuwz :exec 'set guifontwide=' . iconv('文泉驿等宽微正黑', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuYH :exec 'set guifontwide=' . iconv('雅黑_Mono', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuzy :exec 'set guifontwide=' . iconv('方正准圆_GBK', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fufs :exec 'set guifontwide=' . iconv('仿宋', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fukt :exec 'set guifontwide=' . iconv('楷体', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuht :exec 'set guifontwide=' . iconv('黑体', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuls :exec 'set guifontwide=' . iconv('隶书', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuxs :exec 'set guifontwide=' . iconv('新宋体', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fust :exec 'set guifontwide=' . iconv('SimSun-ExtB', &enc, 'gbk') . ':cDEFAULT'<cr>
		 nmap ,fuYY :exec 'set guifontwide=' . iconv('幼圆', &enc, 'gbk') . ':cDEFAULT'<cr>
	endif


	" ============================================= }}}2
	" => [" ====	option: Fileformats	==== {{{2"]
	" 换行类型
	" =================================================
	set ffs=dos,unix,mac
	nmap <leader>fd :se ff=dos<cr>
	nmap <leader>fu :se ff=unix<cr>


	" ============================================= }}}2
	" => [" ====	option: Files/Backups	==== {{{2"]
	" 文件设置
	" =================================================
	" history文件中需要记录的行数
	" set history=100
	set history=1000
	set undofile
	set undoreload=1000

	" 备份文件
	set backup " make backup file " 备份
	" set nobackup " 不要备份

	" 不要生成swap文件
	" setlocal noswapfile

	" 当buffer被丢弃的时候隐藏它
	set bufhidden=hide

	" 备份文件的路径
	" set backupdir=$VIM\vimfiles\backup

	" 临时文件的路径
	" set directory=$VIM\vimfiles\temp

	" set makeef=error.err

	" Function:InitializeDirectories() {{{ 
	" create tmp folder and the subfolders if they don't exist.
	function! InitializeDirectories()
		let separator = "."
		let parent = $HOME 
		let prefix = '.vim/tmp/'
		if !isdirectory(parent.'/'.prefix)
			call mkdir(parent.'/'.prefix)
		endif

		let dir_list = { 
					\ 'backup': 'backupdir', 
					\ 'views': 'viewdir', 
					\ 'undo' : 'undodir',
					\ 'swap': 'directory' }

		for [dirname, settingname] in items(dir_list)
			let directory = parent . '/' . prefix . dirname . "/"
			if exists("*mkdir")
				if !isdirectory(directory)
					call mkdir(directory)
				endif
			endif
			if !isdirectory(directory)
				echo "Warning: Unable to create backup directory: " . directory
				echo "Try: mkdir -p " . directory
			else  
				let directory = substitute(directory, " ", "\\\\ ", "")
				exec "set " . settingname . "=" . directory
			endif
		endfor
	endfunction
	" }}}
	call InitializeDirectories() 


	" ============================================= }}}2
	" => [" ====	option: Userinterface	==== {{{2"]
	" Vim 界面设置
	" =================================================
	" 字符间插入的像素行数目
	set linespace=0

	" 执行宏、寄存器和其它不通过输入的命令时屏幕不会重画
	set lazyredraw

	" 在被分割的窗口间显示空白，便于阅读
	set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:-,diff:-
	" set fillchars=diff:⣿,vert:│ " Change fillchars
	
	" Only show trailing whitespace when not in insert mode
	" augroup trailing
	" 	autocmd!
	" 	autocmd InsertEnter * :set listchars-=trail:⌴
	" 	autocmd InsertLeave * :set listchars+=trail:⌴
	" augroup END

	" 窗口的分割会把新窗口放到当前窗口之下
	set splitbelow

	" 窗口的分割会把新窗口放到当前窗口之右
	set splitright

	if has("gui_running")
		" 显示窗口的行数和列数
		set lines=80 " 80 lines tall
		set columns=160 " 160 cols wide
		" 启动时全屏
		autocmd GUIEnter * :simalt ~x
	else
		set lines=37
		set columns=127
	endif

	" 不要闪烁
	set novisualbell

	" 不要错误提示音
	set noerrorbells

	" 启动的时候不显示那个援助索马里儿童的提示
	set shortmess=atI

		" => [" ====	option: command-line&WildMenu	==== {{{3"]
		" =================================================
		" Set command-line

		" 命令行（在状态行下）的高度，默认为1
		set cmdheight=1

		" 在屏幕最后一行显示 (部分的) 命令
		set showcmd

		" 通过使用":"命令，告诉我们文件的哪一行被改变过
		set report=0

		" 增强模式中的命令行自动完成操作
		set wildmenu
		" together with wildmenu
		set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
		set wildignore+=.hg,.git,.svn                    " Version control
		set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
		set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
		set wildignore+=*.sw?                            " Vim swap files
		set wildignore+=*.DS_Store                       " OSX bullshit
		set wildignore+=*.pyc                            " Python byte code
		set wildignore+=*.orig                           " Merge resolution files

		" ============================================= }}}3
		" => [" ====	option: list&wrap	==== {{{3"]
		" =================================================
		" 在 gvim 下不使用折行， 开启水平滚动条，
		" 但在 vim 下，是没有滚动条可用的， 因此还是有必要为 vim 保留自动折行。
		if (has("gui_running")) " 图形界面下的设置
			set nowrap
			set guioptions-=T
			set guioptions+=bh
		else " 字符界面下的设置
			set wrap
		endif

		" 在单词边界上断行
		set linebreak

		set list " Show these tabs and spaces and so on

		if (has("gui_running"))
			" vim终端的字体不能显示下面的字体
			" 只有DejaVuSansMono.ttf 字体支持显示下列字符
			" Font Support for Unicode Block 'Geometric Shapes'
			" http://www.fileformat.info/info/unicode/block/geometric_shapes/fontsupport.htm
			set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

			" show break when the line is wraped.
			set showbreak=↪
		else
			" 输入:set list命令是应该显示些啥
			set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
		endif

		" 使回格键（backspace）正常处理indent, eol, start等
		" set backspace=indent,eol,start
		set backspace=2

		" 允许backspace和光标键跨越行边界
		set whichwrap+=<,>,h,l

		" ============================================= }}}3
		" => [" ====	option: line numbers	==== {{{3"]
		" =================================================
		" 显示行号
		set number " Show line numbers

		" Toggle relativenumber {{{
		function! ToggleRelativenumber()
			if &number==1
				set relativenumber
			else
				set number
			endif
		endfunction
		nnoremap <Leader>n :call ToggleRelativenumber()<CR>
		" }}}

		" ============================================= }}}3
		" => [" ====	option: scroll	==== {{{3"]
		" =================================================
		" 光标移动到buffer的顶部和底部时保持3行距离
		set scrolloff=3

		" 水平滚动时滚动的最少列数
		set sidescroll=5

		" ============================================= }}}3
		" => [" ====	option: select	==== {{{3"]
		" =================================================
		" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
		set mouse=a

		" 从行尾开始反向选择无法包含行尾的字符
		" set selection=exclusive

		" 选择区的最后一个字符包含在操作范围之内（包括换行符）
		set selection=inclusive
		set selectmode=mouse,key

		" 允许可视列块模式的虚拟编辑
		set virtualedit+=block

		" ============================================= }}}3
		" => [" ====	option: Statusline&ruler	==== {{{3"]
		" 状态行
		" =================================================
		" 在状态行上显示光标所在位置的行号和列号
		set ruler
		set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

		" Set status line
		" 总是显示状态行
		set laststatus=2

		function! InitializeStatusLine() " {{{
			" 状态行颜色
			highlight StatusLine guifg=SlateBlue guibg=Yellow ctermfg=White ctermbg=DarkGrey
			highlight StatusLineNC guifg=Gray guibg=White ctermfg=White ctermbg=Gray

			" 状态行显示的内容（包括文件类型和解码）
			" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
			" set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
			" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
			" set statusline=%{VimBuddy()}\ %F%m%r%h%w\ [%{&ff}]\ [%Y]\ [\%03.3b\ \%02.2B]\ [%02v\ %03l\ %L\ %p%%] " need vimbuddy.vim, dislike it? just remove it
			" Modify by QiWei at 2008-10-29
			" set statusline=%<%F\ %m%r%h%w%=[%{(&fenc==\"\")?(\"ENCODING=\".&enc):(\"FILEENCODING=\".&fenc)}%{(&bomb?\",BOM\":\"\")}]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
			set statusline=
			set statusline+=%#StatusLine#%<%F\ %1*%m%*%r%h%w%=
			set statusline+=%1*\ [%{(&fenc==\"\")?(\"enc=\".&enc):(\"fenc=\".&fenc)}%{(&bomb?\",BOM\":\"\")}]
			set statusline+=%3*\ [%{&ff=='unix'?'LF':(&ff=='mac'?'CR':'CR+LF')}]
			set statusline+=%4*%(\ [%Y]%)
			set statusline+=%5*\ [\%02.5b,0x\%02.4B]
			set statusline+=%2*\ [%-2l:%L,%c%V:%{&textwidth}]
			set statusline+=%4*\ [%p%%]
			set statusline+=%3*\ %{exists('*CapsLockSTATUSLINE')?CapsLockSTATUSLINE():''}
			set statusline+=%5*\ %-16{strftime(\"%Y-%m-%d\ %H:%M\")}\ 
			"set statusline+=\ %{VimBuddy()} 
			hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
			hi User1 gui=italic guifg=#112605 guibg=#aefe7B cterm=italic,bold ctermfg=White ctermbg=DarkBlue
			hi User2 gui=italic guifg=#391100 guibg=#d3905c cterm=italic,bold ctermfg=White ctermbg=DarkYellow
			hi User3 gui=italic guifg=#292b00 guibg=#f4f597 cterm=italic,bold ctermfg=White ctermbg=DarkCyan
			hi User4 gui=italic guifg=#051d00 guibg=#7dcc7d cterm=italic,bold ctermfg=White ctermbg=DarkRed
			hi User5 gui=italic guifg=#002600 guibg=#67ab6e cterm=italic,bold ctermfg=White ctermbg=DarkMagenta
		endfunction
		" }}}

		" 改变主题后需要重新设置状态栏颜色
		if exists("*InitializeStatusLine")
			call InitializeStatusLine()
		endif

		" ============================================= }}}3
		" => [" ====	option: title&tab	==== {{{3"]
		" 标题行和标签页行
		" =================================================
		" Set title
		set title
		set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

		" Set tabline
		set showtabline=2 " Always show tab line
		" Set up tab labels
		set guitablabel=%m%N:%t\[%{tabpagewinnr(v:lnum)}\]
		set tabline=%!MyTabLine()
		function! MyTabLine()
			let s=''
			let t=tabpagenr() " The index of current page
			let i=1
			while i<=tabpagenr('$') " From the first page
				let buflist=tabpagebuflist(i)
				let winnr=tabpagewinnr(i)
				let s.=(i==t?'%#TabLineSel#':'%#TabLine#')
				let s.='%'.i.'T'
				let s.=' '
				let bufnr=buflist[winnr - 1]
				let file=bufname(bufnr)
				let m=''
				if getbufvar(bufnr, "&modified")
					let m='[+]'
				endif
				if file=~'\/.'
					let file=substitute(file,'.*\/\ze.','','')
				endif
				if file==''
					let file='[No Name]'
				endif
				let s.=m
				let s.=i.':'
				let s.=file
				let s.='['.winnr.']'
				let s.=' '
				let i=i+1
			endwhile
			let s.='%T%#TabLineFill#%='
			let s.=(tabpagenr('$')>1?'%999XX':'X')
			return s
		  endfunction
		" Set up tab tooltips with every buffer name
		set guitabtooltip=%F

		" ============================================= }}}3


	" ============================================= }}}2
	" => [" ====	option: Search Related	==== {{{2"]
	" 搜索和匹配
	" =================================================
	" 高亮显示匹配的括号
	set showmatch

	" 匹配括号高亮的时间（单位是十分之一秒）
	set matchtime=5

	" 在搜索的时候忽略大小写
	set ignorecase

	" 模式只包含小写字母时才忽略大小写
	set smartcase

	" 高亮被搜索的句子（phrases）
	set hlsearch

	" 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
	set incsearch

	" 插入模式的补全
	set completeopt=longest,menu


	" ============================================= }}}2
	" => [" ====	option: Print Options	==== {{{2"]
	" 打印选项
	" =================================================
	" 定义 |:hardcopy| 输出的页眉格式(缺省为 "%<%f%h%m%=Page %N")
	" set printheader=%<%s%=Page %N
	
	" |:hardcopy| 命令输出使用的字体名。
	set printfont=Consolas:h9
	
	" |:hardcopy| 生成的 CJK 输出使用的字体名。每
	set printmbfont=r:Yahei\ Mono

	" 默认选项
	" :set printoptions=left:5pc,right:5pc,top:5pc,bottom:5pc,header:2,duplex:short

	" 直接打印到打印机使用(有页眉)
	" :set printoptions=left:12.7mm,right:12.7mm,top:12.7mm,bottom:12.7mm,header:2,duplex:off

	" 打印到PDF使用(用PDF加页眉)
	set printoptions=left:12mm,right:12mm,top:12mm,bottom:12mm,header:0,duplex:off

	" 设置打印时使用的字符编码
	" set printencoding=utf-8
	set printencoding=euc-cn
	
	" 设置 |:hardcopy| 产生 CJK 输出时使用的 CJK 字符集。
	" set printmbcharset=ISO10646
	set printmbcharset=GB_2312-80


	" ============================================= }}}2
	" => [" ====	option: Text Formatting/Layout	==== {{{2"]
	" 文本格式和排版
	" =================================================
	" 自动格式化
	" 可以在任何值高于 255 的多字节字符上分行
	" 在连接行时，不要在多字节字符之前或之后插入空格
	set formatoptions+=mM

	" r 在插入模式按回车时，自动插入当前注释前导符。
	" n	在对文本排版时，识别编号的列表。
	" l	插入模式不分行
	set formatoptions+=rnl
	
	" 把所有的“不明宽度”字符——指的是在 Unicode 字符集中某些同时在东西方语言中使
	" 用的字符，如省略号、破折号、书名号和全角引号，在西方文字中通常字符宽度等同
	" 于普通 ASCII 字符，而在东方文字中通常字符宽度等同于两倍的普通 ASCII 字符，
	" 因而其宽度“不明”——的宽度置为双倍字符宽度（中文字符宽度）。此数值只在
	" encoding 设为 utf-8 或某一 Unicode 编码时才有效。需要额外注意的是，如果你
	" 通过终端使用 Vim 的话，需要令终端也将这些字符显示为双宽度。比如，XTERM
	" [12] 的情况下应该使用选项“-cjk”，即使用命令“uxterm -cjk”来启动使用双宽度显
	" 示这些字符的 Unicode X 终端；使用 PuTTY 远程连接的话则应在配置的
	" Window-Translation 中选中“Treat CJK ambiguous characters as wide”
	set ambiwidth=double

	" 自动换行
	set textwidth=80

	" ============================================= }}}2
	" => [" ====	option: Indent and Tab Related	==== {{{2"]
	" 缩进
	" =================================================
	" 继承前一行的缩进方式，特别适用于多行注释
	set autoindent

	" 为C程序提供自动缩进
	set smartindent

	" 使用C样式的缩进
	set cindent

	" 制表符为4
	set tabstop=4

	" 统一缩进为4
	set softtabstop=4

	" 当行之间交错时使用4个空格
	set shiftwidth=4

	" 不要用空格代替制表符
	set noexpandtab

	" 在行和段开始处使用制表符
	set smarttab

	" 缩进取整到 'shiftwidth' 的倍数
	set shiftround

	"为特定的文件类型载入缩进文件 
	filetype indent on


	" ============================================= }}}2
	" => [" ====	option: Fold Related	==== {{{2"]
	" 折叠
	" =================================================
	set foldenable
	" set foldlevelstart=0 " Start with all folds closed
	set foldcolumn=1 " Set fold column

	" NOTE foldmethod can be local, but I prefer global setting
	if &foldmethod == 'manual'
		set foldmethod=marker
	endif

	" set foldmethod=indent
	set foldlevel=1
	set foldopen-=search
	set foldopen-=undo

	" Set foldtext
	function! MyFoldText() " {{{
		let line = getline(v:foldstart)

		let nucolwidth = &fdc + &number * &numberwidth
		let windowwidth = winwidth(0) - nucolwidth - 3
		let foldedlinecount = v:foldend - v:foldstart

		" expand tabs into spaces
		let onetab = strpart('          ', 0, &tabstop)
		let line = substitute(line, '\t', onetab, 'g')

		let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
		let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
		return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
	endfunction " }}}
	set foldtext=MyFoldText()


	" ============================================= }}}2
	" => [" ====	option: Balloon	==== {{{2"]
	" 冒泡式提示
	" =================================================
	" 这个例子基于 Vim 的帮助系统，它的作用是用一小段函数来显示所有可用变量的信息：
	function! SimpleBalloon()
		return 'Cursor is at line/column: ' . v:beval_lnum .
					\'/' . v:beval_col .
					\ ' in file ' .  bufname(v:beval_bufnr) .
					\ '. Word under cursor is: "' . v:beval_text . '"'
	endfunction
	if has('balloon-eval')
		" set balloonexpr=SimpleBalloon()
		" set ballooneval
		" set balloondelay=100
	endif

	" 这是一个更高级的例子，它可以探索特定的编辑区域，这里给出的函数将同时在两种区域显示包含大量信息的气球：

	" 拼写错误的单词：气球给出供替换的单词；
	" 折叠的文字：气球给出此折叠的预览。
	" 为了能检测到错误拼写的单词，要打开“单词拼写”功能：

	" set spell

	function! FoldSpellBalloon() "{{{
		let foldStart = foldclosed(v:beval_lnum )
		let foldEnd   = foldclosedend(v:beval_lnum)
		let lines = []
		" Detect if we are in a fold
		if foldStart < 0
			" Detect if we are on a misspelled word
			let lines = spellsuggest( spellbadword(v:beval_text)[ 0 ], 5, 0 )
		else
			" we are in a fold
			let numLines = foldEnd - foldStart + 1
			" if we have too many lines in fold, show only the first 14
			" and the last 14 lines
			if ( numLines > 31 )
				let lines = getline( foldStart, foldStart + 14 )
				let lines += [ '-- Snipped ' . ( numLines - 30 ) . ' lines --' ]
				let lines += getline( foldEnd - 14, foldEnd )
			else
				"less than 30 lines, lets show all of them
				let lines = getline( foldStart, foldEnd )
			endif
		endif
		" return result
		" return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
		" Balloon with Correct Chinese Characters
		if has('win32')
			if &encoding == "utf-8"
				let utf8 = join( lines, has( "balloon_multiline" ) ? "\n" : " " )
				return iconv(utf8, "utf-8", "cp936")
			else
				return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
			endif
		else
			return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
		endif
	endfunction
	" }}}

	if has('balloon-eval')
		set balloonexpr=FoldSpellBalloon()
		set ballooneval
		set balloondelay=100
	endif
	" ============================================= }}}2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Plugin settings {{{1
" 插件相关配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" => [" ====	Plugin: plugin manager	 ==== {{{2"]
	" =================================================
	if !exists('s:plugin_manager') && filereadable(glob(fnamemodify(s:rtp, ':p') . 'bundle/vim-pathogen/autoload/pathogen.vim'))
		" let s:plugin_manager = "pathogen"
	endif

	if !exists('s:plugin_manager') && filereadable(glob(fnamemodify(s:rtp, ':p') . 'bundle/neobundle.vim/autoload/neobundle.vim'))
		let s:plugin_manager = "neobundle"
	endif

	if !exists('s:plugin_manager') && filereadable(glob(fnamemodify(s:rtp, ':p') . 'bundle/vundle/autoload/vundle.vim'))
		let s:plugin_manager = "vundle"
	endif

	if !exists('s:plugin_manager') && filereadable(glob(fnamemodify(s:rtp, ':p') . 'addons/vim-addon-manager/autoload/vam.vim'))
		let s:plugin_manager = "vam"
	endif

	if !exists('s:plugin_manager')
		let s:plugin_manager = "no"
	endif

	let $GIT_SSL_NO_VERIFY = 'true'

	" ============================================= }}}2
	" => [" ====	Plugin: Pathogen setup	 ==== {{{2"]
	" =================================================
	" Disable Pathogen plugins{{{3
	" To disable a plugin, add it's bundle name to the following list
	let g:pathogen_disabled = []
	call add(g:pathogen_disabled, 'buftabs')
	call add(g:pathogen_disabled, 'command-t')
	if has('win32') || has('win64')
		if has("gui_running")
		else
			call add(g:pathogen_disabled, 'vim-powerline')
		endif
	endif

	"}}}3

	if has('vim_starting')
		" add pathogen for easier bundles management
		if (s:plugin_manager == "pathogen") && len(split(globpath(&rtp, 'autoload/pathogen.vim'), "\n")) == 0
			" set runtimepath+=~/.vim/bundle/vim-pathogen
			execute "set runtimepath+=" . fnamemodify(s:rtp, ':p') . "bundle/vim-pathogen"
		endif
		if exists("pathogen#runtime_append_all_bundles") || filereadable(substitute(globpath(&rtp, 'autoload/pathogen.vim'), "\n", ',', 'g'))
			call pathogen#infect()
			" filetype off
			" runtime! autoload/pathogen.vim 
			" call pathogen#helptags()
			" call pathogen#runtime_append_all_bundles() 
			filetype plugin indent on
		endif
	endif


	" ============================================= }}}2
	" => [" ====	Plugin: neobundle.vim  ==== {{{2"]
	" https://github.com/Shougo/neobundle.vim
	" =================================================
	" git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
	
	if has('vim_starting')
		if (s:plugin_manager == "neobundle") && len(split(globpath(&rtp, 'autoload/neobundle.vim'), "\n")) == 0
			" set runtimepath+=~/.vim/bundle/neobundle/
			execute "set runtimepath+=" . fnamemodify(s:rtp, ':p') . "bundle/neobundle.vim"
		endif
		if len(split(globpath(&rtp, 'autoload/pathogen.vim'), "\n")) == 0 && len(split(globpath(&rtp, 'autoload/neobundle.vim'), "\n")) == 1
			filetype off

			" call neobundle#rc(expand('~/.vim/bundle/')

			try
				call neobundle#rc(fnamemodify(s:rtp, ':p') . "bundle")
			catch /^Vim\%((\a\+)\)\=:E117/
				echoerr "Error detected while processing: " . v:throwpoint . ":\n  " . v:exception .
							\ "\n\nNo 'Bundle plugin' installed for this vimrc. Skipped sourcing plugins." .
							\ "\n\nTo install one:\n  " .
							\ "git clone http://github.com/Shougo/neobundle.vim.git " . fnamemodify(s:rtp, ":p") . "bundle/neobundle.vim\n"
				finish
			endtry

			" Configure bundles:
			if filereadable($HOME . '/.vimrc.bundle')
				source ~/.vimrc.bundle
			endif

			filetype plugin indent on
		endif
	endif


	" ============================================= }}}2
	" => [" ====	Plugin: vim-addon-manager  ==== {{{2"]
	" =================================================
	if has('vim_starting')
		if (s:plugin_manager == "vam") && len(split(globpath(&rtp, 'autoload/vam.vim'), "\n")) == 0
			" set runtimepath+=~/.vim/addons/vim-addon-manager
			execute "set runtimepath+=" . fnamemodify(s:rtp, ':p') . "bundle/vim-addon-manager"
		endif

		if !exists("vam#ActivateAddons") && len(split(globpath(&rtp, 'autoload/vam.vim'), "\n")) == 1
			" filetype off
			" set shellslash&
			" set shellquote=\"
			" Configure addons:
			if filereadable($HOME . '/.vimrc.addon')
				source ~/.vimrc.addon
			endif

			" filetype plugin indent on
		endif
	endif


	" ============================================= }}}2
	" => [" ====	Plugin: vundle  ==== {{{2"]
	" https://github.com/gmarik/vundle
	" =================================================
	" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	if has('vim_starting')
		if (s:plugin_manager == "vundle") && len(split(globpath(&rtp, 'autoload/vundle.vim'), "\n")) == 0
			" set runtimepath+=~/.vim/bundle/vundle/
			execute "set runtimepath+=" . fnamemodify(s:rtp, ':p') . "bundle/vundle"
		endif
		if len(split(globpath(&rtp, 'autoload/pathogen.vim'), "\n")) == 0 && len(split(globpath(&rtp, 'autoload/vundle.vim'), "\n")) == 1
			filetype off
			call vundle#rc()

			" Configure bundles:
			if filereadable($HOME . '/.vimrc.bundle')
				source ~/.vimrc.bundle
			endif

			filetype plugin indent on
		endif
	endif


	" ============================================= }}}2
	" => [" ====	Plugin: Options		==== {{{2"]
	" 针对插件初始化后对选项做一些调整
	" =================================================
	if (has("gui_running"))
		set background=dark
		if len(split(globpath(&rtp, 'colors/jellybeans.vim'), "\n")) > 0
			colo jellybeans
		endif
	else
		" colorscheme metacosm
		" colorscheme manxome
	endif

	if len(split(globpath(&rtp, 'colors/solarized.vim'), "\n")) > 0 && filereadable(substitute(globpath(&rtp, 'colors/solarized.vim'), "\n", ',', 'g'))
		color solarized                 " load a colorscheme
		let g:solarized_termtrans=1
		let g:solarized_termcolors=256
		let g:solarized_contrast="high"
		let g:solarized_visibility="high"
    endif

	" 改变主题后需要重新设置状态栏颜色
	if exists("*InitializeStatusLine")
		call InitializeStatusLine()
	endif
	
	highlight StatusLine guifg=Yellow guibg=SlateBlue term=inverse,bold cterm=inverse,bold ctermfg=Magenta ctermbg=DarkGrey
	highlight StatusLineNC guifg=White guibg=Gray ctermfg=White ctermbg=Gray


	" ============================================= }}}2
	" => [" ====	Plugin: 2html.vim		==== {{{2"]
	" =================================================
	" 设为零则强制关闭行号
	" :let html_number_lines = 0
	" 使用层叠样式表 (CSS1) 来设置属性 (产生相当简洁且合法的 HTML 4 文件)
	let html_use_css = 1


	" ============================================= }}}2
	" => [" ====	Plugin: ACK	==== {{{2"]
	" =================================================
	nnoremap <Leader>a :Ack!<Space>
	if has('unix')
		let g:ackprg='ack-grep -H --nocolor --nogroup --column'
	endif

	" ============================================= }}}2
	" => [" ====	Plugin: authorinfo.vim	==== {{{2"]
	" =================================================
	let g:vimrc_author='QiWei' 
	let g:vimrc_email='qiwei201@gmail.com' 
	let g:vimrc_homepage='' 

	nmap ,qa :AuthorInfoDetect<cr>


	" ============================================= }}}2
	" => [" ====	Plugin: Autoclose	==== {{{2"]
	" =================================================
	nmap <Leader>x <Plug>ToggleAutoCloseMappings


	" ============================================= }}}2
	" => [" ====	Plugin: AutoComplPop	==== {{{2"]
	" Automatically opens popup menu for completions
	" =================================================
	let g:acp_enableAtStartup = 1
	let g:acp_behaviorPerlOmniLength = 0
	" let g:acp_behaviorSnipmateLength = 1


	" ============================================= }}}2
	" => [" ====	Plugin: bash-support.vim	==== {{{2"]
	" Bash Support implements a bash-IDE for Vim/gVim.
	" =================================================
	let g:BASH_AuthorName   = 'Qi Wei'
	let g:BASH_AuthorRef    = 'QW'
	let g:BASH_Email        = 'qiwei.email@gmail.com'
	let g:BASH_Company      = '囍怒哀乐'


	" ============================================= }}}2
	" => [" ====	Plugin: browser.vim	==== {{{2"]
	" a WWW browser plugin for vim
	" =================================================
	" let g:browser_search_engine = 'perldoc'


	" ============================================= }}}2
	" => [" ====	Plugin: buf2html.Vim	==== {{{2"]
	" generate HTML/XHTML+CSS from a Vim buffer
	" =================================================
	" let b2h_use_css = 1 " use CSS instead of HTML tag attributes markup.
	" b2h_use_inlstyle = 1 "  use CSS but only in style="..." attributes
	" b2h_output_xhtml = 1 "  try to output correct XHTML-1.1 instead of HTML.
	" b2h_number_lines = 1 "  toggles output of line-numbering. Defaults to the buffer setting currently in effect.
	" b2h_meta_expires = 1 "  if this is trlet Tlist_File_Fold_Auto_Close=1ue and VIM can find /bin/date on the system,
	"                         use a header meta-http-equiv line to set an expiry (so that browsers
	"                         or maybe proxy servers will request new document after that date).
	" b2h_no_display_credit = 1 "  do NOT write an inconspicuous string at the bottom of the page, like:
	"                              'code syntax highlighting by GVIM, using the "[color scheme name]" theme.'
	"


	" ============================================= }}}2
	" => [" ====	Plugin: c.vim	==== {{{2"]
	" C/C++-IDE for Vim/gVim.
	" =================================================


	" ============================================= }}}2
	" => [" ====	Plugin: Calendar.vim	==== {{{2"]
	" This script create calender window. This don’t use the external program (cal).
	" =================================================
	" 修改日记所在的路径，默认是 ~/diary
	" let g:calendar_diary=<PATH>


	" ============================================= }}}2
	" => [" ====	Plugin: cmdline-complete.vim	==== {{{2"]
	" complete command-line (: / etc.) from the current file
	" =================================================
	" 默认的快捷键是<c-p> or <c-n>，但是当
	" set wildmode=list:longest时不能用<c-p> or <c-n>
	" 调用wildmenu。
	cmap <c-b> <Plug>CmdlineCompleteBackward
	cmap <c-f> <Plug>CmdlineCompleteForward


	" ============================================= }}}2
	" => [" ====	Plugin: crefvim.vim	==== {{{2"]
	" a C-Reference for Vim  
	" =================================================
	" <Leader>cc 和 NERD_commenter V2.3.0起冲突
	" - <Plug>CRV_CRefVimVisual
	" mapping to start search for visually selected text
	" default:
	" vmap <silent> <unique> <Leader>cr <Plug>CRV_CRefVimVisual
	vmap <silent> <unique> ,cr <Plug>CRV_CRefVimVisual

	" - <Plug>CRV_CRefVimNormal
	" mapping to start search for text under cursor
	" default:
	" nmap <silent> <unique> <Leader>cr <Plug>CRV_CRefVimNormal
	nmap <silent> <unique> ,cr <Plug>CRV_CRefVimNormal

	" - <Plug>CRV_CRefVimAsk
	" mapping to ask for word to search for
	" default:
	" map <silent> <unique> <Leader>cw <Plug>CRV_CRefVimAsk
	map <silent> <unique> ,cw <Plug>CRV_CRefVimAsk

	" - <Plug>CRV_CRefVimInvoke
	" mapping to let Vim jump to the contents of the C-reference manual
	" default:
	" map <silent> <unique> <Leader>cc <Plug>CRV_CRefVimInvoke
	map <silent> <unique> ,cc <Plug>CRV_CRefVimInvoke

	" ============================================= }}}2
	" => [" ====	Plugin: Ctrlp	==== {{{2"]
	" =================================================
	let g:ctrlp_working_path_mode=0
	let g:ctrlp_clear_cache_on_exit=0
	let g:ctrlp_cache_dir=$HOME.'/.vim/.cache/ctrlp'
	let g:ctrlp_extensions=['tag', 'buffertag', 'quickfix', 'dir', 'rtscript']

	" ============================================= }}}2
	" => [" ====	Plugin: delimitMate	==== {{{2"]
	" =================================================
	let delimitMate_expand_cr=1
	let delimitMate_expand_space=1
	let delimitMate_balance_matchpairs=1

	" ============================================= }}}2
	" => [" ====	Plugin: DoxygenToolkit.vim	==== {{{2"]
	" Simplify Doxygen documentation in C, C++, Python.
	" =================================================
	let g:DoxygenToolkit_briefTag_pre="@Synopsis\t"
	let g:DoxygenToolkit_paramTag_pre="@Param\t"
	let g:DoxygenToolkit_returnTag="@Returns\t"
	let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
	let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
	let g:DoxygenToolkit_authorName="Qi Wei"
	let g:DoxygenToolkit_licenseTag="My own license"


	" ============================================= }}}2
	" => [" ====	Plugin: EasyTags	==== {{{2"]
	" =================================================
	function! InitializeTagDirectory() " {{{
		let parent=$HOME
		let prefix='.vim'
		let dirname='tags'
		let directory=parent.'/'.prefix.'/'.dirname.'/'
		if !isdirectory(directory)
			if exists('*mkdir')
				call mkdir(directory)
				let g:easytags_by_filetype=directory
			else
				echo "Warning: Unable to create directory: ".directory
				echo "Try: mkdir -p ".directory
			endif
		else
			let g:easytags_by_filetype=directory
		endif
	endfunction
	" }}}
	if exists('*InitializeTagDirectory')
		call InitializeTagDirectory()
	endif
	let g:easytags_python_enabled=1
	let g:easytags_python_script=1
	let g:easytags_include_members=1
	highlight cMember gui=italic

	" ============================================= }}}2
	" => [" ====	Plugin: EnhCommentify.vim	==== {{{2"]
	" comment lines in a program
	" =================================================
	" let g:EnhCommentifyIdentString = ' '
	let g:EnhCommentifyRespectIndent = 'Yes'
	let g:EnhCommentifyPretty = 'Yes'

	function EnhCommentifyCallback(ft)
		if a:ft == 'nsis'
			let b:ECcommentOpen = ';'
			let b:ECcommentClose = ''
		endif
	endfunction
    let g:EnhCommentifyCallbackExists = 'Yes'


	" ============================================= }}}2
	" => [" ====	Plugin: fencview.vim	==== {{{2"]
	" =================================================
	" Dont auto detect file encoding when you open a file.(default: 1)
	let g:fencview_autodetect = 0


	" ============================================= }}}2
	" => [" ====	Plugin: File Explorer	==== {{{2"]
	" =================================================
	let g:explVertical=1 " should I split verticially
	let g:explWinSize=35 " width of 35 pixels


	" ============================================= }}}2
	" => [" ====	Plugin: Fugitive	==== {{{2"]
	" https://github.com/tpope/vim-fugitive
	" =================================================
	nnoremap <Leader>gs :Gstatus<CR>
	nnoremap <Leader>gr :Gremove<CR>
	nnoremap <Leader>gl :Glog<CR>
	nnoremap <Leader>gb :Gblame<CR>
	nnoremap <Leader>gm :Gmove 
	nnoremap <Leader>gp :Ggrep 
	nnoremap <Leader>gR :Gread<CR>
	nnoremap <Leader>gg :Git 
	nnoremap <Leader>gd :Gdiff<CR>


	" ============================================= }}}2
	" => [" ====	Plugin: Golden Ratio	==== {{{2"]
	" =================================================
	" Disable Golden Ratio plugin when in diff mode
	if &diff
	  let g:loaded_golden_ratio=1
	endif

	" ============================================= }}}2
	" => [" ====	Plugin: Grep	==== {{{2"]
	" Grep的设定(针对grep.vim的设定)
	" =================================================
	let Grep_Path = $GNU . '\grep.exe'
	let Fgrep_Path = $GNU . '\fgrep.exe'
	let Egrep_Path = $GNU . '\egrep.exe'
	let Agrep_Path = $GNU . '\agrep.exe'
	let Grep_Find_Path = $GNU . '\find.exe'
	let Grep_Xargs_Path = $GNU . '\xargs.exe'

	" :let Grep_Default_Filelist = '*.c *.cpp *.asm'

	" The 'Grep_Default_Options' is used to pass default command line options to
	" the grep/fgrep/egrep/agrep utilities. By default, this is set to an empty string.
	" :let Grep_Default_Options = '-i'

	" The 'Grep_Skip_Dirs' variable specifies the list of directories to skip
	" while doing recursive searches. By default, this is set to 'RCS CVS SCCS'.
	" :let Grep_Skip_Dirs = 'dir1 dir2 dir3'

	" The 'Grep_Skip_Files' variable specifies the list of files to skip while
	" doing recursive searches. By default, this is set to '*~ *,v s.*'.
	" :let Grep_Skip_Files = '*.bak *~'


	" ============================================= }}}2
	" => [" ====	Plugin: Gundo	==== {{{2"]
	" =================================================
	nnoremap <Leader>u :GundoToggle<CR>

	" ============================================= }}}2
	" => [" ====	Plugin: HTML.vim	==== {{{2"]
	" =================================================
	let g:do_xhtml_mappings = 'yes'
	let g:html_tag_case = 'lowercase'
	" let g:html_tag_case_autodetect = 'yes'
	" let g:html_map_leader = g:maplocalleader
	" let g:html_map_entity_leader = '\'
	" let g:no_html_map_override = 'yes'
	" let g:no_html_maps = '^\(;ah\|;im\|;H\d\)$'
	let g:no_html_tab_mapping = 'yes'
	let g:no_html_toolbar = 'yes'
	" let g:no_html_menu = 'yes'
	" let g:force_html_menu = 'yes'
	let g:html_template = $HOME . '\xhtml_template.html'
	let g:html_authorname  = 'QiWei'
	let g:html_authoremail = 'qiwei201@gmail.com'
	" let g:html_bgcolor     = '#FFFFFF'
	" let g:html_textcolor   = '#000000'
	" let g:html_linkcolor   = '#0000EE'
	" let g:html_alinkcolor  = '#FF0000'
	" let g:html_vlinkcolor  = '#990066' 
	let g:html_default_charset = 'UTF-8'	
	" let g:html_charset = 'UTF-8'	


	" ============================================= }}}2
	" => [" ====	Plugin: Indent Guides	==== {{{2"]
	" =================================================
	if !has('gui_running')
		let g:indent_guides_auto_colors=0
		autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=237
		autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239
	endif

	let g:indent_guides_enable_on_vim_startup=1
	let g:indent_guides_guide_size=1

	" ============================================= }}}2
	" => [" ====	Plugin: Intellisense	==== {{{2"]
	" =================================================
	" Set the delay for the online help. This value is delay in milliseconds.
	" let b:dochelpdelay=2000

	" Sets the colors(front,back). This is global. Not file-type specific.
	" :call SetDlgColor(string,string)

	" Typing the non-alpha and non-numeric keys closes the list window, by default.
	" If you specify a set of keys here, then pressing these keys will not close the window. This is file-type specific.
	" let b:ignorekeys=":/_"

	" Sets the demiliter key.
	" let b:demiliterkey="("

	" The tooltip window closes if you press ')'.
	" let b:tooltipclosekey=")"

	" This sets the ignore case setting for listwindow.
	" let b:ignorecase=3 " Retain the orinigal case in the list, but ignore case while typing.
	" let b:ignorecase=2 " Make the list Lower case, but ignore case while typing.
	" 这里的设置对于html文件不起作用，在ftplugin/html_vis.vim中设置生效。修改于:12/11/08 14:39:46
	" let b:ignorecase=1 " Make the list Upper case, but ignore case while typing.

	" This sets the size of the helpwindow.
	" let b:helpwindowsize = 0x0 " Default size
	" let b:helpwindowsize = 120x240

	" Setting up for Java
	if !exists($JAVA_HOME)
		let $JAVA_HOME = '\PortableApps\CommonFiles\jdk1.5.0'
	endif
	if has('win32')
		let g:intellisense_root_dir = expand('$VIM/Intellisense')
		if isdirectory(expand($JAVA_HOME))
			let g:intellisense_jvm_dir  = expand('$JAVA_HOME\jre\bin\server')
			let g:intellisense_javaapi_dir  = expand('$JAVA_HOME\docs\api')
		endif
	endif


	" ============================================= }}}2
	" => [" ====	Plugin: javacomplete.vim - Omni Completion for JAVA	==== {{{2"]
	" =================================================
	" Set 'omnifunc' option. e.g.
	" setlocal omnifunc=javacomplete#Complete
	" Or, use autocmd:
	" :if has("autocmd")
	" :  autocmd Filetype java setlocal omnifunc=javacomplete#Complete
	" :endif
	" Set 'completefunc' option to show parameters information IF YOU LIKE. e.g.
	" :setlocal completefunc=javacomplete#CompleteParamsInfo
	" :inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
	" :inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>


	" ============================================= }}}2
	" => [" ====	Plugin: LaTeX Suite things	==== {{{2"]
	" =================================================
	set grepprg=grep\ -nH\ $*
	let g:Tex_DefaultTargetFormat="pdf"
	let g:Tex_ViewRule_pdf='xpdf'

	" Bindings
	autocmd FileType tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

	" Auto complete some things ;)
	autocmd FileType tex inoremap $i \indent
	autocmd FileType tex inoremap $* \cdot
	autocmd FileType tex inoremap $i \item
	autocmd FileType tex inoremap $m \[<cr>\]<esc>O


	" ============================================= }}}2
	" => [" ====	Plugin: Matchit.vim	==== {{{2"]
	" (global plugin) Extended "%" matching
	" =================================================
	let b:match_ignorecase = 1


	" ============================================= }}}2
	" => [" ====	Plugin: Markdown	==== {{{2"]
	" =================================================
	augroup ft_markdown
		au!

		au BufNewFile,BufRead *.m*down setlocal filetype=markdown

		" Use <localleader>1/2/3 to add headings.
		au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
		au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
		au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
	augroup END


	" ============================================= }}}2
	" => [" ====	Plugin: Minibuffer	==== {{{2"]
	" Mini Buffer Explorer Vim Plugin
	" =================================================
	let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
	let g:miniBufExplModSelTarget = 1

	" minibufexpl插件的一般设置
	" To disable the optional mapping of Control + Vim Direction Keys [hjkl] to window movement commands
	let g:miniBufExplMapWindowNavVim = 0
	let g:miniBufExplMapWindowNavArrows = 1
	let g:miniBufExplMapCTabSwitchBufs = 1
	let g:miniBufExplModSelTarget = 1

	" This stops the -MiniBufExplorer- from opening automatically until more than one eligible buffer is available.
	let g:miniBufExplorerMoreThanOne=10


	" ============================================= }}}2
	" => [" ====	Plugin: NeoComplCache	==== {{{2"]
	" Ultimate auto completion system for Vim 
	" =================================================
	function! InitializeNeoComplCache() "{{{
		" Disable AutoComplPop.
		let g:acp_enableAtStartup = 0
		" Use neocomplcache.
		let g:neocomplcache_enable_at_startup = 1
		" Use smartcase.
		let g:neocomplcache_enable_smart_case = 1
		" Use camel case completion.
		let g:neocomplcache_enable_camel_case_completion = 1
		" Use underbar completion.
		let g:neocomplcache_enable_underbar_completion = 1
		" Set minimum syntax keyword length.
		let g:neocomplcache_min_syntax_length = 3
		let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
		
		" Define dictionary.
		let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
				\ }
		
		" Define keyword.
		if !exists('g:neocomplcache_keyword_patterns')
			let g:neocomplcache_keyword_patterns = {}
		endif
		let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
		
		" Plugin key-mappings.
		inoremap <expr><C-g>     neocomplcache#undo_completion()
		inoremap <expr><C-l>     neocomplcache#complete_common_string()
		
		" Recommended key-mappings.
		" <CR>: close popup and save indent.
		inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
		" <TAB>: completion.
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		" <C-h>, <BS>: close popup and delete backword char.
		inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
		inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
		inoremap <expr><C-y>  neocomplcache#close_popup()
		inoremap <expr><C-e>  neocomplcache#cancel_popup()
		
		" For cursor moving in insert mode(Not recommended)
		"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
		"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
		"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
		"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
		" Or set this.
		"let g:neocomplcache_enable_cursor_hold_i = 1
		
		" AutoComplPop like behavior.
		"let g:neocomplcache_enable_auto_select = 1
		
		" Shell like behavior(not recommended).
		"set completeopt+=longest
		"let g:neocomplcache_enable_auto_select = 1
		"let g:neocomplcache_disable_auto_complete = 1
		"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
		"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
		
		" Enable omni completion.
		autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
		autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
		autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
		autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
		autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
		
		" Enable heavy omni completion.
		if !exists('g:neocomplcache_omni_patterns')
			let g:neocomplcache_omni_patterns = {}
		endif
		let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
		"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
		let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
		let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
		let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
	endfunction
	"}}}
	
	if len(split(globpath(&rtp, 'plugin/neocomplcache.vim'), "\n")) > 0
		call InitializeNeoComplCache()
	endif

	" Toggle NeoComplCache auto complete
	nmap ,qn :let g:neocomplcache_disable_auto_complete = ((g:neocomplcache_disable_auto_complete == 0) ? 1 : 0)<cr>

	function! Bundle_NeoComplCache() " {{{
		" let g:neocomplcache_enable_auto_select = 1
		let g:neocomplcache_disable_auto_complete = 0
		call InitializeNeoComplCache()
		if exists(":NeoBundle")
			execute "NeoBundle 'Shougo/neocomplcache'"
		else
			" execute "Bundle 'Shougo/neocomplcache'"
			Bundle 'neocomplcache'
		endif
		runtime plugin/neocomplcache.vim
		" runtime autoload/neocomplcache.vim
		" runtime autoload/vital.vim
		NeoComplCacheEnable

		" 暂停 AutoComplPop 插件
		AcpLock

		" 由于NeoComplCache在手工模式下使用快捷键组合<C-X><C-U>打开补全列表，故
		" 设置SuperTab的默认补全操作为<C-X><C-U>
		let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
	endfunction
	" }}}

	nmap ,ln :call Bundle_NeoComplCache()<cr>

	" ============================================= }}}2
	" => [" ====	Plugin: NERD_commenter	==== {{{2"]
	" vim global plugin that provides easy code commenting 
	" =================================================
	let NERDCommentWholeLinesInVMode=2
	let NERDSpaceDelims=1
	let NERDRemoveExtraSpaces=1

	" ============================================= }}}2
	" => [" ====	Plugin: NERD_tree	==== {{{2"]
	" vim global plugin that provides a nice tree explorer
	" =================================================
	nmap <leader>nt :NERDTreeToggle<CR>:NERDTreeMirror<CR>
	nmap <leader>nf :NERDTreeFind<CR>

	let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
	
	" setting root dir in NT also sets VIM's cd
	let NERDTreeChDirMode=2
	
	" the Nerdtree window will be close after a file is opend.
	let NERDTreeQuitOnOpen=1

	let NERDTreeKeepTreeInNewTab=1

	let NERDTreeShowBookmarks=1
	let NERDTreeShowHidden=1
	let NERDTreeShowLineNumbers=1
	let NERDTreeDirArrows=1


	" ============================================= }}}2
	" => [" ====	Plugin: Perl	==== {{{2"]
	" =================================================
	let perl_extended_vars=1 " highlight advanced perl vars inside strings


	" ============================================= }}}2
	" => [" ====	Plugin: perl-support.vim	==== {{{2"]
	" Perl Support implements a Perl-IDE for Vim/gVim. 
	" =================================================


	" ============================================= }}}2
	" => [" ====	Plugin: Powerline	 ==== {{{2"]
	" The ultimate statusline utility
	" =================================================
	" Use vim-powerline to modify the statuls line
	if has('gui_running') && (!has('win64') || !has('win32'))
		let g:Powerline_symbols='unicode'
		" let g:Powerline_symbols = 'compatible'
		let g:Powerline_symbols = 'fancy'
	endif
	
	if exists("*Pl#Theme#InsertSegment")
		" Insert the charcode segment after the filetype segment
		call Pl#Theme#InsertSegment('charcode', 'after', 'filetype')
	endif


	" ============================================= }}}2
	" => [" ====	Plugin: Rainbox Parentheses	==== {{{2"]
	" =================================================
	let g:rbpt_colorpairs = [
		\ ['brown',       'RoyalBlue3'],
		\ ['Darkblue',    'SeaGreen3'],
		\ ['darkgray',    'DarkOrchid3'],
		\ ['darkgreen',   'firebrick3'],
		\ ['darkcyan',    'RoyalBlue3'],
		\ ['darkred',     'SeaGreen3'],
		\ ['darkmagenta', 'DarkOrchid3'],
		\ ['brown',       'firebrick3'],
		\ ['gray',        'RoyalBlue3'],
		\ ['black',       'SeaGreen3'],
		\ ['darkmagenta', 'DarkOrchid3'],
		\ ['Darkblue',    'firebrick3'],
		\ ['darkgreen',   'RoyalBlue3'],
		\ ['darkcyan',    'SeaGreen3'],
		\ ['darkred',     'DarkOrchid3'],
		\ ['red',         'firebrick3'],
		\ ]
	let g:rbpt_max = 16
	" call :RainbowParenthesesToggle()
	" nmap <leader>r  :RainbowParenthesesToggle<cr>
	nnoremap <leader>R :RainbowParenthesesToggle<cr>
	if exists('RainbowParenthesesToggle')
		au VimEnter * RainbowParenthesesToggle
		" au Syntax * RainbowParenthesesLoadRound
		au Syntax * RainbowParenthesesLoadSquare
		au Syntax * RainbowParenthesesLoadBraces
	endif

	" ============================================= }}}2
	" => [" ====	Plugin: shell.vim	==== {{{2"]
	"Improved integration between Vim and its environment (fullscreen, open URL, etc)
	" =================================================
	inoremap <Leader>fs <C-o>:Fullscreen<CR>
	nnoremap <Leader>fs :Fullscreen<CR>
	inoremap <Leader>op <C-o>:Open<CR>
	nnoremap <Leader>op :Open<CR>


	" ============================================= }}}2
	" => [" ====	Plugin: SingleCompile	==== {{{2"]
	" Make it more convenient to compile or run a single source file.
	" =================================================
	nmap <F9> :SCCompile<cr> 
	nmap <F10> :SCCompileRun<cr>
	if exists("*SingleCompile#SetCompilerTemplate")
		call SingleCompile#SetCompilerTemplate('nsis', 'makensis',
					\'MakeNSIS', 'makensis', '', '')
		"call SingleCompile#SetOutfile('filetype', 'compiler', 'out_file')
		call SingleCompile#SetCompilerTemplate('nsis', 'makensisw',
					\'MakeNSISW', 'makensisw', '', '')
		call SingleCompile#ChooseCompiler('nsis', 'makensis')
	endif


	" ============================================= }}}2
	" => [" ====	Plugin: Sketch.vim	==== {{{2"]
	" Line drawing/painting using the mouse. Based on an idea by Morris.
	" =================================================
	command -nargs=0 ToggleSketch call ToggleSketch()


	" ============================================= }}}2
	" => [" ====	Plugin: SnippetsEmu.vim	==== {{{2"]
	" An attempt to implement TextMate style Snippets.
	" =================================================
	" Remapping the default jump key ~
	let g:snippetsEmu_key = ",ss"


	" ============================================= }}}2
	" => [" ====	Plugin: snipMate	==== {{{2"]
	" snipMate.vim implements some of TextMate's snippets features in Vim.
	" =================================================
	" Remapping the default jump key ~
	let g:snips_trigger_key=',,s'
	let g:snips_trigger_key_backwards=',,s'

	let g:snips_author = 'Qi Wei'


	" ============================================= }}}2
	" => [" ====	Plugin: Splitjoin	==== {{{2"]
	" =================================================
	nnoremap sj :SplitjoinSplit<CR>
	nnoremap sk :SplitjoinJoin<CR>
	let g:splitjoin_normalize_whitespace=1
	let g:splitjoin_align=1

	" ============================================= }}}2
	" => [" ====	Plugin: supertab.vim	==== {{{2"]
	" Supertab is a plugin which allows you to perform all your insert completion using the tab key.
	" =================================================
	if len(split(globpath(&rtp, 'plugin/neocomplcache.vim'), "\n")) > 0
		" 由于NeoComplCache在手工模式下使用快捷键组合<C-X><C-U>打开补全列表，故
		" 设置SuperTab的默认补全操作为<C-X><C-U>
		" setting the default completion to 'user' completion:
		let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
	endif
	
	" 回车键和NeoComplCache的键映射冲突
	let g:SuperTabCrMapping = 0

	let g:SuperTabLongestHighlight = 1


	" ============================================= }}}2
	" => [" ====	Plugin: Syntastic	==== {{{2"]
	" =================================================
	nnoremap <Leader>s :Errors<CR>
	let g:syntastic_check_on_open=1
	let g:syntastic_auto_jump=1
	let g:syntastic_stl_format='[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

	" ============================================= }}}2
	" => [" ====	Plugin: Tag List(CTags)	==== {{{2"]
	" CTags的设定(针对Tag List的设定)
	" =================================================
	" CTags的路径
	" let Tlist_Ctags_Cmd = $VIM.'\ctags.exe' " Location of ctags
	" let Tlist_Ctags_Cmd = $VIMRUNTIME.'\ctags.exe' " Location of ctags
	" let Tlist_Ctags_Cmd = 'ctags.exe' " Location of ctags

	" 按照名称排序
	let Tlist_Sort_Type = "name" " order by

	" 在右侧显示窗口
	let Tlist_Use_Right_Window = 1 " split to the right side of the screen

	" 压缩方式
	let Tlist_Compart_Format = 1 " show small meny

	" 如果只有一个buffer，kill窗口也kill掉buffer
	let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself

	" 不要关闭其他文件的tags
	let Tlist_File_Fold_Auto_Close = 0 " Do not close tags for other files

	" 不要显示折叠树(当前不被编辑的文件的方法列表不自动折叠起来)
	let Tlist_Enable_Fold_Column = 0 " Do not show folding tree

	" 在菜单中显示
	" let Tlist_Show_Menu = 1

	" 为批处理文件添加支持
	let tlist_dosbatch_settings = 'dosbatch;l:labels;v:variable'


	" ============================================= }}}2
	" => [" ====	Plugin: Tagbar	==== {{{2"]
	" http://adamyoung.net/Exuberant-Ctags-OS-X
	" http://www.vim.org/scripts/script.php?script_id=273
	" =================================================
	" let g:tagbar_ctags_bin='/usr/local/bin/ctags'
	let g:tagbar_width=26
	noremap <silent> <Leader>y :TagbarToggle<CR>
	" nnoremap <Leader>t :TagbarToggle<CR>
	let g:tagbar_autofocus=1
	let g:tagbar_expand=1
	let g:tagbar_foldlevel=2
	let g:tagbar_ironchars=['▾', '▸']
	let g:tagbar_autoshowtag=1

	" ============================================= }}}2
	" => [" ====	Plugin: taglist-plus.vim	==== {{{2"]
	" =================================================
	" jsctags的路径
	" let Tlist_javascript_Ctags_Cmd = "node " . $COMMONFILES . "\\bin\\jsctags\\bin\\jsctags"
	" let Tlist_javascript_Ctags_Cmd = 'd:\src\node-v0.4.10\node.exe d:\src\doctorjs\bin\jsctags.js'


	" ============================================= }}}2
	" => [" ====	Plugin: Tags Menu(CTags)	==== {{{2"]
	" CTags的设定(针对tagmenu.vim的设定)
	" =================================================
	" CTags的路径
	let Tmenu_ctags_cmd = $GNU . '\ctags.exe' " Location of ctags
	" let Tmenu_max_submenu_items = 20 " The default limit is 25.
	" let Tmenu_max_tag_length = 10
	" let Tmenu_sort_type = "name"


	" ============================================= }}}2
	" => [" ====	Plugin: Tidy.vim	==== {{{2"]
	" tidy compiler script : compiler script for tidy
	" =================================================
	autocmd FileType xml,html,xhtml map <F11> :call HTMLind()<CR>

	function HTMLind()
		"save file
		w!
		"close error window
		cclose
		"load compiler
		comp! tidy
		"store file name for later use
		let fn = expand("%")
		"remove errors.err
		silent !rm -f errors.err
		"call tidy
		let com ="silent !tidy.exe -i -q --indent-spaces 4 -asxhtml -utf8 -w 0"
		let com = com . " -output " . fn . "_temp " . fn . " 2> errors.err"
		execute com	
		"if no error save the file
		"else load errors.err
		if (getfsize("errors.err") != 0)
			"write file name into errors.err_
			let com = "silent !echo " . fn . " > errors.err_"
			execute com
			silent !cat errors.err | sed "s/\r//g" >> errors.err_
			copen 20
			cf errors.err_
			silent !rm -f errors.err_
		else
			let com = "silent !mv " . fn . "_temp " . fn 
			execute com
			let com = "e " . fn
			execute com
			try
				%s/\%(^\s*\)\@<=\%x20\{4}/\t/g
			catch
			endtry
			w!
		endif
		silent !rm errors.err
	endfunction                   


	" ============================================= }}}2
	" => [" ====	Plugin: txtbrowser.vim	==== {{{2"]
	" =================================================
	let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
	au BufRead,BufNewFile *.txt setlocal ft=txt


	" ============================================= }}}2
	" => [" ====	Plugin: twitvim.vim	==== {{{2"]
	" =================================================
	" let twitvim_enable_perl = 1
	let twitvim_enable_python = 1
	" let twitvim_enable_ruby = 1
	" let twitvim_enable_tcl = 1
	" let twitvim_proxy = "127.0.0.1:8000"
	" let twitvim_proxy_login = "proxyuser:proxypassword"
	" let twitvim_browser_cmd = 'firefox.exe'
	let twitvim_token_file = $HOME . "/.twitvim.token"
	" let twitvim_disable_token_file = 1
	let twitvim_login = "qiwei201:38784616"
	" let twitvim_api_root = "http://identi.ca/api"
	let twitvim_api_root = "https://api.twitter.com/1"
	" let twitvim_api_root = "https://identi.ca/api"


	" ============================================= }}}2
	" => [" ====	Plugin: UltiSnips	==== {{{2"]
	" The ultimate snippet solution for python enabled Vim. 
	" =================================================
	" g:UltiSnipsExpandTrigger               <tab>
	" g:UltiSnipsListSnippets                <c-tab>
	" g:UltiSnipsJumpForwardTrigger          <c-j>
	" g:UltiSnipsJumpBackwardTrigger         <c-k>
	" let g:UltiSnipsExpandTrigger="<tab>"
	" let g:UltiSnipsJumpForwardTrigger="<tab>"
	" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	let g:UltiSnipsExpandTrigger=",su"
	let g:UltiSnipsJumpForwardTrigger=",uf"
	let g:UltiSnipsJumpBackwardTrigger=",ub"


	" ============================================= }}}2
	" => [" ====	Plugin: Unit	==== {{{2"]
	" =================================================
	" nnoremap <Leader>m :Unite<Space>

	" ============================================= }}}2
	" => [" ====	Plugin: Viki - A Pseudo Local Wiki Tool	==== {{{2"]
	" =================================================
	map vi :!deplate -m zh-cn-autospace -t bright.html -css bright -m code-highlight -X %
	let g:vikiNameSuffix=".viki"
	augr viki
		au!
		autocmd! BufRead,BufNewFile *.viki set filetype=viki
	augr END


	" ============================================= }}}2
	" => [" ====	Plugin: VimIM	==== {{{2"]
	" =================================================
	" let g:vimim_map = 'ctrl_6,ctrl_bslash,search,gi'
	let g:vimim_plugin = $HOME . '/.vimim'
	let g:gmails = {}
	let g:gmails.passwd = '61648783hnfwhbyp'
	let g:gmails.login  = "qiwei201@gmail.com"
	let g:gmails.to     = "QiWei.Email@gmail.com"
	map ZM :call g:vimim_gmail()<CR>


	" ============================================= }}}2
	" => [" ====	Plugin: vimpress	==== {{{2"]
	" (global plugin) Extended "%" matching
	" =================================================
	if filereadable($HOME.'/vimrepressrc')
		source $HOME/vimrepressrc
	endif 


	" ============================================= }}}2
	" => [" ====	Plugin: vimux	==== {{{2"]
	" =================================================
	" Run the current file with rspec
	nnoremap <Leader>xb :call RunVimTmuxCommand("clear; rspec " . bufname("%"))<CR>

	" Run command without sending sending a return
	nnoremap <Leader>xq :call RunVimTmuxCommand("clear; rspec " . bufname("%"), 0)<CR>

	" Prompt for a command to run
	nnoremap <Leader>xp :PromptVimTmuxCommand<CR>

	" Run last command executed by RunVimTmuxCommand
	nnoremap <Leader>xl :RunLastVimTmuxCommand<CR>

	" Inspect runner pane
	nnoremap <Leader>xi :InspectVimTmuxRunner<CR>

	" Close all other tmux panes in current window
	nnoremap <Leader>xx :CloseVimTmuxPanes<CR>

	" Interrupt any command running in the runner pane
	nnoremap <Leader>xs :InterruptVimTmuxRunner<CR>

	" ============================================= }}}2
	" => [" ====	Plugin: Win Manager	==== {{{2"]
	" =================================================
	let g:winManagerWidth=35 " How wide should it be( pixels)
	let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer' " What windows should it
	" 默认情况下, winmanager 依赖于 bufexplorer如果你不喜欢 bufexplorer 插件的话禁用它
	" let g:winManagerWindowLayout = "FileExplorer"


	" ============================================= }}}2
	" => [" ====	Plugin: XPTemplate	==== {{{2"]
	" XPTemplate is a snippet rendering engine.
	" =================================================
	" 为了不和VimIM的快捷键(<c-\)冲突
	let g:xptemplate_key = ',sx'


	" ============================================= }}}2
	" => [" ====	Plugin: Zencoding	==== {{{2"]
	" =================================================
	let g:user_zen_settings = {
	\  'php' : {
	\    'extends' : 'html',
	\    'filters' : 'c',
	\  },
	\  'xml' : {
	\    'extends' : 'html',
	\  },
	\  'haml' : {
	\    'extends' : 'html',
	\  },
	\}
	let g:user_zen_leader_key = '<c-z>'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Filetype Specific {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" => [" ====	Filetype: QuickFix	==== {{{2"]
	" =================================================
	augroup ft_quickfix
		autocmd!
		autocmd Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap textwidth=0
	augroup END

	" ============================================= }}}2
	" => [" ====	Filetype: Markdown	==== {{{2"]
	" =================================================
	augroup ft_markdown
		autocmd!
		" Use <localLeader>1/2/3/4/5/6 to add headings
		autocmd Filetype markdown nnoremap <buffer> <localLeader>1 I# <ESC>
		autocmd Filetype markdown nnoremap <buffer> <localLeader>2 I## <ESC>
		autocmd Filetype markdown nnoremap <buffer> <localLeader>3 I### <ESC>
		autocmd Filetype markdown nnoremap <buffer> <localLeader>4 I#### <ESC>
		autocmd Filetype markdown nnoremap <buffer> <localLeader>5 I##### <ESC>
		autocmd Filetype markdown nnoremap <buffer> <localLeader>6 I###### <ESC>
		" Use <LocalLeader>b to add blockquotes in normal and visual mode
		autocmd Filetype markdown nnoremap <buffer> <localLeader>b I> <ESC>
		autocmd Filetype markdown vnoremap <buffer> <localLeader>b :s/^/> /<CR>
		" Use <localLeader>ul and <localLeader>ol to add list symbols in visual mode
		autocmd Filetype markdown vnoremap <buffer> <localLeader>ul :s/^/* /<CR>
		autocmd Filetype markdown vnoremap <buffer> <LocalLeader>ol :s/^/\=(line(".")-line("'<")+1).'. '/<CR>
		" Use <localLeader>e1/2/3 to add emphasis symbols
		autocmd Filetype markdown nnoremap <buffer> <localLeader>e1 I*<ESC>A*<ESC>
		autocmd Filetype markdown nnoremap <buffer> <localLeader>e2 I**<ESC>A**<ESC>
		autocmd Filetype markdown nnoremap <buffer> <localLeader>e3 I***<ESC>A***<ESC>
		" Use <Leader>P to preview markdown file in browser
		autocmd Filetype markdown nnoremap <buffer> <Leader>P :MarkdownPreview<CR>
	augroup END

	" ============================================= }}}2
	" => [" ====	Filetype: Todo	==== {{{2"]
	" =================================================
	au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim

	" ============================================= }}}2
	" => [" ====	Filetype: C/C++	==== {{{2"]
	" ================================================="
	" 让Vim(gvim)支持C++STL库的自动补全
	" ! ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ cpp_src
	set tags+=$HOME\stl_tags
	autocmd FileType c map <buffer> <leader><space> :w<cr>:!gcc %<cr>


	" ============================================= }}}2
	" => [" ====	Filetype: Cheetah section	==== {{{2"]
	" =================================================
	autocmd FileType cheetah set ft=xml
	autocmd FileType cheetah set syntax=cheetah

	" ============================================= }}}2
	" => [" ====	Filetype: CSS	==== {{{2"]
	" =================================================
	" cindent和css文件indent冲突
	autocmd FileType css,html setlocal nocindent


	"" ============================================= }}}2
	" => [" ====	Filetype: HTML related	==== {{{2"]
	" =================================================
	" HTML entities - used by xml edit plugin
	let xml_use_xhtml = 1
	" let xml_no_auto_nesting = 1

	" To HTML
	let html_use_css = 1
	let html_number_lines = 0
	let use_xhtml = 1

	"au FileType html,cheetah set ft=xml
	"au FileType html,cheetah set syntax=html


	" ============================================= }}}2
	" => [" ====	Filetype: Java section	==== {{{2"]
	" ================================================="
	au FileType java inoremap <buffer> <C-t> System.out.println();<esc>hi

	" Java comments
	" autocmd FileType java source ~/vim_local/macros/jcommenter.vim
	" autocmd FileType java let b:jcommenter_class_author='Amir Salihefendic (amix@amix.dk)'
	" autocmd FileType java let b:jcommenter_file_author='Amir Salihefendic (amix@amix.dk)'
	" autocmd FileType java map <buffer> <F2> :call JCommentWriter()<cr>

	" Abbr'z
	autocmd FileType java inoremap <buffer> $pr private
	autocmd FileType java inoremap <buffer> $r return
	autocmd FileType java inoremap <buffer> $pu public
	autocmd FileType java inoremap <buffer> $i import
	autocmd FileType java inoremap <buffer> $b boolean
	autocmd FileType java inoremap <buffer> $v void
	autocmd FileType java inoremap <buffer> $s String

	" Folding
	function! JavaFold()
		setl foldmethod=syntax
		setl foldlevelstart=1
		syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
		syn match foldImports /\(\n\?import.\+;\n\)\+/ transparent fold

		function! FoldText()
		return substitute(getline(v:foldstart), '{.*', '{...}', '')
		endfunction
		setl foldtext=FoldText()
	endfunction
	au FileType java call JavaFold()
	au FileType java setl fen

	au BufEnter *.sablecc,*.scc set ft=sablecc

	" ============================================= }}}2
	" => [" ====	Filetype: JavaScript section	==== {{{2"]
	" ================================================="
	"au FileType javascript so ~/vim_local/syntax/javascript.vim
	function! JavaScriptFold()
		setl foldmethod=syntax
		setl foldlevelstart=1
		syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

		function! FoldText()
		return substitute(getline(v:foldstart), '{.*', '{...}', '')
		endfunction
		setl foldtext=FoldText()
	endfunction
	au FileType javascript call JavaScriptFold()
	"au FileType javascript setl fen

	au FileType javascript imap <c-t> console.log();<esc>hi
	au FileType javascript imap <c-a> alert();<esc>hi
	"au FileType javascript setl nocindent
	au FileType javascript inoremap <buffer> $r return

	au FileType javascript inoremap <buffer> $d //<cr>//<cr>//<esc>ka<space>
	au FileType javascript inoremap <buffer> $c /**<cr><space><cr>**/<esc>ka


	" ============================================= }}}2
	" => [" ====	Filetype: MS Word	==== {{{2"]
	" =================================================
	autocmd BufReadPre *.doc set ro
	autocmd BufReadPre *.doc set hlsearch!
	" Antiword is a free MS Word reader for Linux and RISC OS.
	" http://www.winfield.demon.nl/
	" autocmd BufReadPost *.doc silent %!antiword -m utf-8.txt "%"

	if isdirectory(expand('$ANTIWORDHOME'))
		autocmd BufReadPost *.doc exec 'silent %!' . expand($ANTIWORDHOME) . '\antiword -m utf-8.txt "' . iconv(expand("%"), &enc, "gbk") . '"'
	else
		autocmd BufReadPost *.doc exec 'silent %!antiword -m utf-8.txt "' . iconv(expand("%"), &enc, "gbk") . '"'
	endif


	" ============================================= }}}2
	" => [" ====	Filetype: PDF	==== {{{2"]
	" =================================================
	autocmd BufReadPre *.pdf set ro nowrap
	autocmd BufReadPost *.pdf exec 'silent %!pdftotext -nopgbrk -layout -q -eol unix "' . iconv(expand("%"), &enc, "gbk") . '" -'


	" ============================================= }}}2
	" => [" ====	Filetype: Python section	==== {{{2"]
	" =================================================
	" Run the current buffer in python - ie. on leader+space
	" au FileType python so ~/vim_local/syntax/python.vim
	autocmd FileType python map <buffer> <leader><space> :w!<cr>:!python %<cr>
	" autocmd FileType python so ~/vim_local/plugin/python_fold.vim

	" Set some bindings up for 'compile' of python
	autocmd FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
	autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

	" Python iMaps
	au FileType python set cindent
	au FileType python inoremap <buffer> $r return
	au FileType python inoremap <buffer> $s self
	au FileType python inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
	au FileType python inoremap <buffer> $i import
	au FileType python inoremap <buffer> $p print
	au FileType python inoremap <buffer> $d """<cr>"""<esc>O

	" Run in the Python interpreter
	function! Python_Eval_VSplit() range
		let src = tempname()
		let dst = tempname()
		execute ": " . a:firstline . "," . a:lastline . "w " . src
		execute ":!python " . src . " > " . dst
		execute ":pedit! " . dst
	endfunction
	au FileType python vmap <F7> :call Python_Eval_VSplit()<cr>

	" Choose Python compiler
	augroup ft_python
		autocmd!
		function! ChoosePythonCompiler()
			echo "Please choose python compiler:\n"
			echo "1. Python2+\n"
			echo "2. Python3+\n"
			let flag=getchar()
			if flag==49
				call SingleCompile#ChooseCompiler('python', 'python')
				execute 'SingleCompileRun'
			elseif flag==50
				call SingleCompile#ChooseCompiler('python', 'python3')
				execute 'SingleCompileRun'
			endif
		endfunction
		autocmd filetype python nnoremap <buffer> <Leader>r :call ChoosePythonCompiler()<CR>
	augroup END

	" ============================================= }}}2
	" => [" ====	Filetype: Ruby & PHP section	==== {{{2"]
	" =================================================
	autocmd FileType ruby map <buffer> <leader><space> :w!<cr>:!ruby %<cr>
	autocmd FileType php compiler php
	autocmd FileType php map <buffer> <leader><space> <leader>cd:w<cr>:make %<cr>


	" ============================================= }}}2
	" => [" ====	Filetype: SML	==== {{{2"]
	" ================================================="
	autocmd FileType sml map <silent> <buffer> <leader><space> <leader>cd:w<cr>:!sml %<cr>


	" ============================================= }}}2
	" => [" ====	Filetype: Scheme bidings	==== {{{2"]
	" =================================================
	autocmd BufNewFile,BufRead *.scm map <buffer> <leader><space> <leader>cd:w<cr>:!petite %<cr>
	autocmd BufNewFile,BufRead *.scm inoremap <buffer> <C-t> (pretty-print )<esc>i
	autocmd BufNewFile,BufRead *.scm vnoremap <C-t> <esc>`>a)<esc>`<i(pretty-print <esc>


	" ============================================= }}}2
	" => [" ====	Filetype: SVN section	==== {{{2"]
	" ================================================="
	map <F8> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg


	" ============================================= }}}2
	" => [" ====	Filetype: NSIS section	==== {{{2"]
	" ================================================="
	" autocmd FileType nsi map <buffer> <leader><space> :w<cr>:!makensis %<cr>
	autocmd FileType NSIS map <buffer> <F5> :w<cr>:!makensis %<cr>


	" ============================================= }}}2
	" => [" ====	Filetype: Vim section	==== {{{2"]
	" =================================================
	" autocmd FileType vim set nofen
	autocmd FileType vim set foldmethod=expr
	autocmd FileType vim set foldexpr=getline(v:lnum-1)=~'^\\s*$'&&getline(v:lnum)=~'\"\\{2,}'?'<1':1
	autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Moving around and tabs {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / and c-space to ?
" map <space> /
" map <c-space> ?

" Smart way to move btw. windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" Actually, the tab does not switch buffers, but my arrows
" Bclose function ca be found in "Buffer related" section
map <leader>bd :Bclose<cr>
map <down> <leader>bd
" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew %<cr>
try
	set switchbuf=usetab
	set stal=2
	set showtabline=1 "至少有两个标签页时才会显示带有标签页标签的行
catch
endtry

" Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => General Autocommands {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch to current dir
map <leader>cd :cd %:p:h<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $w ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i

imap <m-l> <esc>:exec "normal f" . leavechar<cr>a
imap <d-l> <esc>:exec "normal f" . leavechar<cr>a


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => General Abbrevs {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My information
iab xname QiWei <qiwei201@gmial.com>
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xdate2 <c-r>=strftime("%y-%m-%d %H:%M:%S")<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0
map 0 ^

" Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
	let cwd = getcwd()
	return "e " . cwd
endfunc

func! DeleteTillSlash()
	let g:cmd = getcmdline()
	if MySys() == "linux" || MySys() == "mac"
		let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
	else
		let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
	endif
	if g:cmd == g:cmd_edited
		if MySys() == "linux" || MySys() == "mac"
		let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
		else
		let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
		endif
	endif
	return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
	return a:cmd . " " . expand("%:p:h") . "/"
endfunc

" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<cr>

cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $tc <C-\>eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

" cnoremap <C-K>    <C-U>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast open a buffer by search for a name
" map <c-q> :sb

" Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

" Restore cursor to file position in previous editing session
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Buffer - reverse everything ... :)
map <F11> ggVGg?

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For Cope
map <silent> <leader><cr> :noh<cr>

" Orginal for all
" map <leader>n :cn<cr>
" map <leader>p :cp<cr>
" map <leader>c :botright cw 10<cr>
" map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M
" noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

" Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

" Super paste
" inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

" A function that inserts links & anchors on a TOhtml export.
" Notice:
" Syntax used is:
" Link
" Anchor
function! SmartTOHtml()
	TOhtml
	try
		%s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
		%s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
		%s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
	catch
	endtry
	exe ":write!"
	exe ":bd"
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Select range, then hit :SuperRetab($width) - by p0g and FallingCow
function! SuperRetab(width) range
	silent! exe a:firstline . ',' . a:lastline . 's/\v%(^ *)@<= {'. a:width .'}/\t/g'
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Convenience Mappings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" => [" ====	Mappings: Init	==== {{{2"]
	" =================================================
	let maplocalleader = ","
	noremap  <Leader><LocalLeader> <LocalLeader>
	noremap! <Leader><LocalLeader> <LocalLeader>
	noremap  <LocalLeader>, <C-\><C-N>
	noremap! <LocalLeader>, <C-\><C-N>
	snoremap <LocalLeader>, <C-\><C-N>

	" ============================================= }}}2
	" => [" ====	Mappings: load DLL	==== {{{2"]
	" Some DLLs are also provided to extend the performance of gVim.
	" =================================================
	if executable("gvimfullscreen.dll")
		" 全屏
		" map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
		map <leader>fs <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
	endif

	if executable("vimtweak.dll")
		" Alpha Window
		map <leader>aw :call libcallnr("vimtweak.dll", "SetAlpha", 128)<cr>
		map <leader>aW :call libcallnr("vimtweak.dll", "SetAlpha", 255)<cr>
		" Maximized Window
		map <leader>mw :call libcallnr("vimtweak.dll", "EnableMaximize", 1)<cr>
		map <leader>mW :call libcallnr("vimtweak.dll", "EnableMaximize", 0)<cr>
		" TopMost Window
		map <leader>et :call libcallnr("vimtweak.dll", "EnableTopMost", 1)<cr>
		map <leader>eT :call libcallnr("vimtweak.dll", "EnableTopMost", 0)<cr>
	endif


	" ============================================= }}}2
	" => [" ====	Mappings: Folding	==== {{{2"]
	" =================================================
	" Make the current location sane.
	nnoremap <c-cr> zvzt

	" ,f for fold
	vnoremap <Leader>f zf
	
	" Space to toggle and create folds.
	nnoremap <silent><Space> @=(foldlevel('.') ? 'za' :"\<Space>")<CR>
	vnoremap <Space> zf

	" Space to toggle folds.
	" 用空格键来开关折叠
	" nnoremap <Space> za
	" vnoremap <Space> za
	" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

	" Make zO recursively open whatever top level fold we're in, no matter where the
	" cursor happens to be.
	nnoremap zO zCzO

	" Use ,z to "focus" the current fold.
	nnoremap <leader>z zMzvzz


	" ============================================= }}}2
	" => [" ====	Mappings: Arrows	==== {{{2"]
	" =================================================
	" Ctrl Left & Right move between buffers
	" (need to find out how to disable this within nerdtree buffer)
	" noremap <silent> <C-left> :bprev<CR>
	" noremap <silent> <C-h> :bprev<CR>
	" noremap <silent> <C-right> :bnext<CR>
	" noremap <silent> <C-l> :bnext<CR>
	
	" Closes the current buffer
	" nnoremap <silent> <Leader>q :Bclose<CR>
	
	" Closes the current window
	" nnoremap <silent> <Leader>Q <C-w>c

	" right arrow (normal mode) switches buffers  (excluding minibuf)
	" map <right> <ESC>:MBEbn<RETURN>

	" left arrow (normal mode) switches buffers (excluding minibuf)
	" map <left> <ESC>:MBEbp<RETURN>

	" up arrow (normal mode) brings up a file list
	" map <up> <ESC>:Sex<RETURN><ESC><C-W><C-W> 

	" down arrow  (normal mode) brings up the tag list
	" map <down> <ESC>:Tlist<RETURN>

	" alt-i (normal mode) inserts a single char, and then switches back to normal
	" map <A-i> i <ESC>r 


	" ============================================= }}}2
	" => [" ====	Mappings: ScrollWheel	==== {{{2"]
	" =================================================
	if version >= 703
		map  <C-ScrollWheelDown> <ScrollWheelRight>
		map  <C-ScrollWheelUp>   <ScrollWheelLeft>
		imap <C-ScrollWheelDown> <ScrollWheelRight>
		imap <C-ScrollWheelUp>   <ScrollWheelLeft>
	endif

	" ============================================= }}}2
	" => [" ====	Mappings: Edit	==== {{{2"]
	" 编辑
	" =================================================
	" Edit another file in the same directory as the current file
	" uses expression to extract path from current file's path {{{
	if has("unix")
		map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
	else
		map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
	endif
	" }}}
 
	" Align text {{{
	nnoremap <leader>Al :left<cr>
	nnoremap <leader>Ac :center<cr>
	nnoremap <leader>Ar :right<cr>
	vnoremap <leader>Al :left<cr>
	vnoremap <leader>Ac :center<cr>
	vnoremap <leader>Ar :right<cr>
	" }}}

	" Change case {{{
	nnoremap <C-u> gUiw
	inoremap <C-u> <esc>gUiwea
	" }}}

	nmap <C-H> <BS>
	nnoremap p ]p
	nnoremap Y y$
	nnoremap vaa ggVG
	nnoremap <LocalLeader>gv V`]

	autocmd FileType qf nnoremap <buffer> <CR> <CR>

	nnoremap <LocalLeader>< i0<C-D><C-\><C-N>
	inoremap <LocalLeader>< 0<C-D>
	xnoremap <LocalLeader>< 99<

	inoremap <C-Z> <C-O>u
	inoremap <C-W> <C-G>u<C-W>
	inoremap <expr> <C-U> (pumvisible() ? "\<C-E>" : '') . "\<C-G>u\<C-U>"

	inoremap <LocalLeader>o <C-O>

	noremap <silent> <C-S> :update<CR>
	inoremap <silent> <C-S> <C-\><C-N>:update<CR>
	xnoremap <silent> <C-S> <C-\><C-N>:update<CR>

	noremap <C-Del> :quit<CR>
	noremap <C-kDel> :quit<CR>
	map <kDel> <Del>

	" Ref: tyru - https://github.com/tyru/dotfiles
	cnoremap <LocalLeader>d <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

	" ============================================= }}}2
	" => [" ====	Mappings: Move	==== {{{2"]
	" 各种移动
	" =================================================
	" noremap <expr> <Space>  repeat('<ScrollWheelDown>', 2)
	" nnoremap <expr> <LocalLeader><Space> repeat('<ScrollWheelUp>', 2)
	" nnoremap <expr> <Space>  <SID>scroll_down()
	" nnoremap <expr> <LocalLeader><Space> <SID>scroll_up()
	" xnoremap <expr> <Space>  <SID>scroll_down('v')
	" xnoremap <expr> <LocalLeader><Space> <SID>scroll_up('v')

	for map_mode in ['n', 'o', 'x']
		execute map_mode . "noremap j gj"
		execute map_mode . "noremap k gk"
		execute map_mode . "noremap gj j"
		execute map_mode . "noremap gk k"
	endfor

	inoremap <expr> <Down> pumvisible() ? "\<C-N>" : "\<C-O>gj"
	inoremap <expr> <Up> pumvisible() ? "\<C-P>" : "\<C-O>gk"

	" nmap <silent><Home> :call SmartHome("n")<CR>
	" nmap <silent><End> :call SmartEnd("n")<CR>
	" imap <silent><Home> <C-R>=SmartHome("i")<CR>
	" imap <silent><End> <C-R>=SmartEnd("i")<CR>
	" vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
	" vmap <silent><End> <Esc>:call SmartEnd("v")<CR>

	" map  <kHome> <Home>
	" map! <kHome> <Home>
	" map  <kEnd>  <End>
	" map! <kEnd>  <End>

	" nnoremap ' `

	nmap <LocalLeader>w <C-W>
	nnoremap <C-W>gf :tab wincmd f<CR>
	nnoremap <C-W>V :wincmd K <Bar> wincmd =<CR>
	nnoremap <LocalLeader>gf :tab wincmd f<CR>
	nnoremap <expr> <CR> &modifiable ? "i<CR><C-\><C-N>" : "<C-]>"
	nnoremap <expr> <BS> &modifiable ? "i<C-W><C-\><C-N>" : "<C-O>"

	nnoremap gr gT
	nnoremap <silent> gT :tablast<CR>
	nnoremap <silent> gR :tabfirst<CR>
	nnoremap <silent> <expr> <LocalLeader>gt printf(":tabmove %s<CR>", tabpagenr() == tabpagenr('$') ? 0 : tabpagenr())
	nnoremap <silent> <expr> <LocalLeader>gr printf(":tabmove %s<CR>", tabpagenr() == 1 ? '' : tabpagenr() - 2)
	nnoremap <silent> <LocalLeader>gT :tabmove<CR>
	nnoremap <silent> <LocalLeader>gR :tabmove 0<CR>

	" ============================================= }}}2
	" => [" ====	Mappings: Fn	==== {{{2"]
	" 功能键
	" =================================================
	map  <F1> :help <C-R>=expand('<cword>')<CR><CR>
	map  <LocalLeader><F1> :tab help <C-R>=expand('<cword>')<CR><CR>
	xmap <F1> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>:help <C-R>=b:tempReg<CR><CR>
	xmap <LocalLeader><F1> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>:help <C-R>=b:tempReg<CR><CR>

	nmap <F2> :%s/<C-R><C-W>
	xmap <F2> :<C-U>call SaveReg()<CR>gvy:let b:tempReg=@"<CR>:call RestoreReg()<CR>gv:<C-U>%s/ <C-R>=b:tempReg<CR>

	noremap <silent> <F3> :nohlsearch<CR>
	inoremap <silent> <F3> <C-O>:nohlsearch<CR>
	noremap <silent> <F4> :set hlsearch<CR>
	inoremap <silent> <F4> <C-O>:set hlsearch<CR>

	nnoremap <F5> :call SynStackInfo()<CR>
	nnoremap <Leader><F5> :tabdo e!<CR>
	nnoremap <F6> :QuickOff<CR>

	nnoremap <silent><F8> :setlocal spell! spelllang=en_us spell?<CR>
	xnoremap <silent><F8> :<C-U>setlocal spell! spelllang=en_us spell?<CR>gv
	inoremap <silent><F8> <C-O>:setlocal spell! spelllang=en_us spell?<CR>

	set pastetoggle=<F11>
	map  <silent> <F12> :set list!<CR>
	imap <silent> <F12> <C-O>:set list!<CR>

	" ============================================= }}}2
	" => [" ====	Mappings: AutoComp	==== {{{2"]
	" 自动完成
	" =================================================
	cnoremap <LocalLeader>. <C-E>
	cnoremap <LocalLeader><CR> <C-E>

	inoremap <LocalLeader>. <C-X><C-O>
	inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "\<C-J>"
	inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "\<C-K>"

	" ============================================= }}}2
	" => [" ====	Mappings: Transfer text	==== {{{2"]
	" 跨 Vim 粘贴
	" =================================================
	" http://vim.wikia.com/wiki/Transfer_text_between_two_Vim_instances
	nmap <Leader>xp :r $HOME/.vimxfer<CR>
	nmap <Leader>xy V:w! $HOME/.vimxfer<CR>
	vmap <Leader>xy :w! $HOME/.vimxfer<CR>
	vmap <Leader>xa :w>> $HOME/.vimxfer<CR>

	" ============================================= }}}2
	" => [" ====	Mappings: Quickfix	==== {{{2"]
	" =================================================
	" Ref: kana - https://github.com/kana/config
	" Note: -- Ex-mode will be never used and recordings are rarely used.
	nmap q [quickfix]
	nmap [quickfix]w [localist]
	nnoremap [quickfix] <Nop>
	nnoremap [localist] <Nop>
	nnoremap Q q

	" Quickfix list  {{{3
	nnoremap <silent> [quickfix]j :cnext<CR>
	nnoremap <silent> [quickfix]k :cprevious<CR>
	nnoremap <silent> [quickfix]r :crewind<CR>
	nnoremap <silent> [quickfix]K :cfirst<CR>
	nnoremap <silent> [quickfix]J :clast<CR>
	nnoremap <silent> [quickfix]l :clist<CR>
	nnoremap <silent> [quickfix]o :copen<CR>
	nnoremap <silent> [quickfix]c :cclose<CR>
	nnoremap <silent> [quickfix]p :colder<CR>
	nnoremap <silent> [quickfix]n :cnewer<CR>
	" }}} Location list  {{{3
	nnoremap <silent> [localist]j :lnext<CR>
	nnoremap <silent> [localist]k :lprevious<CR>
	nnoremap <silent> [localist]r :lrewind<CR>
	nnoremap <silent> [localist]K :lfirst<CR>
	nnoremap <silent> [localist]J :llast<CR>
	nnoremap <silent> [localist]l :llist<CR>
	nnoremap <silent> [localist]o :lopen<CR>
	nnoremap <silent> [localist]c :lclose<CR>
	nnoremap <silent> [localist]p :lolder<CR>
	nnoremap <silent> [localist]n :lnewer<CR>
	" }}}


	" ============================================= }}}2
	" => [" ====	Mappings: User text objects	==== {{{2"]
	" =================================================
	" let g:textobj_rubyblock_no_default_key_mappings = 1
	" TODO 那如果不是 ruby 的話咧？
	" function! s:textobj_rubyblock_settings()
		" xmap <buffer> ab <Plug>(textobj-rubyblock-a)
		" omap <buffer> ab <Plug>(textobj-rubyblock-a)
		" xmap <buffer> ib <Plug>(textobj-rubyblock-i)
		" omap <buffer> ib <Plug>(textobj-rubyblock-i)
	" endfunction
	" autocmd! my_vimrc FileType ruby call s:textobj_rubyblock_settings()

	" ============================================= }}}2
	" => [" ====	Mappings: User operators	==== {{{2"]
	" =================================================
	" TODO <LocalLeader>R 應取代到行尾
	" nmap <LocalLeader>r <Plug>(operator-replace)
	" xmap <LocalLeader>r <Plug>(operator-replace)
	" nmap <LocalLeader>he <Plug>(operator-html-escape)
	" xmap <LocalLeader>he <Plug>(operator-html-escape)
	" nmap <LocalLeader>hd <Plug>(operator-html-unescape)
	" xmap <LocalLeader>hd <Plug>(operator-html-unescape)

	" ============================================= }}}2
	" => [" ====	Mappings: w!!	==== {{{2"]
	" =================================================
	cnoremap <expr> w!! ((getcmdtype() == ':' && getcmdpos() <= 1) ? 'call SudoWrite()'  : 'w!!')

	" ============================================= }}}2
	" => [" ====	Mappings: .vimrc	==== {{{2"]
	" =================================================
	nmap ,qv :e $MYVIMRC <CR>
	nmap ,qs :source <C-R>=expand("%:p") <CR>


	" ============================================= }}}2
	" => [" ====	Mappings: cscope and ctags	==== {{{2"]
	" =================================================
	map <F12> :call Do_CsTag()<CR>
	nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
	nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
	nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR
	
	function Do_CsTag() "{{{3
		let dir = getcwd()
		if filereadable("tags")
			if(has("win32"))
				let tagsdeleted=delete(dir."\\"."tags")
			else
				let tagsdeleted=delete("./"."tags")
			endif
			if(tagsdeleted!=0)
				echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
				return
			endif
		endif
		if has("cscope")
			silent! execute "cs kill -1"
		endif
		if filereadable("cscope.files")
			if(has("win32"))
				let csfilesdeleted=delete(dir."\\"."cscope.files")
			else
				let csfilesdeleted=delete("./"."cscope.files")
			endif
			if(csfilesdeleted!=0)
				echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
				return
			endif
		endif
		if filereadable("cscope.out")
			if(has("win32"))
				let csoutdeleted=delete(dir."\\"."cscope.out")
			else
				let csoutdeleted=delete("./"."cscope.out")
			endif
			if(csoutdeleted!=0)
				echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
				return
			endif
		endif
		if(executable('ctags'))
			"silent! execute "!ctags -R --c-types=+p --fields=+S *"
			silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
		endif
		if(executable('cscope') && has("cscope") )
			if(g:iswindows!=1)
				silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
			else
				silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
			endif
			silent! execute "!cscope -b"
			execute "normal :"
			if filereadable("cscope.out")
				execute "cs add cscope.out"
			endif
		endif
	endfunction
	" }}}3


	" ============================================= }}}2
	" => [" ====	Mappings: <Nop>	==== {{{2"]
	" 得到什么都不做的映射
	" =================================================
	" nmap ZZ <Nop>
	" nmap ZQ <Nop>

	" ============================================= }}}2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Commands: {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('cat')
	command! EmptyFile call system("cat /dev/null > " . shellescape(expand('%:p'))) | checktime
endif

command! Rnginx execute "!sudo\ service nginx restart"
" command! Rtouch execute "!touch tmp/restart.txt"

" Ref: tsukkee - https://github.com/tsukkee/config
command! -nargs=1 -bang -complete=file Rename saveas<bang> <args> | call delete(expand('#'))

" Ref: kana - https://github.com/kana/config
command! -bar -complete=file -nargs=+ Grep call s:grep('grep', [<f-args>])
command! -bar -complete=file -nargs=+ Lgrep call s:grep('lgrep', [<f-args>])
function! s:grep(command, args)
	execute a:command '/'.a:args[-1].'/' join(a:args[:-2])
endfunction

" call altercmd#load()
" call altercmd#define('<buffer>', 'help?', 'HelpForWhat')
" command! HelpForWhat echoerr "Sure.  Is this help you?"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Abbreviations: {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoreabbrev <expr> t ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'tabnew' : 't')
cnoreabbrev <expr> m ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'messages' : 'm')
cnoreabbrev <expr> g ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'GitDiff' : 'g')
cnoreabbrev <expr> u ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'Unite' : 'u')
cnoreabbrev <expr> f ((getcmdtype() == ':' && getcmdpos() <= 2) ? 'VimFilerSplit' : 'f')
cnoreabbrev <expr> tm ((getcmdtype() == ':' && getcmdpos() <= 3) ? 'TabMessage' : 'tm')
cnoreabbrev <expr> tms ((getcmdtype() == ':' && getcmdpos() <= 4) ? 'TabMessage scriptnames' : 'tms')
cnoreabbrev <expr> '<,'>q ((getcmdtype() == ':' && getcmdpos() <= 7) ? 'q' : "'<,'>q")
" cnoreabbrev <expr> re ((getcmdtype() == ':' && getcmdpos() <= 3) ? 'CleanMakeGSession<CR>:qa' : 're')
cnoreabbrev ll <lt>LocalLeader>
inoreabbrev ll <lt>LocalLeader>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Functions: {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 清除多餘 Tab, 空白    {{{2

command! -nargs=0 TidySpaces call TidySpaces()
function! TidySpaces()
	let oldCursor = getpos(".")
	%s/\r\+$//ge
	%s/\t/    /ge
	%s/\s\+$//ge
	call setpos('.', oldCursor)
endfunction

"     變更編碼    {{{2

" Ref: kana - https://github.com/kana/config
command! -bang -bar -complete=file -nargs=? Utf8
			\ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Big5
			\ edit<bang> ++enc=big5 <args>

"     sudo write    {{{2

function! SudoWrite()
	" TODO 'autoread', prevent prompt for reload
	let modified = &l:modified
	setlocal nomodified
	silent! execute 'write !sudo tee % >/dev/null'
	let &l:modified = v:shell_error ? modified : 0
endfunction

" }}}2   清除／復原 search pattern   {{{2

" 問題：let @/ = '' 後再按 n，不知為什麼又會改變 @/ 的值
" 替代作法為使用 :nohlsearch，但無法確認目前是否已有 highlight，
" 故用掉 <F3> <F4> 兩個鍵作 mapping。
"
" let g:lastSearchPattern = @/
" function! ToggleSearchPattern()
"   if @/ != ''
"     let g:lastSearchPattern = @/
"     let @/ = ''
"   else
"     let @/ = g:lastSearchPattern
"   endif
" endfunction
" nmap <silent> <F3> :call ToggleSearchPattern()<CR>
" imap <silent> <F3> <C-O>:call ToggleSearchPattern()<CR>

" }}}2   暫存／復原 position    {{{2

function! SavePos()
	let s:save_pos = getpos(".")
endfunction


function! RestorePos()
	call setpos('.', s:save_pos)
endfunction

" }}}2   暫存／復原 register 內容   {{{2

function! SaveReg(...) "{{{
	let l:name = a:0 ? a:1 : v:register
	let s:save_reg = [getreg(l:name), getregtype(l:name)]
endfunction "}}}


function! RestoreReg(...) "{{{
	let l:name = a:0 ? a:1 : v:register
	if exists('s:save_reg')
		call setreg(l:name, s:save_reg[0], s:save_reg[1])
	endif
endfunction "}}}

" }}}2   暫存／復原 mark 內容   {{{2

function! SaveMark(...)
	let l:name = a:0 ? a:1 : 'm'
	let s:save_mark = getpos("'" . l:name)
endfunction


function! RestoreMark(...)
	let l:name = a:0 ? a:1 : 'm'
	call setpos("'" . l:name, s:save_mark)
endfunction

" }}}2   字串長度（column 數）   {{{2

function! StrWidth(str)
	if exists('*strwidth')
		return strwidth(a:str)
	else
		let strlen = strlen(a:str)
		let mstrlen = strlen(substitute(a:str, ".", "x", "g"))
		if strlen == mstrlen
			return strlen
		else
			" Note: 暫不處理全形字（以下值不正確）
			return strlen
		endif
	endif
endfunction

" }}}2   依字串長度（column 數）裁切多餘文字   {{{2

function! StrCrop(str, len, ...)
	let l:padChar = a:0 > 0 ? a:1 : ' '
	if exists('*strwidth')
		let text = substitute(a:str, '\%>' . a:len . 'c.*', '', '')
		let remainChars = split(substitute(a:str, text, '', ''), '\zs')
		while strwidth(text) < a:len
			let longer = len(remainChars) > 0 ? (text . remove(remainChars, 0)) : text
			if strwidth(longer) < a:len
				let text = longer
			else
				let text .= l:padChar
			endif
		endwhile
		return text
	else
		" Note: 暫不處理全形字（以下值不正確）
		return substitute(a:str, '\%>' . a:len . 'c.*', '', '')
	endif
endfunction

" }}}2   Custom diffoff     {{{2

command! MyDiffOff call MyDiffOff()
function! MyDiffOff()
	if &diff
		setlocal diff& scrollbind& cursorbind& wrap& foldcolumn&
		set scrollopt=ver,hor,jump
		let &l:foldmethod = exists('b:save_foldmethod') ? b:save_foldmethod : 'marker'
	else
		echomsg 'Not in diff mode.'
	endif
endfunction

" }}}2   Big File     {{{2

" TODO this is not stable!
" ref LargeFile http://www.vim.org/scripts/script.php?script_id=1506
function! BigFile(fname)
	if getfsize(a:fname) >= g:BigFile
		syntax clear

		if !exists('b:eikeep')
			let b:eikeep = &eventignore
			let b:ulkeep = &undolevels
			let b:bhkeep = &bufhidden
			let b:foldmethodkeep= &foldmethod
			let b:swfkeep= &swapfile
		endif

		" PP! 'WTF BigFile ' . strftime('%T')
		set eventignore=FileType undolevels=-1
		setlocal noswapfile bufhidden=unload foldmethod=manual
		nnoremap <buffer> <LocalLeader>ddd :EmptyFile<CR>

		let fname=escape(substitute(a:fname,'\','/','g'),' ')

		" fg 回來後，有時會發動 BufEnter？
		execute "autocmd BigFile BufEnter ".fname." PP! 'WTF BufEnter ' . strftime('%T')"
		execute "autocmd BigFile BufLeave ".fname." PP! 'WTF BufLeave ' . strftime('%T')"

		execute "autocmd BigFile BufEnter ".fname." set undolevels=-1"
		execute "autocmd BigFile BufRead ".fname.' call FileTypeForBigFile(expand("<afile>"))'
		execute "autocmd BigFile BufLeave ".fname." set undolevels=" . b:ulkeep . " eventignore=" . b:eikeep
		execute "autocmd BigFile BufUnload ".fname." autocmd! BigFile * ". fname
	endif
endfunction

command! BigFileUndo call BigFileUndo()
function! BigFileUndo()
	set eventignore&
	set undolevels&
	set bufhidden&
	setlocal foldmethod=marker
	set noswapfile
endfunction

function! FileTypeForBigFile(fname)
	if fnamemodify(a:fname, ":p:h") =~ '/home/www/fc/\(\w\+/\)\?log'
		if &fileencoding != 'utf-8'
			edit! ++enc=utf-8
		endif
		syntax match railslogEscape '\e\[[0-9;]*m' conceal
	elseif fnamemodify(a:fname, ":p:h") == '/home/www/logs'
		set syntax=httplog
	endif
endfunction

" }}}2   Context sensitive H,L.     {{{2

" Ref: tyru - https://github.com/tyru/dotfiles
" TODO 內部也統一使用 s:scroll_up / down
nnoremap <silent> H :<C-u>call HContext()<CR>
nnoremap <silent> L :<C-u>call LContext()<CR>
xnoremap <silent> H <ESC>:<C-u>call HContext()<CR>mzgv`z
xnoremap <silent> L <ESC>:<C-u>call LContext()<CR>mzgv`z

function! HContext()
	let l:moved = MoveCursor("H")
	if !l:moved && line('.') != 1
		" execute "normal! " . "\<ScrollWheelUp>H"
		execute "normal! " . "5kH"
	endif
endfunction

function! LContext()
	let l:moved = MoveCursor("L")

	if !l:moved && line('.') != line('$')
		" execute "normal! " . "\<ScrollWheelDown>L"
		execute "normal! " . "5jL"
	endif
endfunction

function! MoveCursor(key)
	let l:cnum = col('.')
	let l:lnum = line('.')
	let l:wline = winline()

	execute "normal! " . v:count . a:key
	let l:moved =  l:cnum != col('.') || l:lnum != line('.') || l:wline != winline()

	return l:moved
endfunction

" }}}2   Scroll     {{{2

function! s:scroll_down(...)
	let mode = a:0 ? a:1 : 'n'
	let l:count = a:0 > 1 ? a:2 : 2

	if has("gui_running")
		return '5j'
	else
		return repeat("\<ScrollWheelDown>", l:count)
	endif
endfunction


function! s:scroll_up(...)
	let mode = a:0 ? a:1 : 'n'
	let l:count = a:0 > 1 ? a:2 : 2

	if has("gui_running")
		return '5k'
	else
		return repeat("\<ScrollWheelUp>", l:count)
	endif
endfunction

" }}}2   Smart Home/End     {{{2

" http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines
function! SmartHome(mode)
	let curcol = col(".")
	" gravitate towards beginning for wrapped lines
	if curcol > indent(".") + 2
		call cursor(0, curcol - 1)
	endif
	if curcol == 1 || curcol > indent(".") + 1
		if &wrap
			normal! g^
		else
			normal! ^
		endif
	else
		if &wrap
			normal! g0
		else
			normal! 0
		endif
	endif
	if a:mode == "v"
		call SaveMark('m')
		call setpos("'m", getpos('.'))
		normal! gv`m
		call RestoreMark('m')
	endif
	return ""
endfunction

function! SmartEnd(mode)
	let curcol = col(".")
	let lastcol = a:mode == "i" ? col("$") : col("$") - 1
	" gravitate towards ending for wrapped lines
	if curcol < lastcol - 1
		call SaveReg()
		normal! yl
		let l:charlen = byteidx(getreg(), 1)
		call cursor(0, curcol + l:charlen)
		call RestoreReg()
	endif
	if curcol < lastcol
		if &wrap
			normal! g$
		else
			normal! $
		endif
	else
		normal! g_
	endif
	" correct edit mode cursor position, put after current character
	if a:mode == "i"
		call SaveReg()
		normal! yl
		let l:charlen = byteidx(getreg(), 1)
		call cursor(0, col(".") + l:charlen)
		call RestoreReg()
	endif
	if a:mode == "v"
		call SaveMark('m')
		call setpos("'m", getpos('.'))
		normal! gv`m
		call RestoreMark('m')
	endif
	return ""
endfunction

"}}}

" }}}2   clipboard 存取    {{{2

" http://vim.wikia.com/wiki/Using_the_Windows_clipboard_in_Cygwin_Vim
" TODO 正確處理字元編碼
" TODO gVim <S-Insert>
function! Putclip(type, ...) range
	let save_sel = &selection
	let &selection = "inclusive"
	let save_reg = @@
	if a:type == 'n'
		silent execute a:firstline . "," . a:lastline . "y"
	elseif a:type == 'c'
		silent execute a:1 . "," . a:2 . "y"
	else
		silent execute "normal! `<" . a:type . "`>y"
	endif
	call system('putclip', @@)
	let &selection = save_sel
	let @@ = save_reg
endfunction

if has('clipboard')
	if $OSTYPE == 'cygwin' || has("gui_win32")
		noremap <silent> <LocalLeader>y "*y
		inoremap <silent> <LocalLeader>y <C-O>"*y
	elseif $OSTYPE == 'linux-gnu'
		noremap <silent> <LocalLeader>y "+y
		inoremap <silent> <LocalLeader>y <C-O>"+y
	endif
else
	vnoremap <silent> <LocalLeader>y :call Putclip(visualmode(), 1)<CR>
	nnoremap <silent> <LocalLeader>y :call Putclip('n', 1)<CR>
	inoremap <silent> <LocalLeader>y <C-O>:call Putclip('n', 1)<CR>
endif

function! Getclip()
	let save_reg = @@
	let @@ = system('getclip')
	setlocal paste
	execute 'normal! p'
	setlocal nopaste
	let @@ = save_reg
endfunction

if has('clipboard')
	if $OSTYPE == 'cygwin' || has("gui_win32")
		nnoremap <silent> <LocalLeader>p "*p
		inoremap <silent> <LocalLeader>p <C-O>"*p
	elseif $OSTYPE == 'linux-gnu'
		nnoremap <silent> <LocalLeader>p "+p
		inoremap <silent> <LocalLeader>p <C-O>"+p
	endif
else
	nnoremap <silent> <LocalLeader>p :call Getclip()<CR>
	inoremap <silent> <LocalLeader>p <C-O>:call Getclip()<CR>
endif

" }}}2   LastTab    {{{2

function! LastTab(act)

	" TODO emulate TabClose autocmd

	let lt = g:lasttab
	let tabClosed = tabpagenr('$') < lt.knownLength ? 1 : 0

	if a:act ==# 'TabLeave'
		if !tabClosed
			let lt.prevLeave = lt.leave
		elseif lt.prevLeave > tabpagenr()
			let lt.prevLeave -= 1
		endif
		let lt.leave = tabpagenr()
	elseif a:act ==# 'switch'
		if tabClosed
			let lastTab = lt.prevLeave > tabpagenr() ? lt.prevLeave -1  : lt.prevLeave
		else
			let lastTab = lt.leave
		endif
		if lastTab == tabpagenr()
			echo 'Already on last tab.'
		else
			execute "tabnext " . lastTab
		endif
	endif

	let lt.knownLength = tabpagenr('$')

endfunction

if !exists('g:lasttab')
	let g:lasttab = {'leave':1, 'prevLeave':1, 'knownLength':1}
endif
autocmd TabLeave * call LastTab('TabLeave')
" autocmd TabEnter,VimEnter * :call LastTab('TabEnter')
" autocmd BufLeave * :call LastTab('TabEnter')
autocmd TabEnter * call LastTab('TabEnter')
nnoremap <silent> <LocalLeader>t :call LastTab('switch')<CR>
inoremap <silent> <LocalLeader>t <C-\><C-N>:call LastTab('switch')<CR>

" }}}2   目前位置 highlight group   {{{2

function! SynStackInfo()
	let synStack =  synstack(line("."), col("."))
	if len(synStack) == 0
		echomsg 'No synID here.'
	else
		let result = []
		for syn in synStack
			call add(result, SynInfo(syn))
		endfor
		redraw
		let level = 0
		for list in result
			execute "echohl " . list[0]
			echomsg repeat(' ', level) . list[1]
			let level += 1
			echohl None
		endfor
	endif
endfunction

function! SynInfo(syn)
	let synAttr =  synIDattr(a:syn, "name")
	if synAttr == ''
		echomsg 'No synID here.'
	else
		let idTrans = synIDtrans(a:syn)
		let syn = synIDattr(idTrans, "name")
		return [syn, synAttr . " - " . syn . " {fg: " . synIDattr(idTrans, 'fg') . ', bg: ' . synIDattr(idTrans, 'bg') . "}" ]
	endif
endfunction

" }}}2   TabMessage   {{{2

" http://vim.wikia.com/wiki/Capture_ex_command_output
function! TabMessage(cmd)
	redir => redirMessage
	silent execute a:cmd
	redir END
	tabnew
	silent put=redirMessage
	0,2delete_
	set nomodified
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
	setlocal nobuflisted
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" }}}2   Move window into tabpage   {{{2

" Modified from kana's useful tab function {{{
function! s:move_window_into_tab_page(...)
	" Move the current window into target_tabpagenr.
	" a:1 - target_tabpagenr : if not set, move into new tab page.
	" a:2 - open_relative : open new tab aside current tab (default 1).
	let target_tabpagenr = a:0 > 0 ? a:1 : 0
	let open_relative = a:0 > 1 ? a:2 : 1

	if target_tabpagenr > tabpagenr('$')
		let target_tabpagenr = tabpagenr('$')
	endif

	let original_tabnr = tabpagenr()
	let target_bufnr = bufnr('')
	let window_view = winsaveview()

	if target_tabpagenr == 0
		tabnew
		if !open_relative
			tabmove
		endif
		execute target_bufnr 'buffer'
		let target_tabpagenr = tabpagenr()
	else
		execute target_tabpagenr 'tabnext'
		topleft new  " FIXME: be customizable?
		execute target_bufnr 'buffer'
	endif
	call winrestview(window_view)

	execute original_tabnr 'tabnext'
	if 1 < winnr('$')
		close
	else
		enew
	endif

	execute target_tabpagenr 'tabnext'
endfunction " }}}

command! -nargs=* MoveIntoTabpage call <SID>move_window_into_tab_page(<f-args>)

" }}}2   EvalVimScriptRegion    {{{2

" from c9s - http://gist.github.com/444528 http://gist.github.com/572191
function! EvalVimScriptRegion(s, e)
	let lines = getline(a:s,a:e)
	let file = tempname()
	call writefile(lines,file)
	redir @e
	silent execute ':source ' . file
	call delete(file)
	redraw
	redir END
	echo "Region evaluated."

	if strlen(getreg('e')) > 0
		10new
		redraw
		silent file "EvalResult"
		setlocal noswapfile buftype=nofile bufhidden=wipe
		setlocal nobuflisted nowrap cursorline nonumber foldcolumn=0
		set filetype=eval
		syntax match ErrorLine +^E\d\+:.*$+
		highlight link ErrorLine Error
		silent $put =@e
	endif
endfunction

augroup VimEval
	autocmd!
	autocmd filetype vim :command! -range Eval :call EvalVimScriptRegion(<line1>, <line2>)
	autocmd filetype vim :vnoremap <silent> <F5> <C-\><C-N>:call SavePos()<CR>gv:Eval<CR>:call RestorePos()<CR>
augroup END

" }}}2   fold expr - help 檔案以分隔線（====）分割區塊    {{{2

function! HelpDelimFoldLevel(line)
	if  getline(a:line-1)=~'=\{78,\}'
		return '>1'
	elseif getline(a:line+1)=~'=\{78,\}'
		return '<1'
	else
		return '='
	endif
endfunction

" }}}2   help 檔案將 *keyword* 對齊到右端    {{{2

function! HelpHyperTextEntryJustify()
	let save_isk = &l:iskeyword
	let save_et = &l:expandtab
	let &l:isk = '!-~,^*,^|,^",192-255'
	let &l:expandtab = 1
	.retab!
	call setline(".",
				\ substitute(
				\   getline('.'),
				\   '\v(.*)(\s\*\k+\*)',
				\   '\=submatch(1) . repeat(" ", &textwidth - strlen(submatch(0))) . submatch(2)'
				\   , ""
				\ ))

	let &l:isk = save_isk
	let &l:et = save_et
	.retab!
endfunction

" }}}2   camelCase / under_score 轉換    {{{2

" TODO when no keyword is under/after the cursor, try looking backward to find a word.
function! WordTransform()
	let w = expand("<cword>")
	let x = ''
	let c = strpart(getline('.'), col('.') - 1, 1)
	if match(w, '_') > -1
		let x = substitute(w, '_\([a-z]\)', '\u\1', 'g')
	else
		let x = substitute(w, '\C[A-Z]', '_\L\0', 'g')
	endif
	if x == w
		echohl WarningMsg | echomsg "Not a camelCased/under_scored word." | echohl None
		return
	endif
	if match(w, c) < 0   " cursor might sit before keyword
		execute "normal! f" . strpart(w, 0, 1)
		execute "normal! \"_ciw\<C-R>=x\<CR>"
	else
		execute "normal! \"_ciw\<C-R>=x\<CR>"
	endif
endfunction
nnoremap <LocalLeader>x :call WordTransform()<CR>

" }}}2   :symbol / 'string' 轉換    {{{2

" TODO 根本沒實作
" function! SymbolStringTransform()
"     let w = expand("<cword>")
"     let x = ''
"     let c = strpart(getline('.'), col('.') - 1, 1)
" endfunction

" }}}2   JSLint   {{{2

command! -nargs=* JSLint call JSLint(<f-args>)
" @param boolean interact: 1 to prompt before lint.
" @param string options: custom options for running JSLint. in JSON string, ex: '{"onevar":false}'
function! JSLint(...)
	if !executable('jslint')
		echohl WarningMsg | echoerr "jslint command not found." | echohl None
		return
	endif
	let input    = expand('%')
	let interact = a:0 > 0 ? a:1 : 0
	let options  = a:0 > 1 ? a:2 : ''

	if &modified
		echomsg 'No write since last change, write before lint? (y/n) '
		let ans = getchar()
		if nr2char(ans) == 'y' | w
		elseif nr2char(ans) != 'n' | redraw! | echomsg 'JSLint aborted.' | return
		endif
	endif

	if &filetype == 'javascript'
		let cmd = 'jslint ' . input . ' ' . options
		if interact
			echomsg 'JSLint ' . input . '? (y/n) ' | redraw
			let yes = getchar()
			if nr2char(yes) == 'y'
				return DoJSLint(cmd, input)
			else
				redraw!
				echomsg 'JSLint aborted.'
				return
			endif
		else
			return DoJSLint(cmd, input)
		endif
	else
		echohl WarningMsg | echomsg "Unsupported filetype." | echohl None
	endif
endfunction

function! DoJSLint(cmd, file)
	echomsg "JSLint in progress..."
	let ret = system(a:cmd)
	if v:shell_error
		cexpr ret
		if len(getqflist()) > 0
			QFix!<CR>
		endif
	else
		redraw
		echomsg "No problems found in " . a:file
		return
	endif
endfunction

" }}}2   js 壓縮（Closure Compiler）    {{{2

if !exists('g:enable_js_compress')
	let g:enable_js_compress = 1
endif


command! ToggleJsCompress call ToggleJsCompress()
function! ToggleJsCompress()
	let g:enable_js_compress = !g:enable_js_compress
endfunction


command! -bang -nargs=* JsCompress call JsCompress(<bang>0, <f-args>)
" @param boolean save     0: save to temp file and return compressed content.
"                         1: save with alternative filename, return the new name.
" @param boolean interact 1 to prompt before starting compression.
" @param string options   extra options for running the compiler.
function! JsCompress(save, ...)
	if !g:enable_js_compress
		return
	endif
	let jar      = expand('~/') . 'bin/closure-compiler.jar'
	let defaults = ' --compilation_level=SIMPLE_OPTIMIZATIONS'
				\ . ' --create_source_map ~/closure-compiler-map'
				\ . ' --warning_level=QUIET'
	let input    = expand('%')

	let interact = a:0 > 0 ? a:1 : 0
	let options  = a:0 > 1 ? a:2 : ''

	if &modified
		echomsg 'No write since last change, write before compression? (y/n) '
		let ans = getchar()
		if nr2char(ans) == 'y' | w
		elseif nr2char(ans) != 'n' | redraw! | echomsg 'Compression aborted.' | return
		endif
	endif

	if !executable(jar)
		echohl WarningMsg | echoerr "Can't execute java jar." | echohl None
		return
	endif

	if !a:save
		let output = tempname()
	elseif match(input, '-debug\.js$') > 0
		let output = substitute(input, '-debug\.js$', '\.js', '')
	elseif match(input, '-src\.js$') > 0
		let output = substitute(input, '-src\.js$', '\.js', '')
	else
		let output = substitute(input, '\.js$', '\.min\.js', '')
	endif

	if &filetype == 'javascript'
		if executable('cygpath')
			let cmd = 'java -jar `cygpath -wp ' . jar . '`' . defaults
						\ . ' ' . options
						\ . ' --js=`cygpath -wp ' . input . '`'
						\ . ' --js_output_file=`cygpath -wp ' . output . '`'
		else
			let cmd = 'java -jar ' . jar . defaults . ' ' .options . ' --js=' . input . ' --js_output_file=' . output
		endif
		let cmd .= " 2>&1 \\\\| sed '/^$/d'"

		if interact
			echomsg 'Compress ' . input . ' to ' . output . '? (y/n/s (skip in this session)) '
			let yes = getchar()
			if nr2char(yes) == 'y'
				return DoJsCompress(cmd, output, a:save)
			elseif nr2char(yes) == 's'
				call ToggleJsCompress()
				redraw!
				echomsg 'Disable compression in this session (run :ToggleJsCompress for toggle.)'
				return
			else
				redraw!
				echomsg 'Compression aborted.'
				return
			endif
		else
			return DoJsCompress(cmd, output, a:save)
		endif
	else
		echohl WarningMsg | echomsg "Unsupported filetype." | echohl None
	endif
endfunction


function! DoJsCompress(cmd, file, save)
	let makeprg_orig = &makeprg
	execute "set makeprg=" . escape(a:cmd, ' \"')
	silent make
	let &makeprg = makeprg_orig
	if a:save
		let ret = a:file
	else
		let ret = join(readfile(a:file), "\n")
		call delete(a:file)
	endif
	if len(getqflist()) == 0
		redraw!
		echomsg "Compression completed." (a:save ? '' : '(result written to temporarily file.)')
		return ret
	else
		return 0
	endif
endfunction

" }}}2   bookmarklet 壓縮    {{{2

command! -nargs=* Bookmarklet call Bookmarklet(<f-args>)
function! Bookmarklet(...)
	let result = JsCompress(0, 0, '--compilation_level=WHITESPACE_ONLY')
	if len(getqflist()) == 0 && strlen(result) > 0
		let reuse_win = 0
		for winnr in tabpagebuflist(tabpagenr())
			if bufname(winnr) == '[Bookmarklet]'
				execute winnr . 'wincmd w'
				let reuse_win = winnr
			endif
		endfor
		if !reuse_win
			execute 'belowright 5new [Bookmarklet]'
			setlocal noswapfile bufhidden=wipe winfixheight filetype=javascript
		endif
		let result = substitute(result, '[\n]', '', '')
		setlocal buftype=
		call setline(1, 'javascript:(function(){' . result . '})();')
		if has('ruby')
			ruby require("uri"); VIM::Buffer.current.line = URI.escape(VIM::Buffer.current.line);
		else
			echohl WarningMsg | echomsg "No ruby support. Can't do URI encoding." | echohl None
		endif
		setlocal buftype=nofile
	endif
endfunction

" }}}2   Toggle QuickFix window    {{{2

" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
fu! QFixToggle(forced)
	if exists("g:qfix_win") && a:forced == 0
		cclose
		unlet g:qfix_win
	else
		copen 10
		let g:qfix_win = bufnr("$")
	endif
endfunction
nnoremap <silent> <LocalLeader>q :QFix<CR>

" }}}2   尋找選取的文字    {{{2

" Ref: kana - https://github.com/kana/config
vnoremap * :<C-U>set hlsearch<CR>:call <SID>search_selected_text_literaly('n')<CR>
vnoremap # :<C-U>set hlsearch<CR>:call <SID>search_selected_text_literaly('N')<CR>

function! s:search_selected_text_literaly(search_command)
	call SaveReg('0')
	call SaveReg('"')

	normal! gvy
	let pattern = escape(@0, '\')
	let pattern = substitute(pattern, '\V\n', '\\n', 'g')
	let @/ = pattern
	call histadd('/', '\V' . pattern)
	execute 'normal!' a:search_command
	let v:searchforward = a:search_command ==# 'n'

	call RestoreReg('0')
	call RestoreReg('"')
endfunction

" }}}2   關閉各種 layout 模式    {{{2

command! -nargs=0 QuickOff call <SID>quick_off()
function! s:quick_off()
	if winnr('$') > 1
		if <SID>ref_window_off()
			return
		elseif exists('t:gitdiffall_info')
			execute 'GitDiffOff'
		endif
	endif
endfunction

function! s:ref_quit()
	if &filetype =~ 'ref-\w'
		execute "quit"
	endif
endfunction

function! s:ref_window_off()
	let win_count = winnr('$')
	silent windo call <SID>ref_quit()
	execute 'wincmd t'
	return win_count > winnr('$')
endfunction


" }}}2   text-object for continuous comment    {{{2

" NOTE: limitations
" 1. Only test if first non-blank character is highlighted with "Comment".
" 2. Always linewise.
vnoremap <silent> ac :<C-U>call TxtObjComment()<CR>
onoremap <silent> ac :<C-U>call TxtObjComment()<CR>

function! TxtObjComment()
	if exists("g:syntax_on")
		if !IsInComment()
			echomsg 'Not in a Comment region.'
			return 0
		else
			call cursor(SearchContinuousComment(0, line(".")))
			normal! 0V
			call cursor(SearchContinuousComment(1, line(".")))
		endif
	else
		echohl ErrorMsg | echoerr "TxtObjComment: syntax highlighting not enabled." | echohl None
	endif
endfunction


function! SearchContinuousComment(forward, lnum)
	let line = a:lnum
	while line > 0 && line <= line("$")
		let next = a:forward ? line + 1 : line - 1
		if next > 0 && next < line("$") && IsInComment(next)
			let line = next
		else
			break
		endif
	endwhile
	return [line, 0]
endfunction


function! IsInComment(...)
	let lnum = a:0 > 0 ? a:1 : line(".")
	let col = a:0 > 1 ? a:2 : indent(lnum) + 1
	let synStack =  synstack(lnum, col)
	let inComment = 0
	for syn in synStack
		if synIDattr(synIDtrans(syn), "name") ==# 'Comment'
			let inComment = 1
		endif
	endfor
	return inComment
endfunction

" }}}2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Filetype Specific: {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO: manage b:undo_ftplugin option
" TODO: refactor

":TOhtml    {{{2

let g:html_use_css = 1
let use_xhtml = 1

" }}}2   JavaScript   {{{2

function! s:js_rc()
	let b:tc_option = ''
	let g:SimpleJsIndenter_BriefMode = 1
	setlocal iskeyword+=$
	setlocal iskeyword-=58
	setlocal cindent
endfunction

" }}}2   CSS   {{{2

function! s:css_rc()
	set foldmethod=marker
	setlocal iskeyword-=58
endfunction

" }}}2   SCSS   {{{2

function! s:scss_rc()
	let b:tc_option = ''
	setlocal foldmethod=marker
	setlocal formatoptions=l2
endfunction

" }}}2   HAML   {{{2

function! s:haml_rc()
	inoremap <LocalLeader>br <br><CR>
	let b:tc_option = ''
	setlocal iskeyword-=58
endfunction

" }}}2   HTML   {{{2

function! s:html_rc()
	inoremap <LocalLeader>br <br><CR>
	let html_no_rendering = 1
	let g:html_indent_inctags = "html,body,head,tbody"
	let g:event_handler_attributes_complete = 0
	let g:rdfa_attributes_complete = 0
	let g:microdata_attributes_complete = 0
	let g:atia_attributes_complete = 0
	if exists('g:xmldata_html5')
		let b:html_omni_flavor = 'html5'
	end
endfunction

" }}}2   Ruby   {{{2

function! s:ruby_rc()
	let b:tc_option = ''
	setlocal cindent
	setlocal iskeyword-=58

	" |ft-ruby-omni|
	let g:rubycomplete_buffer_loading = 1
	let g:rubycomplete_classes_in_global = 1
	" let g:rubycomplete_rails = 1

	let g:ruby_operators = 0
	let g:ruby_space_errors = 1
	let g:ruby_no_expensive = 0
	let ruby_minlines = 70
endfunction

" }}}2   PHP   {{{2

function! s:php_rc()
	let php_asp_tags = 1
	let php_parent_error_close = 1
	let php_parent_error_open = 1
	setlocal iskeyword-=58 cindent
	set makeprg=php\ -l\ %
	set errorformat=%m\ in\ %f\ on\ line\ %l
endfunction

" }}}2   help   {{{2

function! s:help_rc()
	set number
	if version >= 703
		set conceallevel=1
		set concealcursor=nc
		set colorcolumn=+1
	endif
	nnoremap <silent> <buffer> <LocalLeader>= :call HelpHyperTextEntryJustify()<Enter>
endfunction

" }}}2   Vim   {{{2

function! s:vim_rc()
	let b:tc_option = ''
	" let g:vim_indent_cont = 0
	set path+=~/.vim/bundle
endfunction

" }}}2   zsh   {{{2

function! s:zsh_rc()
	let b:tc_option = ''
	setlocal iskeyword-=-
endfunction

" }}}2   git commit   {{{2

function! s:gitcommit_rc()
	setlocal textwidth=72
endfunction

" }}}2   git config   {{{2

function! s:gitconfig_rc()
	let b:tc_option = ''
endfunction

" }}}2   nginx config   {{{2

function! s:nginx_rc()
	let b:tc_option = ''
	setlocal iskeyword-=.
	setlocal iskeyword-=/
endfunction

" }}}2   yaml config   {{{2

function! s:yaml_rc()
	let b:tc_option = ''
endfunction

" }}}2   logs   {{{2

function! s:logs_rc()
endfunction

" }}}2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" => Autocommands: {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full)
" au BufNewFile,BufRead *.asp :set ft=aspjscript " all my .asp files ARE jscript
" au BufNewFile,BufRead *.tpl :set ft=html " all my .tpl files ARE html
" au BufNewFile,BufRead *.hta :set ft=html " all my .tpl files ARE html


" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示
if has("autocmd")
	autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
	autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
	autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
	" autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
	" autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim
	" autocmd Filetype html,xml,xsl source $VIM/vimfiles/plugin/closetag.vim

	" The syntax file for Vim add some colorations for jQuery keywords (empty clone hasClass hide
	" show animate ...) and for CSS selectors (:empty :hidden :selected :first ...).
	au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif

	" 自动更改到当前文件所在的目录
	autocmd BufEnter * lcd %:p:h
endif

" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt

" 让Vim可以自动断行,触发点是当前行已超过78个字符
autocmd FileType txt setlocal textwidth=78


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Useful abbrevs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xasp <%@ LANGUAGE = "VBScript" CodePage = 65001%><CR><%<CR><TAB><CR><BS>%><ESC><<O<TAB>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1
" 后期修正 {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 不忽略大小写
" set noignorecase

" set guioptions=egmrLtT "默认
" set guioptions= " 无菜单、工具栏

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}1


" Use local vimrc if available {{{
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif
" }}}

" Use local gvimrc if available and gui is running {{{
if has('gui_running') 
	if filereadable(expand("~/.gvimrc.local")) 
		source ~/.gvimrc.local
	endif
endif
" }}}

" vim: set sw=4 ts=4 sts=4 ft=vim syntax=vim foldmethod=marker foldlevel=0:
" vim: foldmethod=expr foldexpr=getline(v\:lnum-1)=~'^\\s*$'&&getline(v\:lnum)=~'\"\\{2,}'?'<1'\:1:
