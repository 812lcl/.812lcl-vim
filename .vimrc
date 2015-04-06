" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker :
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
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

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
    set timeoutlen=350              " 等待时间,如<leader>键后的输入
    "set helpheight=30               " 查看帮助文档全屏
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
    set foldenable                  " 启动折叠
    set foldmethod=marker           " 设置折叠模式
    set completeopt=longest,menuone " 关掉补全时的预览窗口
    set encoding=utf-8              " 编码，使汉语正常显示
    set termencoding=utf-8,gb18030,ucs-bom,cp936,gb2312,big5,euc-jp,euc-kr,latin1
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
            au GUIEnter * simalt ~x

            if !exists("g:lcl_no_big_font")
                if LINUX()
                    set guifont=Sauce\ Code\ Powerline\ 13,Consolas\ Regular\ 13,Courier\ New\ Regular\ 14,Andale\ Mono\ Regular\ 13,Menlo\ Regular\ 13
                elseif OSX()
                    set guifont=Sauce\ Code\ Powerline\ 13,Consolas\ Regular:h13,Courier\ New\ Regular:h13,Andale\ Mono\ Regular:h13,Menlo\ Regular:h13
                elseif WINDOWS()
                    set guifont=Sauce\ Code\ Powerline\ 13,Consolas:h13,Courier_New:h13,Andale_Mono:h13,Menlo:h13
                endif
            endif
        else
            set t_Co=256                    " 终端显示256色
        endif

    " }

    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        colorscheme solarized               " 载入皮肤主题
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
    set tabpagemax=15               " 最多15个Tab
    set showmode                    " 显示当前mode
    set cursorline                  " 高亮当前行
    set list                        " 显示特殊符号
    set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:.

    hi clear SignColumn             " 标记列背景和主题背景匹配
    hi clear LineNr                 " 当前行列背景和主题背景匹配

    hi CursorLineNr ctermfg=red guifg=red
    hi VertSplit ctermbg=Grey ctermfg=Grey cterm=none guibg=Grey guifg=Grey
    hi Visual ctermbg=cyan ctermfg=white cterm=none guibg=cyan guifg=black
    hi Comment ctermfg=lightgrey guifg=lightgrey
    hi DiffAdd ctermbg=blue ctermfg=white guibg=blue guifg=white
    hi DiffDelete ctermbg=green ctermfg=lightgrey guibg=green
    hi DiffChange ctermbg=red ctermfg=White guibg=red guifg=White
    hi DiffText ctermbg=yellow ctermfg=lightgrey guibg=yellow guifg=black

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
    endif

" }

" Formatting {

    set expandtab                   " tab=空格
    set tabstop=4                   " tab缩进4个空格
    set shiftwidth=4                " 自动缩进空格数
    set softtabstop=4               " 退格删除缩进
    set autoindent                  " 与前一行同样等级缩进
    set backspace=indent,eol,start  " 退格可删除缩进和原有字符
    au FileType ruby setlocal ts=2 sts=2 sw=2 et
    au FileType yaml setlocal ts=2 sts=2 sw=2 et
    au FileType html setlocal ts=2 sts=2 sw=2 et
    au FileType css setlocal ts=2 sts=2 sw=2 et
    au FileType python setlocal textwidth=100
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o       " 下一行不自动添加注释
    au BufLeave * let b:winview = winsaveview()                                     " 切换buffer时保持光标所在行在窗口中到位置
    au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" }

" Key (re)Mappings {

    let mapleader=","           " 映射<leader>键,默认'\'
    let maplocalleader=" "      " 映射<localleader>键
    inoremap jj <ESC>
    vnoremap > >gv
    vnoremap < <gv
    noremap <Leader>x :lnext<CR>
    noremap <Leader>z :lpre<CR>
    noremap <Leader>p :lclose<CR>
    noremap <Leader>m ggVG
    nnoremap <silent> J :bp<CR>
    nnoremap <silent> K :bn<CR>
    noremap <silent><Leader>h :noh<CR>
    noremap <silent><Leader>s :set rnu! rnu?<CR>
    noremap <silent><Leader>l :set list! list?<CR>
    noremap <silent><Leader>v :set spell! spell?<CR>
    nnoremap <LocalLeader>o @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
    nnoremap <LocalLeader>j <C-w>j:q<CR>
    nnoremap <LocalLeader>; :cw<CR>
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
    cmap w!! SudoWrite %

    " 修正易错命令
    command -bang -nargs=* Q q<bang>
    command -bang -nargs=* Wa wa<bang>
    command -bang -nargs=* WA wa<bang>
    command -bang -nargs=* -complete=file W w<bang> <args>
    command -bang -nargs=* -complete=file Wq wq<bang> <args>
    command -bang -nargs=* -complete=file WQ wq<bang> <args>

" }

" Plugins {

    " persistent_undo encoding {
        set nobackup noswapfile
        set history=200
        if has('persistent_undo')
            set undofile
            set undolevels=1000
            set undoreload=10000
            set undodir=~/.vim/.vimtmp/undo
        endif
        set viminfo+=n$HOME/.vim/.vimtmp/viminfo
        if isdirectory(expand("~/.vim/bundle/fencview/"))
            let g:fencview_autodetect = 0
        endif
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " Cscope {
        set cscopetag
        set cscopequickfix=s-,c-,d-,i-,t-,e-   " 使用QuickFix窗口来显示cscope查找结果
        if filereadable("cscope.out")
            cs add cscope.out
        elseif filereadable("tags")
            set tags=$PWD/tags
        endif
        nmap <Leader><Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <Leader><Leader>1 :cs find g<Space>
        nmap <Leader><Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
        nmap <Leader><Leader>2 :cs find d<Space>
        nmap <Leader><Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <Leader><Leader>3 :cs find c<Space>
        nmap <Leader><Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <Leader><Leader>0 :cs find s<Space>
        nmap <Leader><Leader>4 :cs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <Leader><Leader>6 :cs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <Leader><Leader>7 :cs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <Leader><Leader>8 :cs find i <C-R>=expand("<cfile>")<CR><CR>
    " }

    " vim-airline {
        if isdirectory(expand("~/.vim/bundle/vim-airline/"))
            set laststatus=2                                    " 显示状态栏
            if has('gui_running')
                let g:airline_powerline_fonts = 0               " 是否使用powerline字体
            else
                let g:airline_powerline_fonts = 1
            endif
            let g:airline_theme='solarized'                     " 设置主题
            let g:airline#extensions#tabline#enabled = 1        " 顶部tab栏显示
            let g:airline#extensions#tabline#tab_nr_type = 1
            let g:airline#extensions#tabline#show_tab_nr = 1
            let g:airline#extensions#tabline#show_tab_type = 1
            let g:airline#extensions#tabline#buffer_nr_show = 0

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
            map f <Plug>(easymotion-f)
            map F <Plug>(easymotion-F)
        endif
    " }

    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree/"))
            map <Leader>wf :NERDTreeToggle<CR>
            map <leader>w :NERDTreeFind<CR>
            let NERDShutUp=1
            let NERDTreeWinPos=0                    " 在左侧
            let NERDTreeWinSize=30                  " 设置宽度
            let NERDTreeShowHidden=1                " 显示隐藏文件
            let NERDTreeQuitOnOpen=1                " 打开后退出NERDTree
            let NERDTreeShowBookmarks=1             " 显示书签
            let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
            au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
            " au VimEnter * NERDTree
        endif
    " }

    " Tabularize {
        if isdirectory(expand("~/.vim/bundle/tabular/"))
            nmap <LocalLeader>& :Tabularize /&<CR>
            vmap <LocalLeader>& :Tabularize /&<CR>
            nmap <LocalLeader>= :Tabularize /=<CR>
            vmap <LocalLeader>= :Tabularize /=<CR>
            nmap <LocalLeader>: :Tabularize /:<CR>
            vmap <LocalLeader>: :Tabularize /:<CR>
            nmap <LocalLeader>:: :Tabularize /:\zs<CR>
            vmap <LocalLeader>:: :Tabularize /:\zs<CR>
            nmap <LocalLeader>, :Tabularize /,<CR>
            vmap <LocalLeader>, :Tabularize /,<CR>
            nmap <LocalLeader>,, :Tabularize /,\zs<CR>
            vmap <LocalLeader>,, :Tabularize /,\zs<CR>
            nmap <LocalLeader><Bar> :Tabularize /<Bar><CR>
            vmap <LocalLeader><Bar> :Tabularize /<Bar><CR>
        endif
    " }

    " sessionman.vim {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        "set viewoptions=folds,options,cursor,unix,slash                 " restore_view.vim
        if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
            nmap <LocalLeader>y :SessionList<CR>
            nmap <LocalLeader>u :SessionSave<CR>
            nmap <LocalLeader>i :SessionClose<CR>
        endif
    " }

    " PyMode {
        " Disable if python support not present
        if !has('python')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/bundle/python-mode")) && has('python')
            let g:pymode = 1
            let g:pymode_lint = 1
            let g:pymode_lint_on_write = 1
            let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
            let g:pymode_lint_ignore = "E501,F401,W0401"
            let g:pymode_lint_todo_symbol = 'W'
            let g:pymode_lint_comment_symbol = 'C'
            let g:pymode_lint_visual_symbol = 'R'
            let g:pymode_lint_error_symbol = 'E'
            let g:pymode_lint_info_symbol = 'I'
            let g:pymode_lint_pyflakes_symbol = 'F'
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0
            let g:pymode_rope_goto_definition_bind = '<C-c>g'
            let g:pymode_doc_bind = '<C-k>'
            let g:pymode_doc = 1
            let g:pymode_folding = 1
            let g:pymode_motion = 1
            let g:pymode_indent = 1
            let g:pymode_virtualenv = 1
            let g:pymode_run = 1
            let g:pymode_run_bind = '<leader>r'
            let g:pymode_breakpoint = 1
            let g:pymode_breakpoint_bind = '<leader>b'
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
            noremap <Leader>y :PymodeLint<CR>:Unite -silent -auto-preview -winheight=25 location_list<CR>
            noremap <Leader>u :PymodeLintAuto<CR>
        endif
    " }

    " ctrlp {
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_map = '<c-p>'
            let g:ctrlp_cmd = 'CtrlP'
            let g:ctrlp_open_multiple_files = 'v'   " <C-Z><C-O>时垂直分屏打开多个文件
            let g:ctrlp_working_path_mode= 'ra'
            let g:ctrlp_match_window_bottom= 1
            let g:ctrlp_max_height= 10
            let g:ctrlp_match_window_reversed=0
            let g:ctrlp_mruf_max=500
            let g:ctrlp_follow_symlinks=1
            let g:ctrlp_custom_ignore = {
              \ 'dir':  '\v[\/]\.(git|hg|svn)$',
              \ 'file': '\v\.(log|jpg|png|jpeg|exe|so|dll|zip|swp)$',
              \ }
        endif
    " }

    " TagBar {
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <Leader>e :TagbarToggle<CR>
            let g:tagbar_left = 0                   " 在右侧
            let g:tagbar_width = 30                 " 设置宽度
            let g:tagbar_sort = 0                   " 按出现顺序排序
            let g:tagbar_iconchars = ['▸', '▾']
            if !&diff
                au FileType c,cpp,python,java,vim,php,sh nested :TagbarOpen
            endif

            " If using go please install the gotags program using the following
            " go install github.com/jstemmer/gotags
            " And make sure gotags is in your path
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

    " vim-youdao-translater {
        if isdirectory(expand("~/.vim/bundle/vim-youdao-translater"))
            vnoremap <silent> <Leader>d <Esc>:Ydv<CR>
            nnoremap <silent> <Leader>d <Esc>:Ydc<CR>
            noremap <Leader>de :Yde<CR>
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
            nnoremap <Leader>gd :Gdiff<CR>
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

            " for the diffmode
            noremap <Leader>du :diffupdate<CR>

            if !exists(":Gdiffoff")
                command Gdiffoff diffoff | q | Gedit
            endif
            noremap <Leader>dq :Gdiffoff<CR>
        endif
    " }

    " gitgutter {
        if isdirectory(expand("~/.vim/bundle/vim-gitgutter/"))
            let g:gitgutter_enabled = 1
            let g:gitgutter_highlight_lines = 0
            let g:gitgutter_map_keys = 0
            let g:gitgutter_sign_column_always = 1
            nmap gh <Plug>GitGutterNextHunk
            nmap hg <Plug>GitGutterPrevHunk
            nmap <LocalLeader>d <Plug>GitGutterPreviewHunk
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

    " Syntastic {
        if isdirectory(expand("~/.vim/bundle/syntastic/"))
            let g:syntastic_check_on_open = 1
            let g:syntastic_error_symbol = 'E'
            let g:syntastic_warning_symbol = 'W'
            let g:syntastic_auto_loc_list = 2
            let g:syntastic_check_on_wq = 0
            let g:syntastic_always_populate_loc_list=1
            let g:syntastic_loc_list_height = 6
            let g:syntastic_enable_highlighting = 0
            let g:syntastic_mode_map = { "passive_filetypes": ["python"] }
            hi SyntasticError ctermbg=red guibg=red
            hi SyntasticWarning ctermbg=yellow guibg=yellow
            noremap <Leader>i :SyntasticCheck<CR>:Unite -silent -auto-preview -winheight=25 location_list<CR>
            noremap <Leader>o :Errors<CR>
        endif
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
            let g:ycm_confirm_extra_conf = 0                " 不用每次提示加载.ycm_extra_conf.py文件
            let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
            let g:ycm_show_diagnostics_ui = 0               " 关闭ycm的syntastic
            let g:ycm_filetype_whitelist = {'c': 1, 'cpp': 1, 'java': 1, 'python': 1, 'php': 1}
            let g:ycm_complete_in_comments = 1              " 评论中也应用补全
            let g:ycm_min_num_of_chars_for_completion = 2   " 两个字开始补全
            let g:ycm_seed_identifiers_with_syntax = 1
            let g:ycm_collect_identifiers_from_tags_files = 1
            let g:ycm_key_invoke_completion = '<C-Space>'
            let g:ycm_use_ultisnips_completer = 1
            let g:ycm_semantic_triggers =  {
                        \   'c' : ['->', '.'],
                        \   'objc' : ['->', '.'],
                        \   'ocaml' : ['.', '#'],
                        \   'cpp,objcpp' : ['->', '.', '::'],
                        \   'perl' : ['->'],
                        \   'php' : ['->', '::'],
                        \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
                        \   'ruby' : ['.', '::'],
                        \   'lua' : ['.', ':'],
                        \   'erlang' : [':'],
                        \ }
            nnoremap <Leader>n :YcmForceCompileAndDiagnostics<CR>
            nnoremap <Leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
        endif
    " }

    " neocomplete or neocomplcache {
        if count(g:lcl_bundle_groups, 'neocomplete')
            au Filetype c,cpp,java,python,php let g:neocomplete#enable_at_startup = 0
            au Filetype c,cpp,java,python,php let g:neocomplete_force_overwrite_completefunc = 0
            let g:acp_enableAtStartup = 0
            let g:neocomplete#max_list = 15
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#enable_camel_case = 1
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete_force_overwrite_completefunc = 1
            let g:neocomplete#enable_fuzzy_completion = 1
            let g:neocomplete#sources#syntax#min_keyword_length = 3
            let g:neocomplete#sources#dictionary#dictionaries = {'_' : $HOME.'/.vim/static/dict_with_cases'}
        elseif count(g:lcl_bundle_groups, 'neocomplcache')
            au Filetype c,cpp,java,python,php let g:neocomplcache_enable_at_startup = 0
            au Filetype c,cpp,java,python,php let g:neocomplcache_force_overwrite_completefunc = 0
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_max_list = 15
            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_smart_case = 1
            let g:neocomplcache_enable_camel_case_completion = 1
            let g:neocomplcache_enable_underbar_completion = 1
            let g:neocomplcache_enable_auto_delimiter = 1
            let g:neocomplcache_force_overwrite_completefunc = 1
            let g:neocomplcache_enable_fuzzy_completion = 1         " 开启模糊匹配
            let g:neocomplcache_fuzzy_completion_start_length = 3   " 3个字母后开启模糊匹配
            let g:neocomplcache_dictionary_filetype_lists = {'_' : $HOME.'/.vim/static/dict_with_cases'}
        endif
        if isdirectory(expand("~/.vim/bundle/ultisnips/"))
            let g:UltiSnipsExpandTrigger = "<C-l>"          " <C-j>代替<Tab>触发ultisnips补全代码段
        endif
    " }

    " Wildfire {
        if isdirectory(expand("~/.vim/bundle/wildfire.vim/"))
            let g:wildfire_objects = {
                        \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
                        \ "html,xml" : ["at"],
                        \ }
        endif

    " Unite {
        if count(g:lcl_bundle_groups, 'unite')
            nmap <silent> <Leader>f :Unite file_rec/async -start-insert<CR>
            nmap <silent> <Leader>fr :Unite file_mru -start-insert<CR>
            nmap <silent> <Leader>fd :Unite -start-insert directory_rec/async<CR>
            nmap <silent> <Leader>dr :Unite file_mru -start-insert<CR>
            nmap <silent> <Leader>b :Unite buffer<CR>
            nnoremap <LocalLeader>p :Unite history/yank<CR>
            nnoremap <LocalLeader>q :Unite register<CR>
            nnoremap <LocalLeader>z :Unite -silent -auto-preview -winheight=25 quickfix<CR>
            nnoremap <LocalLeader>x :Unite -silent -auto-preview -winheight=25 location_list<CR>
            nnoremap <silent><Leader>c :Unite -silent -vertical -winwidth=40 -direction=topleft -no-auto-resize -toggle outline<CR>
            nnoremap <silent><Leader>k :Unite -silent -auto-preview -winheight=25 mark<CR>
            nnoremap <silent><Leader>A :Unite -silent -auto-preview -winheight=25 -no-quit grep<CR>
            nnoremap <silent><Leader>a :UniteWithCursorWord -silent -auto-preview -winheight=25 -no-quit grep<CR>

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
                let g:unite_source_grep_search_word_highlight = 1
            elseif executable('ack')
                let g:unite_source_grep_command='ack'
                let g:unite_source_grep_default_opts='--no-group --no-color'
                let g:unite_source_grep_recursive_opt=''
                let g:unite_source_grep_search_word_highlight = 1
            endif

            " Unite menu {
                if filereadable(expand("~/.vimrc.menu"))
                    source ~/.vimrc.menu
                endif
            " }
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

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        if isdirectory(expand("~/.vim/bundle/AutoCloseTag"))
            au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
            nmap <Leader>ac <Plug>ToggleAutoCloseMappings
        endif
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }

" }

" Functions {

    " Initialize directories {
        function! InitializeDirectories()
            let parent = $HOME
            let prefix = 'vim'
            let dir_list = {
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
                else
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
        nmap _% :retab<CR>:call Preserve("%s/\\r$//e")<CR>:call Preserve("%s/\\s\\+$//e")<CR>
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
        command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()     " :Qargs 提取quicklist中文件为arglist
        function! QuickfixFilenames()
          let buffer_numbers = {}
          for quickfix_item in getqflist()
            let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
          endfor
          return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
        endfunction
    " }

    " 以下function有外部依赖

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

    " Unite {
        au FileType unite call s:unite_settings()
        function! s:unite_settings()
            imap <buffer> <C-j> <Plug>(unite_select_next_line)
            imap <buffer> <C-k> <Plug>(unite_select_previous_line)
            nmap <buffer> <C-h> <C-w>h
            nmap <buffer> <C-j> <C-w>j
            nmap <buffer> <C-k> <C-w>k
            nmap <buffer> <C-l> <C-w>l
        endfunction
    " }
" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
