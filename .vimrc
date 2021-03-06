" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
"             __   _  ____  _        _               _
"           //  \\/ |/__  || |  ____| |      __   __(_)_ __ ___
"           \\__//| |  / / | | / __/| | _____\ \ / /| | '_ ` _ \
"           //  \\| | / /_ | | | |_ | ||_____|\ V / | | | | | | |
"           \\__//|_|/____||_| \___\|_|        \_/  |_|_| |_| |_|
"
"   This is the personal .vimrc file of 812lcl.
"   You can find me at http://812lcl.com
" }

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        if WINDOWS()
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Silence impl warning when start vim {
        " https://github.com/vim/vim/issues/3117
        if has('python3')
            silent! python3 1
        endif
    "}

" }

" Use before config if available {
    if filereadable(expand("~/.vimrc.before"))
        source ~/.vimrc.before
    endif
" }

" Use vim-plug config {
    if filereadable(expand("~/.vimrc.plugins"))
        source ~/.vimrc.plugins
    endif
" }

" General {

    syntax on                       " 关键字上色
    syntax enable                   " 语法高亮
    filetype plugin indent on       " 必须有,打开文件类型检测

    set nu                          " 显示行号
    set nocp                        " 不兼容vi
    set hidden                      " 允许不保存切换buffer
    set splitright                  " 新分割窗口在右边
    set splitbelow                  " 新分割窗口在下边
    set autoread                    " 文件在Vim之外修改过，自动重新读入
    set autowrite                   " make时自动保存文件
    set timeoutlen=350              " 等待时间,如<leader>键后的输入
    set helpheight=20               " 查看帮助文档高度
    set scrolljump=1                " 当光标离开屏幕滑动行数
    set scrolloff=2                 " 保持在光标上下最少行数
    set showmatch                   " 短暂回显匹配括号
    set pastetoggle=<F8>            " 转换粘贴模式
    set hlsearch                    " 检索时高亮显示匹配项
    set incsearch                   " 边输入边搜索
    set ignorecase                  " 搜索忽略大小写
    set smartcase                   " 智能大小写搜索
    set wildmenu                    " 命令模式下补全以菜单形式显示
    set wildmode=list:longest,full  " 命令模式补全模式
    set nofoldenable                " 启动折叠
    set foldmethod=marker           " 设置折叠模式
    set completeopt=longest,menuone " 关掉补全时的预览窗口
    set encoding=utf-8              " 编码，使汉语正常显示
    set termencoding=utf-8
    " set termencoding=utf-8,gb18030,ucs-bom,cp936,gb2312,big5,euc-jp,euc-kr,latin1
    set fileencodings=utf-8,gb18030,ucs-bom,cp936,gb2312,big5,euc-jp,euc-kr,latin1
    set langmenu=zh_CN.UTF-8
    language message zh_CN.UTF-8
    set dict+=$HOME/.vim/static/dict_with_cases

    set mouse=v                     " Automatically enable mouse usage
    set mousehide                   " Hide the mouse cursor while typing
    scriptencoding utf-8

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before file:
    "   let g:lcl_no_autochdir = 1
    if !exists('g:lcl_no_autochdir')
        au BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    endif

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    au BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | exe "silent !chmod a+x <afile>" | endif
    au FileType vim setlocal keywordprg=:help

" }

" Vim UI {

    " GUI Settings {

        " GVIM- (here instead of .gvimrc)
        if has('gui_running')
            set guioptions-=m
            set guioptions-=T
            set guioptions-=r
            set guioptions-=L
            set mouse=a
            set lines=40                " 40 lines of text instead of 24
            source $VIMRUNTIME/delmenu.vim
            " au GUIEnter * simalt ~x

            if !exists("g:lcl_no_big_font")
                if LINUX()
                    set guifont=Sauce\ Code\ Powerline\ 13,Consolas\ Regular\ 13,Courier\ New\ Regular\ 14
                elseif OSX()
                    set guifont=Sauce\ Code\ Powerline\ 13,Consolas\ Regular:h13,Courier\ New\ Regular:h13
                elseif WINDOWS()
                    set guifont=Sauce\ Code\ Powerline\ 13,Consolas:h13,Courier_New:h13
                endif
            endif
        else
            set t_Co=256                    " 终端显示256色
        endif

    " }

    colorscheme solarized             " 载入皮肤主题
    if colors_name == 'molokai'
        let g:molokai_original = 1
    elseif colors_name == 'solarized' && filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="high"
        let g:solarized_visibility="normal"
        let g:solarized_hitrail=1
        if !has('gui_running')
            let g:solarized_termcolors=16
        endif
    endif

    set background=dark
    set noshowmode
    set tabpagemax=15               " 最多15个Tab
    set cursorline                  " 高亮当前行
    set list                        " 显示特殊符号
    set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:.

    hi clear SignColumn             " 标记列背景和主题背景匹配
    hi clear LineNr                 " 当前行列背景和主题背景匹配

    " hi Comment ctermfg=lightgrey guifg=lightgrey
    hi CursorLineNr ctermfg=red guifg=red
    hi VertSplit ctermbg=Grey ctermfg=Grey cterm=none guibg=Grey guifg=Grey
    hi Visual ctermbg=white ctermfg=darkgrey cterm=none guibg=cyan guifg=black
    hi DiffAdd ctermbg=blue ctermfg=white guibg=blue guifg=white
    hi DiffDelete ctermbg=green ctermfg=lightgrey guibg=green
    hi DiffChange ctermbg=red ctermfg=White guibg=red guifg=White
    hi DiffText ctermbg=yellow ctermfg=darkgrey guibg=yellow guifg=black

    if has('cmdline_info')
        set showcmd                 " 右下角显示当前操作
        set ruler                   " 右下角显示状态说明
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " 设定格式
    endif

    if has('statusline')
        set laststatus=1
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
        set statusline=%{anzu#search_status()}
    endif

" }

" Formatting {

    set expandtab                   " tab=空格
    set tabstop=4                   " tab缩进4个空格
    set shiftwidth=4                " 自动缩进空格数
    set softtabstop=4               " 退格删除缩进
    set autoindent                  " 与前一行同样等级缩进
    set backspace=indent,eol,start  " 退格可删除缩进和原有字符
    " au FileType python setlocal textwidth=100
    au FileType go setlocal ts=4 sts=4 sw=4 noet
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o       " 下一行不自动添加注释
    au BufLeave * let b:winview = winsaveview()                                     " 切换buffer时保持光标所在行在窗口中到位置
    au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" }

" Key (re)Mappings {

    let mapleader=","           " 映射<leader>键,默认'\'    remain x, z, c l p [ ] ; ' / 9 0; a v r o 6-8 for go; overwrite <F2> <c-p> K
    let maplocalleader=" "      " 映射<localleader>键       remain ' . 0~9
    inoremap jj <ESC>
    inoremap jjj <ESC>:w<CR>
    vnoremap > >gv
    vnoremap < <gv
    noremap <Leader>n ggVG
    noremap <Leader>du :diffupdate<CR>
    nnoremap <silent> J :bp<CR>
    nnoremap <silent> K :bn<CR>
    vnoremap <silent> J :m '>+1<CR>gv=gv
    vnoremap <silent> K :m '<-2<CR>gv=gv
    noremap <silent><Leader>h :noh<CR>
    noremap <silent><Leader>s :set rnu! rnu?<CR>
    noremap <silent><Leader>p :set spell! spell?<CR>
    noremap <silent><Leader><Leader>l :set list! list?<CR>
    nnoremap <LocalLeader>o @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
    nnoremap <LocalLeader>j <C-w>j:q<CR>
    nnoremap <LocalLeader>] :bd<CR>
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    nnoremap <silent> <C-p> K
    if OSX()
        nmap <silent> <LocalLeader>p <Plug>DashSearch
    endif

    " 更方便窗口间移动
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " 命令模式按键映射
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>
    cnoremap <C-p> <Up>
    cnoremap <C-n> <Down>
    nmap <Leader>W :w !sudo tee > /dev/null %<CR>
    command W w !sudo tee > /dev/null %

    " 修正易错命令
    command -bang -nargs=* Q q<bang>
    command -bang -nargs=* Wa wa<bang>
    command -bang -nargs=* WA wa<bang>
    command -bang -nargs=* -complete=file Wq wq<bang> <args>
    command -bang -nargs=* -complete=file WQ wq<bang> <args>

    " Markdown
    nnoremap <leader>1 m`yypVr=``
    nnoremap <leader>2 m`yypVr-``
    nnoremap <leader>3 m`^i### <esc>``4l
    nnoremap <leader>4 m`^i#### <esc>``5l
    nnoremap <leader>5 m`^i##### <esc>``6l

    nnoremap <leader>y :TagbarToggle<CR>:SignifyToggle<CR>:set nu! nu?<CR>:set list! list?<CR>:IndentLinesToggle<CR>

" }

" Plugins {

    " persistent_undo encoding {
        set nobackup noswapfile
        set history=200
        if has('persistent_undo')
            set undofile
            set undolevels=1000
            set undoreload=10000
            set undodir=~/.vim/.vimtmp/vimundo
        endif
        if has('nvim')
            set viminfo+=n$HOME/.vim/.vimtmp/nviminfo
        else
            set viminfo+=n$HOME/.vim/.vimtmp/viminfo
        endif
    " }

    " vim-airline {
        if isdirectory(expand("~/.vim/bundle/vim-airline/"))
            set laststatus=2                                    " 显示状态栏
            if has('gui_running')
                let g:airline_powerline_fonts = 0
            else
                let g:airline_powerline_fonts = 1
            endif
            if colors_name == 'molokai'
                let g:airline_theme='powerlineish'
            elseif colors_name == 'solarized'
                let g:airline_theme='solarized'
            endif
            let g:airline#extensions#tabline#enabled = 1        " 顶部tab栏显示
            let g:airline#extensions#tabline#tab_nr_type = 1
            let g:airline#extensions#tabline#show_tab_nr = 1
            let g:airline#extensions#tabline#show_tab_type = 1
            let g:airline#extensions#tabline#buffer_nr_show = 0

            let g:airline#extensions#whitespace#enabled = 1
            let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
            let g:airline#extensions#whitespace#trailing_format = 'trail[%s]'
            let g:airline#extensions#whitespace#mixed_indent_format = 'indent[%s]'
            let g:airline#extensions#whitespace#long_format = 'long[%s]'
            let g:airline#extensions#whitespace#mixed_indent_file_format = 'indent-f[%s]'

            if g:airline_powerline_fonts != 1
                let g:airline_left_sep=''
                let g:airline_right_sep=''
                let g:airline#extensions#tabline#left_sep=''
                let g:airline#extensions#tabline#right_sep=''
            endif

            function! AirlineInit()
                let g:airline_section_a = airline#section#create(['mode'])
                let g:airline_section_b = airline#section#create_left(['branch','hunks'])
                let g:airline_section_c = airline#section#create(['%f'])
                let g:airline_section_y = airline#section#create(['ffenc','%4b'])
                let g:airline_section_z = airline#section#create(['%P',':','%4l',',','%3c'])
            endfunction
            au VimEnter * call AirlineInit()
        endif
    " }

    " UndoTree {
        if isdirectory(expand("~/.vim/bundle/undotree/"))
            nmap <silent> <Leader>q :UndotreeToggle<CR>
            let g:undotree_SetFocusWhenToggle = 1
        endif
    " }

    " EasyMotion {
        if isdirectory(expand("~/.vim/bundle/vim-easymotion/"))
            map <Leader><Leader> <Plug>(easymotion-prefix)
            map f <Plug>(easymotion-overwin-f)
        endif
    " }

    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree/"))
            map <leader>wf :NERDTreeFind<CR>
            let NERDShutUp=1
            let NERDTreeWinPos=0                    " 在左侧
            let NERDTreeWinSize=25                  " 设置宽度
            let NERDTreeShowHidden=1                " 显示隐藏文件
            let NERDTreeQuitOnOpen=0                " 打开后退出NERDTree
            let NERDTreeShowBookmarks=1             " 显示书签
            let g:NERDTreeIgnore=[
                        \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
                        \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '\.out$',
                        \ ]
            let NERDTreeSortOrder=['\/$', 'BCLOUD', 'Makefile', '\.sh$', '\.py$', '\.rb$', '\.php$', '*', '\.xml$', '\.conf$', '\.log$', '\~$']
            au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
            " if !&diff
            "     au FileType c,cpp,python,java,vim,php,sh,perl,ruby,go,snippets,javascript nested :call ToggleNERDTree()
            " endif
        endif
    " }

    " nerdtree-git-plugin {
        if LINUX()
            let g:NERDTreeIndicatorMapCustom = {
                \ "Modified"  : "*",
                \ "Staged"    : "+",
                \ "Untracked" : "?",
                \ "Renamed"   : ">",
                \ "Unmerged"  : "═",
                \ "Deleted"   : "x",
                \ "Dirty"     : "✗",
                \ "Clean"     : "✔︎",
                \ "Unknown"   : "?"
                \ }
        elseif OSX() || WINDOWS()
            let g:NERDTreeIndicatorMapCustom = {
                \ "Modified"  : "✹",
                \ "Staged"    : "✚",
                \ "Untracked" : "✭",
                \ "Renamed"   : "➜",
                \ "Unmerged"  : "═",
                \ "Deleted"   : "✖",
                \ "Dirty"     : "✗",
                \ "Clean"     : "✔︎",
                \ "Unknown"   : "?"
                \ }
        endif
    " }

    " vim-easy-align {
        if isdirectory(expand("~/.vim/bundle/vim-easy-align/"))
            vmap <Enter> <Plug>(EasyAlign)
            nmap ga <Plug>(EasyAlign)
        endif
    " }

    " sessionman.vim {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
            let g:sessionman_save_on_exit = 0
            nmap <LocalLeader>y :SessionList<CR>
            nmap <LocalLeader>u :SessionSave<CR>
            nmap <LocalLeader>i :SessionClose<CR>
        endif
    " }

    " TagBar {
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <Leader>e :TagbarToggle<CR>
            let g:tagbar_left = 0                   " 在右侧
            let g:tagbar_width = 25                 " 设置宽度
            let g:tagbar_sort = 0                   " 按出现顺序排序
            let g:tagbar_iconchars = ['▸', '▾']
            let g:tagbar_autoshowtag = 1
            let g:tagbar_autoclose = 0
            let g:tagbar_autopreview = 0
            let g:tagbar_previewwin_pos = "rightbelow"
            " if !&diff
            "     au FileType c,cpp,python,java,vim,php,sh,perl,ruby,go,snippets,javascript nested :TagbarOpen
            " endif

            " If using go please install the gotags program
            let g:tagbar_type_go = {
                \ 'ctagstype' : 'go',
                \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
                    \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
                    \ 'r:constructor', 'f:functions' ],
                \ 'sro' : '.',
                \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
                \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
                \ 'ctagsbin'  : 'gotags',
                \ 'ctagsargs' : '-sort -silent'
                \ }
        endif
    "}

    " indentLine {
        if isdirectory(expand("~/.vim/bundle/indentLine/"))
            let g:indentLine_enabled=1
            nmap <Leader>g :IndentLinesToggle<CR>
        endif
    " }

    " Fugitive {
        if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
            nnoremap <Leader>gn :Unite output:echo\ system("git\ init")<CR>
            nnoremap <Leader>gs :Gstatus<CR>
            nnoremap <Leader>gw :Gwrite<CR>
            nnoremap <Leader>go :Gread<CR>
            nnoremap <Leader>gR :Gremove<CR>
            nnoremap <Leader>gm :Gmove<Space>
            nnoremap <Leader>gc :Gcommit<CR>
            nnoremap <Leader>gd :Gvdiff<CR>
            nnoremap <Leader>gb :Gblame<CR>
            nnoremap <Leader>gB :Gbrowse<CR>
            nnoremap <Leader>gp :Git! push<CR>
            nnoremap <Leader>gP :Git! pull<CR>
            nnoremap <Leader>gi :Git!<Space>
            nnoremap <Leader>ge :Gedit<CR>
            nnoremap <Leader>gE :Gedit<Space>
            nnoremap <Leader>gl :exe "silent Glog <Bar> Unite -no-quit
                        \ quickfix"<CR>:redraw!<CR>
            nnoremap <Leader>gL :exe "silent Glog -- <Bar> Unite -no-quit
                        \ quickfix"<CR>:redraw!<CR>
            nnoremap <Leader>gt :!tig<CR>:redraw!<CR>
            nnoremap <Leader>gS :exe "silent !shipit"<CR>:redraw!<CR>
            nnoremap <Leader>gg :exe 'silent Ggrep -i '.input("Pattern: ")<Bar>Unite
                        \ quickfix -no-quit<CR>
            nnoremap <Leader>ggm :exe 'silent Glog --grep='.input("Pattern: ").' <Bar>
                        \Unite -no-quit quickfix'<CR>
            nnoremap <Leader>ggt :exe 'silent Glog -S='.input("Pattern: ").' <Bar>
                        \Unite -no-quit quickfix'<CR>
            nnoremap <Leader>ggc :silent! Ggrep -i<Space>
            nnoremap <Leader>gcd :Gcd<CR>
            nnoremap <Leader>glc :Glcd<CR>

            if !exists(":Gdiffoff")
                command Gdiffoff diffoff | q | Gedit
            endif
            noremap <Leader>dq :Gdiffoff<CR>
        endif
    " }

    " signify {
        if isdirectory(expand("~/.vim/bundle/vim-signify/"))
            let g:signify_disable_by_default = 0
            let g:signify_line_highlight = 0
            let g:signify_vcs_list = [ 'git', 'svn' ]
            let g:signify_sign_add               = '+'
            let g:signify_sign_change            = '~'
            let g:signify_sign_delete            = '_'
            let g:signify_sign_delete_first_line = '‾'
            hi SignifySignAdd    ctermfg=blue
            hi SignifySignDelete ctermfg=green
            hi SignifySignChange ctermfg=red
            nmap gh <plug>(signify-next-hunk)
            nmap hg <plug>(signify-prev-hunk)
            omap ic <plug>(signify-motion-inner-pending)
            xmap ic <plug>(signify-motion-inner-visual)
            omap ac <plug>(signify-motion-outer-pending)
            xmap ac <plug>(signify-motion-outer-visual)
            nnoremap gt :SignifyToggle<CR>
            nnoremap hl :SignifyToggleHighlight<CR>
            nnoremap gr :SignifyRefresh<CR>
            nnoremap gd :SignifyDebug<CR>
        endif
    " }

    " Ctags {
        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif

        fun! MatchCaseTag()     " https://stackoverflow.com/questions/7640663/use-tjump-instead-of-tag-vim-on-pressing-ctrl
            let ic = &ic
            set noic
            try
                exe 'tjump ' . expand('<cword>')
            finally
                let &ic = ic
            endtry
        endfun
        nnoremap <silent> <c-]> :call MatchCaseTag()<CR>

        function s:FindFile(file)
            let curdir = getcwd()
            let found = curdir
            while !filereadable(a:file) && found != "/"
                cd ..
                let found = getcwd()
            endwhile
            execute "cd " . curdir
            return found
        endfunction

        let $CTAGS_DIR=s:FindFile("tags")
        let $CTAGS_DB=$CTAGS_DIR."/tags"
        if filereadable($CTAGS_DB)
            set tags+=$CTAGS_DB
        endif
    " }

    " vim-gutentags {
        if isdirectory(expand("~/.vim/bundle/vim-gutentags/"))
            let $GTAGSLABEL = 'native-pygments'
            let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
            let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
            let g:gutentags_ctags_tagfile = 'tags'
            let s:vim_tags = expand('~/.vim/.vimtmp/vimcache/tags')
            let g:gutentags_cache_dir = s:vim_tags

            let g:gutentags_modules = []
            if executable('ctags')
                let g:gutentags_modules += ['ctags']
            endif
            if executable('gtags-cscope') && executable('gtags')
                let g:gutentags_modules += ['gtags_cscope']
            endif

            " 配置 ctags 的参数
            let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
            let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
            let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

            " 如果使用 universal ctags 需要增加下面一行
            let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

            " 禁用 gutentags 自动加载 gtags 数据库的行为
            let g:gutentags_auto_add_gtags_cscope = 0

            if !isdirectory(s:vim_tags)
                silent! call mkdir(s:vim_tags, 'p')
            endif

            " let g:gutentags_define_advanced_commands = 1

            " https://github.com/ludovicchabant/vim-gutentags/issues/167
            au FileType gitcommit,gitrebase let g:gutentags_enabled=0
        endif
    " }

    " Cscope {
        if isdirectory(expand("~/.vim/bundle/gutentags_plus/"))    " 如果使用 gutentags_plus 则不自定义 cscope 操作
            noremap <silent> <Leader><Leader>g :GscopeFind g <C-R><C-W><cr>:Unite -silent -auto-preview -winheight=10 quickfix<CR>
            noremap <silent> <Leader><Leader>1 :GscopeFind g<Space>
            noremap <silent> <Leader><Leader>d :GscopeFind d <C-R><C-W><cr>:Unite -silent -auto-preview -winheight=10 quickfix<CR>
            noremap <silent> <Leader><Leader>2 :GscopeFind d<Space>
            noremap <silent> <Leader><Leader>c :GscopeFind c <C-R><C-W><cr>:Unite -silent -auto-preview -winheight=10 quickfix<CR>
            noremap <silent> <Leader><Leader>3 :GscopeFind c<Space>
            noremap <silent> <Leader><Leader>s :GscopeFind s <C-R><C-W><cr>:Unite -silent -auto-preview -winheight=10 quickfix<CR>
            noremap <silent> <Leader><Leader>0 :GscopeFind s<Space>
            noremap <silent> <Leader><Leader>4 :GscopeFind t <C-R><C-W><cr>:Unite -silent -auto-preview -winheight=10 quickfix<CR>
            noremap <silent> <Leader><Leader>6 :GscopeFind e <C-R><C-W><cr>:Unite -silent -auto-preview -winheight=10 quickfix<CR>
            noremap <silent> <Leader><Leader>7 :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>:Unite -silent -auto-preview -winheight=10 quickfix<CR>
            noremap <silent> <Leader><Leader>8 :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>:Unite -silent -auto-preview -winheight=10 quickfix<CR>
            noremap <silent> <Leader><Leader>k :GscopeKill<cr>
        else
            set cscopetag
            set cscopequickfix=s-,c-,d-,i-,t-,e-   " 使用QuickFix窗口来显示cscope查找结果
            let $CSCOPE_DIR=s:FindFile("cscope.out")
            let $CSCOPE_DB=$CSCOPE_DIR."/cscope.out"
            if filereadable($CSCOPE_DB)
                cs add $CSCOPE_DB $CSCOPE_DIR
            endif
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>1 :cs find g<Space>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>2 :cs find d<Space>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>3 :cs find c<Space>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>0 :cs find s<Space>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>4 :cs find t <C-R>=expand("<cword>")<CR><CR>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>6 :cs find e <C-R>=expand("<cword>")<CR><CR>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>7 :cs find f <C-R>=expand("<cfile>")<CR><CR>
            au BufEnter *.c,*.cpp,*.h nmap <Leader><Leader>8 :cs find i <C-R>=expand("<cfile>")<CR><CR>
        endif
    " }

    " Syntastic {
        if isdirectory(expand("~/.vim/bundle/syntastic/"))
            let g:syntastic_check_on_open = 0
            let g:syntastic_error_symbol = '✖'
            let g:syntastic_warning_symbol = '⚠'
            let g:syntastic_auto_loc_list = 2
            let g:syntastic_check_on_wq = 0
            let g:syntastic_always_populate_loc_list=1
            let g:syntastic_loc_list_height = 6
            let g:syntastic_enable_highlighting = 0
            let g:syntastic_mode_map = { 'mode': 'active', "passive_filetypes": ["go", "python"] }
            let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
            hi SyntasticError ctermbg=red guibg=red
            hi SyntasticWarning ctermbg=yellow guibg=yellow
            noremap <Leader>i :SyntasticCheck<CR>:Unite -silent -auto-preview -winheight=10 location_list<CR>
            au BufLeave *.py,*.go noremap <Leader>i :SyntasticCheck<CR>:Unite -silent -auto-preview -winheight=10 location_list<CR>
        endif
    " }

    " ale {
        if isdirectory(expand("~/.vim/bundle/ale/"))
            let g:ale_sign_error = get(g:, 'spacevim_error_symbol', '✖')
            let g:ale_sign_warning = get(g:,'spacevim_warning_symbol', '➤')
            let g:ale_sign_info = get(g:,'spacevim_info_symbol', '🛈')
            let g:ale_echo_msg_format = get(g:, 'ale_echo_msg_format', '%severity%: %linter%: %s')
            let g:ale_lint_on_text_changed = 'always'
            let g:ale_lint_delay = 750
        endif
    " }

    " echodoc {
        if isdirectory(expand("~/.vim/bundle/echodoc.vim/"))
            let g:echodoc#enable_at_startup = 1
        endif
    " }

    " Doxygentoolkit {
        let g:DoxygenToolkit_authorName="liuchunlei <812liuchunlei@163.com>"
        let g:DoxygenToolkit_briefTag_funcName="yes"
        let g:DoxygenToolkit_versionString="1.0.0.0"
        let g:doxygen_enhanced_color=1
        au BufEnter *.c,*.cpp,*.h map <F2> :DoxAuthor<CR>
        au BufEnter *.c,*.cpp,*.h map <F3> :Dox<CR>
    " }

    " OmniComplete {
        au FileType c set omnifunc=ccomplete#Complete
        au FileType java set omnifunc=javacomplete#Complete
        au FileType python set omnifunc=pythoncomplete#Complete
        au FileType php set omnifunc=phpcomplete#CompletePHP
        au FileType ruby set omnifunc=rubycomplete#Complete
        au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        au FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
        au FileType css set omnifunc=csscomplete#CompleteCSS
        au FileType xml set omnifunc=xmlcomplete#CompleteTags
        au FileType java inoremap <buffer> . .<C-X><C-O><C-P>
    " }

    " supertab {
        if isdirectory(expand("~/.vim/bundle/supertab"))
            let g:SuperTabMappingForward = '<s-tab>'
            let g:SuperTabMappingBackward = '<tab>'
        endif
    " }

    " YouCompleteMe {
        if isdirectory(expand("~/.vim/bundle/YouCompleteMe/"))
            au BufEnter *.c,*.cpp,*.java,*.py,*.php,*.go,*.sh,*.zsh set completefunc=youcompleteme#Complete
            let g:ycm_min_num_identifier_candidate_chars = 2
            let g:ycm_collect_identifiers_from_comments_and_strings = 1
            let g:ycm_confirm_extra_conf = 0                " 不用每次提示加载.ycm_extra_conf.py文件
            let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
            let g:ycm_show_diagnostics_ui = 0               " 关闭ycm的syntastic
            let g:ycm_filetype_whitelist = {'c': 1, 'cpp': 1, 'objc': 1, 'java': 1, 'python': 1, 'php': 1, 'go': 1, 'sh': 1, 'zsh': 1}
            let g:ycm_complete_in_comments = 1              " 评论中也应用补全
            let g:ycm_min_num_of_chars_for_completion = 1   " 两个字开始补全
            let g:ycm_seed_identifiers_with_syntax = 1
            let g:ycm_collect_identifiers_from_tags_files = 1
            let g:ycm_key_invoke_completion = '<c-z>'
            let g:ycm_use_ultisnips_completer = 1
            let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
            let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }
        endif
    " }

    " neocomplete or neocomplcache {
        if isdirectory(expand("~/.vim/bundle/neocomplete/"))
            let g:acp_enableAtStartup = 0
            let g:neocomplete#max_list = 15
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#enable_camel_case = 1
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete#enable_fuzzy_completion = 1
            let g:neocomplete#sources#syntax#min_keyword_length = 1
            let g:neocomplete#sources#dictionary#dictionaries = {'_' : $HOME.'/.vim/static/dict_with_cases'}
            if isdirectory(expand("~/.vim/bundle/YouCompleteMe/"))
                au Filetype c,cpp,java,python,php,go let g:neocomplete#enable_at_startup = 0
                au BufLeave *.c,*.cpp,*.java,*.py,*.php,*.go,*.sh,*.zsh set completefunc=neocomplete#complete
            endif
        elseif isdirectory(expand("~/.vim/bundle/neocomplcache/"))
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_max_list = 15
            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_smart_case = 1
            let g:neocomplcache_enable_camel_case_completion = 1
            let g:neocomplcache_enable_underbar_completion = 1
            let g:neocomplcache_enable_auto_delimiter = 1
            let g:neocomplcache_min_keyword_length = 1
            let g:neocomplcache_enable_fuzzy_completion = 1
            let g:neocomplcache_fuzzy_completion_start_length = 3
            let g:neocomplcache_dictionary_filetype_lists = {'_' : $HOME.'/.vim/static/dict_with_cases'}
            if isdirectory(expand("~/.vim/bundle/YouCompleteMe/"))
                au Filetype c,cpp,java,python,php,go let g:neocomplcache_enable_at_startup = 0
                au BufLeave *.c,*.cpp,*.java,*.py,*.php,*.go,*.sh,*.zsh set completefunc=neocomplcache#complete
            endif
        endif
        if isdirectory(expand("~/.vim/bundle/ultisnips/"))
            let g:UltiSnipsExpandTrigger = "<C-l>"
            let g:UltiSnipsEnableSnipMate = 1
            let g:UltiSnipsSnippetsDir = "~/.vim/mysnippets"
            let g:UltiSnipsSnippetDirectories = ["mysnippets", "UltiSnips"]
        endif
    " }

    " fencview {
        if isdirectory(expand("~/.vim/bundle/fencview/"))
            nmap <Leader>m :FencAutoDetect<CR>
        endif
    " }

    " emmet-vim {
        if isdirectory(expand("~/.vim/bundle/emmet-vim/"))
            let g:user_emmet_leader_key='<C-y>'
        endif
    " }

    " PIV {
        if isdirectory(expand("~/.vim/bundle/PIV"))
            let g:DisableAutoPHPFolding = 0
            let g:PIVAutoClose = 0
        endif
    " }

    " Misc {
        if isdirectory(expand("~/.vim/bundle/matchit.zip"))
            let b:match_ignorecase = 1
        endif
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }

    " Markdown {
        if isdirectory(expand("~/.vim/bundle/vim-markdown"))
            let g:vim_markdown_conceal = 0
            let g:vim_markdown_folding_disabled = 1
        endif
    " }

    " vim-polyglot {
        if isdirectory(expand("~/.vim/bundle/vim-polyglot"))
            let g:polyglot_disabled = ['markdown']
        endif
    " }

    " PyMode {
        if !has('python')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/bundle/python-mode")) && has('python')
            let g:pymode = 1
            let g:pymode_lint = 1
            let g:pymode_lint_on_write = 1
            let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pep8']
            let g:pymode_lint_ignore = "E501,F401,W0401,E265,C0301,W0511,w0621,C0111,W0622"
            let g:pymode_lint_todo_symbol = 'W'
            let g:pymode_lint_comment_symbol = 'C'
            let g:pymode_lint_visual_symbol = 'R'
            let g:pymode_lint_error_symbol = 'E'
            let g:pymode_lint_info_symbol = 'I'
            let g:pymode_lint_pyflakes_symbol = 'F'
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_doc = 1
            let g:pymode_doc_bind = '<C-p>'
            let g:pymode_folding = 1
            let g:pymode_motion = 1
            let g:pymode_indent = 1
            let g:pymode_virtualenv = 1
            let g:pymode_run = 0
            let g:pymode_breakpoint = 0
            let g:pymode_quickfix_minheight = 6
            let g:pymode_quickfix_maxheight = 10
            let g:pymode_syntax = 1
            let g:pymode_syntax_all = 1
            let g:pymode_syntax_string_formatting = g:pymode_syntax_all
            let g:pymode_syntax_string_format = g:pymode_syntax_all
            let g:pymode_syntax_string_templates = g:pymode_syntax_all
            let g:pymode_syntax_doctests = g:pymode_syntax_all
            let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
            let g:pymode_syntax_builtin_types = g:pymode_syntax_all
            let g:pymode_rope = 1
            let g:pymode_rope_lookup_project = 1
            let g:pymode_rope_completion = 0
            let g:pymode_rope_goto_definition_bind = '<Leader><Leader>g'
            let g:pymode_rope_organize_imports_bind = '<Leader><Leader>ro'
            let g:pymode_rope_rename_bind = '<leader><Leader>rr'
            let g:pymode_rope_rename_module_bind = '<leader><Leader>r1r'
            let g:pymode_rope_module_to_package_bind = '<leader><Leader>r1p'
            au BufEnter *.py noremap <Leader>i :PymodeLint<CR>:Unite -silent -auto-preview -winheight=10 location_list<CR>
            noremap <Leader>u :PymodeLintAuto<CR>
        endif
    " }

    " Go {
        if isdirectory(expand("~/.vim/bundle/vim-go"))
            let g:go_fmt_autosave = 1
            let g:go_fmt_fail_silently = 0
            let g:go_fmt_command = "goimports"
            let g:go_list_type = "locationlist"
            let g:go_snippet_case_type = "camelcase"
            let g:go_addtags_transform = "camelcase"
            let g:go_def_reuse_buffer = 1

            let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
            let g:go_metalinter_autosave = 1
            let g:go_metalinter_autosave_enabled = ['vet', 'golint']
            let g:go_metalinter_deadline = "5s"

            let g:go_highlight_types = 1
            let g:go_highlight_fields = 1
            let g:go_highlight_functions = 1
            let g:go_highlight_methods = 1
            let g:go_highlight_build_constraints = 1
            let g:go_highlight_generate_tags = 1

            let g:go_template_autocreate = 0
            let g:go_doc_keywordprg_enabled = 0
            let g:go_auto_sameids = 0
            " let g:go_auto_type_info = 1
            " set updatetime=100

            au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
            au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
            au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')

            au BufEnter *.go nnoremap <Leader>i :GoMetaLinter<CR>
            au BufEnter *.go nnoremap <silent> <C-p> :GoDoc<CR>
            au BufLeave *.go nnoremap <silent> <C-p> K
            au BufEnter *.go nnoremap <LocalLeader>; :GoInfo<CR>
            au BufEnter *.go nnoremap <Leader>r :GoRun<CR>
            au BufEnter *.go nnoremap <Leader>o :GoSameIdsAutoToggle<CR>
            au BufEnter *.go nmap <Leader><Leader>g :GoDef<CR>
            au BufEnter *.go nmap <Leader><Leader>d :GoCallees<CR>
            au BufEnter *.go nmap <Leader><Leader>c :GoCallers<CR>
            au BufEnter *.go nmap <Leader><Leader>s :GoImplements<CR>
            au BufEnter *.go nmap <Leader><Leader>1 :GoDescribe<CR>
            au BufEnter *.go nmap <Leader>a <Plug>(go-test)
            au BufEnter *.go nmap <Leader>v <Plug>(go-coverage-toggle)
            au BufEnter *.go nmap <Leader>6 :GoAddTags<CR>
            au BufEnter *.go nmap <Leader>7 :GoRemoveTags<CR>
            au BufEnter *.go vmap <Leader>7 :GoRemoveTags<CR>
            au BufEnter *.go nmap <Leader>8 gv:GoAddTags<CR>

            " run :GoBuild or :GoTestCompile based on the go file
            function! s:build_go_files()
                let l:file = expand('%')
                if l:file =~# '^\f\+_test\.go$'
                    call go#cmd#Test(0, 1)
                elseif l:file =~# '^\f\+\.go$'
                    call go#cmd#Build(0)
                endif
            endfunction

            " au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
        endif
    " }

    " vim-youdao-translater {
        if isdirectory(expand("~/.vim/bundle/vim-youdao-translater"))
            nmap <LocalLeader>d :Ydc<CR>
            nmap <Leader><Leader>e :Yde<CR>
            nmap <Leader><Leader>v :Ydv<CR>
        endif
    " }

    " vim-nerdtree-syntax-highlight {
        if isdirectory(expand("~/.vim/bundle/vim-nerdtree-syntax-highlight"))
            let g:NERDTreeFileExtensionHighlightFullName = 1
            let g:NERDTreeExactMatchHighlightFullName = 1
            let g:NERDTreePatternMatchHighlightFullName = 1
            let g:NERDTreeLimitedSyntax = 1
        endif
    " }

    " vim-devicons {
        if isdirectory(expand("~/.vim/bundle/vim-devicons/"))
            let g:webdevicons_enable = 1
            let g:WebDevIconsUnicodeDecorateFolderNodes = 1
            let g:DevIconsEnableFoldersOpenClose = 1
            let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '.'
            let g:DevIconsDefaultFolderOpenSymbol = '.'
            let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
        endif
    " }

    " vim-anzu {
        if isdirectory(expand("~/.vim/bundle/vim-anzu/"))
            nmap n <Plug>(anzu-n-with-echo)
            nmap N <Plug>(anzu-N-with-echo)
            nmap * <Plug>(anzu-star-with-echo)
            nmap # <Plug>(anzu-sharp-with-echo)
            let g:anzu_status_format = "%p (%i/%l)"
            let g:airline#extensions#anzu#enabled = 0
        endif
    " }

    " menu {
        if filereadable(expand("~/.vimrc.menu"))
            source ~/.vimrc.menu
        endif
    " }

    " Unite {
        if isdirectory(expand("~/.vim/bundle/unite.vim/"))
            au FileType unite call s:unite_settings()
            function! s:unite_settings()
                imap <buffer> <C-j> <Plug>(unite_select_next_line)
                imap <buffer> <C-k> <Plug>(unite_select_previous_line)
                nmap <buffer> <C-h> <C-w>h
                nmap <buffer> <C-j> <C-w>j
                nmap <buffer> <C-k> <C-w>k
                nmap <buffer> <C-l> <C-w>l
            endfunction

            nmap <silent> <Leader>ff :Unite file_rec/async -start-insert<CR>
            nmap <silent> <Leader>fr :Unite file_mru -start-insert<CR>
            nmap <silent> <Leader>fd :Unite -start-insert directory_rec/async<CR>
            nmap <silent> <Leader>fb :Unite buffer<CR>
            nnoremap <LocalLeader>q :Unite register<CR>
            nnoremap <LocalLeader>z :Unite -silent -auto-preview -winheight=10 quickfix<CR>
            nnoremap <LocalLeader>x :Unite -silent -auto-preview -winheight=10 location_list<CR>
            nnoremap <silent><Leader>k :Unite -silent -auto-preview -winheight=10 mark<CR>
            nnoremap <silent><Leader><Leader>A :Unite -silent -auto-preview -winheight=10 grep<CR>
            nnoremap <silent><Leader><Leader>a :UniteWithCursorWord -silent -auto-preview -winheight=10 grep<CR><CR>

            call unite#filters#matcher_default#use(['matcher_fuzzy'])
            call unite#filters#sorter_default#use(['sorter_rank'])
            call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
                        \ 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/'], '\|'))
            call unite#custom#profile('default', 'context', {
                        \   'prompt' : '>>> ',
                        \   'prompt_direction' : 'top',
                        \   'start_insert' : 0,
                        \   'auto_resize' : 1,
                        \   'update_time' : 200
                        \ })
            let g:unite_marked_icon = '✓'
            let g:unite_split_rule = 'botright'
            let g:unite_source_history_yank_enable = 1
            let g:unite_force_overwrite_statusline = 0
            let g:unite_data_directory = $HOME.'/.vim/.vimtmp/unite'
            let g:unite_source_buffer_time_format = '(%d-%m-%Y %H:%M:%S) '
            let g:unite_source_file_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
            let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '

            if executable('ag')
                let g:unite_source_grep_command='ag'
                let g:unite_source_grep_default_opts='--nocolor --nogroup -a -S'
                let g:unite_source_grep_recursive_opt=''
            elseif executable('ack')
                let g:unite_source_grep_command='ack'
                let g:unite_source_grep_default_opts='--no-group --no-color'
                let g:unite_source_grep_recursive_opt=''
            endif
        endif
    " }

    " Denite {
        if isdirectory(expand("~/.vim/bundle/denite.nvim/"))
            nmap <silent> <Leader>fb :Denite buffer<CR>
            nmap <silent> <Leader>fe :Denite register<CR>
            nmap <silent> <Leader>ff :Denite file/rec<CR>
            nmap <silent> <Leader>fd :Denite directory_rec<CR>
            nmap <silent> <Leader>fj :Denite jump change<CR>
            nmap <silent> <Leader>fr :Denite file_mru<CR>
            nmap <silent> <Leader>fl :Denite location_list<CR>
            nmap <silent> <Leader>fq :Denite quickfix<CR>
            nmap <silent> <Leader>fm :Denite output:messages<CR>
            nmap <silent> <Leader>fo :Denite outline<CR>
            nmap <silent> <Leader>fk :Denite -auto-preview -vertical-preview mark<CR>
            nmap <silent> <Leader><Leader>a :DeniteCursorWord -auto-preview grep<CR>

            let ignore=&wildignore .
                \ ',*.pyc,.git,.hg,.svn'
            call denite#custom#var('file/rec', 'command',
                \ ['scantree.py', '--ignore', ignore])

            if executable('ag')
                call denite#custom#var('grep', 'command', ['ag'])
                call denite#custom#var('grep', 'default_opts',
                        \ ['--skip-vcs-ignores', '--vimgrep', '--smart-case', '--hidden'])
                call denite#custom#var('grep', 'recursive_opts', [])
                call denite#custom#var('grep', 'pattern_opt', [])
                call denite#custom#var('grep', 'separator', ['--'])
                call denite#custom#var('grep', 'final_opts', [])
            elseif executable('ack')
                call denite#custom#var('grep', 'command', ['ack'])
                call denite#custom#var('grep', 'default_opts',
                        \ ['--ackrc', $HOME.'/.ackrc', '-H',
                        \  '--nopager', '--nocolor', '--nogroup', '--column'])
                call denite#custom#var('grep', 'recursive_opts', [])
                call denite#custom#var('grep', 'pattern_opt', ['--match'])
                call denite#custom#var('grep', 'separator', ['--'])
                call denite#custom#var('grep', 'final_opts', [])
            endif
        endif
    " }

    " vim-choosewin {
        if isdirectory(expand("~/.vim/bundle/vim-choosewin"))
            nmap - <Plug>(choosewin)
            " use overlay feature
            let g:choosewin_overlay_enable = 1

            " workaround for the overlay font being broken on mutibyte buffer.
            let g:choosewin_overlay_clear_multibyte = 1

            " tmux-like overlay color
            let g:choosewin_color_overlay = {
                        \ 'gui': ['DodgerBlue3', 'DodgerBlue3'],
                        \ 'cterm': [25, 25]
                        \ }
            let g:choosewin_color_overlay_current = {
                        \ 'gui': ['firebrick1', 'firebrick1'],
                        \ 'cterm': [124, 124]
                        \ }

            let g:choosewin_blink_on_land      = 0 " don't blink at land
            let g:choosewin_statusline_replace = 0 " don't replace statusline
            let g:choosewin_tabline_replace    = 0 " don't replace tabline
        endif
    " }

    " vim-startify {
        if isdirectory(expand("~/.vim/bundle/vim-startify"))
            au User Startified setlocal buflisted
            au User Startified setlocal cursorline
            au User Startified setlocal buftype=nofile
            nnoremap <LocalLeader>[ :Startify<CR>
            let g:startify_custom_header = [
                        \'             __   _  ____  _        _               _',
                        \'           //  \\/ |/__  || |  ____| |      __   __(_)_ __ ___',
                        \'           \\__//| |  / / | | / __/| | _____\ \ / /| | `_ ` _ \',
                        \'           //  \\| | / /_ | | | |_ | ||_____|\ V / | | | | | | |',
                        \'           \\__//|_|/____||_| \___\|_|        \_/  |_|_| |_| |_|',
                        \]
            let g:startify_custom_footer =
                        \ ['', "   Vim is charityware. Please read ':help uganda'.", '']
            let g:startify_list_order = [
                        \ ['   Recent Files:'],
                        \ 'files',
                        \ ['   Project:'],
                        \ 'dir',
                        \ ['   Sessions:'],
                        \ 'sessions',
                        \ ['   Bookmarks:'],
                        \ 'bookmarks',
                        \ ['   Commands:'],
                        \ 'commands',
                        \ ]
            let g:startify_bookmarks = [
                        \ { 'v': '~/.vimrc' },
                        \ { 'z': '~/.zshrc' },
                        \ { 't': '~/.tmux.conf' },
                        \ { 'p': '~/.vimrc.plugins' },
                        \ { 'm': '~/.vimrc.menu' },
                        \ ]
            let g:startify_change_to_vcs_root = 0
            let g:startify_files_number = 7
            let g:startify_session_dir = '~/.vim/sessions'
            let g:startify_update_oldfiles = 1
        endif
    " }

    " vim-leader-guide {
        if isdirectory(expand("~/.vim/bundle/vim-leader-guide"))
            let g:all_key_map    = {}
            let g:leaderGuide_max_size = 20
            let g:leaderGuide_submode_mappings = { '<C-C>': 'win_close', '<C-F>': 'page_down', '<C-B>': 'page_up'}
            map <leader>. <Plug>leaderguide-global
            call leaderGuide#register_prefix_descriptions('', 'g:all_key_map')
        endif
    " }

    " auto-pairs {
        if isdirectory(expand("~/.vim/bundle/auto-pairs/"))
            let g:AutoPairsShortcutToggle = '<C-q>'
            let g:AutoPairsFlyMode = 0
        endif
    " }

    " vim-keysound {
        if isdirectory(expand("~/.vim/bundle/vim-keysound/"))
            let g:keysound_enable = 1
            let g:keysound_theme = 'default'    " default, typewriter, mario, bubble, sword
            let g:keysound_volume = 1000
        endif
    " }
" }

" Functions {

    " Initialize directories {
        function! InitializeDirectories()
            let parent = $HOME
            let prefix = 'vim'
            let dir_list = {
                        \ 'cache': '',
                        \ 'backup': 'backupdir',
                        \ 'views': 'viewdir',
                        \ 'swap': 'directory' }

            if has('persistent_undo')
                let dir_list['undo'] = 'undodir'
            endif

            " To specify a different directory in which to place the vimbackup,
            " vimviews, vimundo, and vimswap files/directories, add the following to
            " your .vimrc.before.local file:
            "   let g:lcl_consolidated_directory = <full path to desired directory>
            "   eg: let g:lcl_consolidated_directory = $HOME . '/.vim/'
            if exists('g:lcl_consolidated_directory')
                let common_dir = g:lcl_consolidated_directory . prefix
            else
                let common_dir = parent . '/.vim/.vimtmp/' . prefix
            endif

            for [dirname, settingname] in items(dir_list)
                let directory = common_dir . dirname . '/'
                if exists("*mkdir")
                    if !isdirectory(directory)
                        call mkdir(directory)
                    endif
                endif
                if !isdirectory(directory)
                    echo "Warning: Unable to create backup directory: " . directory
                    echo "Try: mkdir -p " . directory
                elseif settingname != ''
                    let directory = substitute(directory, " ", "\\\\ ", "g")
                    exec "set " . settingname . "=" . directory
                endif
            endfor
        endfunction
        call InitializeDirectories()
    " }

    " Shell command {
        function! s:RunShellCommand(cmdline)
            botright new

            setlocal buftype=nofile
            setlocal bufhidden=delete
            setlocal nobuflisted
            setlocal noswapfile
            setlocal nowrap
            setlocal filetype=shell
            setlocal syntax=shell

            call setline(1, a:cmdline)
            call setline(2, substitute(a:cmdline, '.', '=', 'g'))
            execute 'silent $read !' . escape(a:cmdline, '%#')
            setlocal nomodifiable
            1
        endfunction

        command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
        " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

    " Preserve {
        function! Preserve(command)
            let _s=@/
            let l = line(".")
            let c = col(".")
            execute a:command
            let @/=_s
            call cursor(l, c)
        endfunction
        nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
        nmap _# :call Preserve("%s/\\r$//e")<CR>
        nmap _@ :retab<CR>
        nmap _% :retab<CR>:call Preserve("%s/\\r$//e")<CR>:call Preserve("%s/\\s\\+$//e")<CR>gg=G
        nmap <Leader>= :call Preserve("normal gg=G")<CR>
    " }

    " Search {
        function! s:VSetSearch()
            let temp = @s
            norm! gv"sy
            let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
            let @s = temp
        endfunction
        xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
        xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
        xnoremap <Leader>j :s@\%V@@gn<Left><Left><Left><Left>
        nnoremap <Leader>j :%s@@@gn<Left><Left><Left><Left><CR>
    " }

    " ToogleColorColumn {
        function! g:ToggleColorColumn()
            if &colorcolumn != ''
                setlocal colorcolumn&
            else
                setlocal colorcolumn=100
                hi colorcolumn ctermbg=grey guibg=grey
            endif
        endfunction
        nnoremap <LocalLeader>l :call g:ToggleColorColumn()<CR>
    " }

    " Quickfix {
     " https://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim/5686810#5686810
        command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
        function! QuickfixFilenames()
          let buffer_numbers = {}
          for quickfix_item in getqflist()
            let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
          endfor
          return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
        endfunction
        au FileType qf wincmd J
    " }

    " TitleInsert {
        function! TitleInsert()
            if( &filetype == "python" )
                call setline(1,"#!/usr/bin/env python")
                call setline(2,"# -*- coding: utf-8 -*-")
                call append(2,'"""')
                call append(3,"@file    : " . expand('%:t'))
                call append(4,"@brief   : ")
                call append(5,"@author  : liuchunlei <812liuchunlei@163.com>")
                call append(6,"@date    : " . strftime("%Y-%m-%d %H:%M:%S"))
                call append(7,"@update  : " . strftime("%Y-%m-%d %H:%M:%S"))
                call append(8,"@version : 1.0.0.0")
                call append(9,'"""')
            endif
        endfunction

        function! DateInsert()
            call cursor(7,1)
            if search('@update  : ') != 0
                let line = line('.')
                call setline(line,"@update  : " . strftime("%Y-%m-%d %H:%M:%S"))
            endif
        endfunction

        au BufEnter *.py map <F2> :call TitleInsert()<CR>5GA
        au FileWritePre,BufWritePre *.py ks|call DateInsert()|'s
    " }

    " Indent Python in the Google way {
        setlocal indentexpr=GetGooglePythonIndent(v:lnum)

        let s:maxoff = 50 " maximum number of lines to look backwards.

        function GetGooglePythonIndent(lnum)

            " Indent inside parens.
            " Align with the open paren unless it is at the end of the line.
            " E.g.
            "   open_paren_not_at_EOL(100,
            "                         (200,
            "                          300),
            "                         400)
            "   open_paren_at_EOL(
            "       100, 200, 300, 400)
            call cursor(a:lnum, 1)
            let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
                        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
                        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
                        \ . " =~ '\\(Comment\\|String\\)$'")
            if par_line > 0
                call cursor(par_line, 1)
                if par_col != col("$") - 1
                    return par_col
                endif
            endif

            " Delegate the rest to the original function.
            return GetPythonIndent(a:lnum)

        endfunction

        let pyindent_nested_paren="&sw*2"
        let pyindent_open_paren="&sw*2"
    " }

    " 以下function有外部依赖 {

        " Linesofcode {
            function! LinesOfCode()                         " 统计代码行数，需要cloc
                echo system('cloc --quiet '.bufname("%"))
            endfunction
        " }

        " Rangerchooser {
            function! RangerChooser()                       " Ranger文件管理器
                exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
                if filereadable('/tmp/chosenfile')
                    exec 'edit ' . system('cat /tmp/chosenfile')
                    call system('rm /tmp/chosenfile')
                endif
                redraw!
            endfunction
            map <LocalLeader>r :call RangerChooser()<CR>
        " }

        " nerdtree and tagbar {
            function! ToggleNERDTreeAndTagbar()
                let w:jumpbacktohere = 1

                " Detect which plugins are open
                if exists('t:NERDTreeBufName')
                    let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
                else
                    let nerdtree_open = 0
                endif
                let tagbar_open = bufwinnr('__Tagbar__') != -1

                " Perform the appropriate action
                if nerdtree_open && tagbar_open
                    NERDTreeClose
                elseif nerdtree_open
                    TagbarOpen
                elseif tagbar_open
                    NERDTreeFind
                else
                    NERDTreeFind
                    TagbarOpen
                endif

                " Jump back to the original window
                for window in range(1, winnr('$'))
                    execute window . 'wincmd w'
                    if exists('w:jumpbacktohere')
                        unlet w:jumpbacktohere
                        break
                    endif
                endfor
            endfunction
            nnoremap <leader>we :call ToggleNERDTreeAndTagbar()<CR>

            function! ToggleNERDTreeFind()
                let w:jumpbacktohere = 1
                NERDTreeFind
                " Jump back to the original window
                for window in range(1, winnr('$'))
                    execute window . 'wincmd w'
                    if exists('w:jumpbacktohere')
                        unlet w:jumpbacktohere
                        break
                    endif
                endfor
            endfunction

            function! ToggleNERDTree()
                if &ft =~ 'tagbar\|nerdtree\|unite\|qf' || buffer_name("%") == '[Command Line]'
                    return
                endif
                let w:jumpbacktohere = 1
                NERDTreeToggle
                " Jump back to the original window
                for window in range(1, winnr('$'))
                    execute window . 'wincmd w'
                    if exists('w:jumpbacktohere')
                        unlet w:jumpbacktohere
                        break
                    endif
                endfor
            endfunction
            nnoremap <leader>w :call ToggleNERDTree()<CR>

            " Zoom / Restore window.
            function! s:ZoomToggle() abort
                if exists('t:zoomed') && t:zoomed
                    execute t:zoom_winrestcmd
                    let t:zoomed = 0
                else
                    let t:zoom_winrestcmd = winrestcmd()
                    resize
                    vertical resize
                    let t:zoomed = 1
                endif
            endfunction
            command! ZoomToggle call s:ZoomToggle()
            nnoremap <silent> <Leader>d :ZoomToggle<CR>
        " }
    " }
" }
