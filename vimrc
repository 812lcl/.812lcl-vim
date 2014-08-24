" Vundle {"{{{
    set nocompatible    " 设置 vim 为不兼容 vi 模式
    filetype off        " 必须的
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " 代码源在 github 上的
    Bundle 'gmarik/vundle'

    Bundle 'scrooloose/nerdtree'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'tpope/vim-surround'
    Bundle 'kien/ctrlp.vim'
    Bundle 'tacahiroy/ctrlp-funky'
    Bundle 'sessionman.vim'
    Bundle 'restore_view.vim'
    Bundle 'matchit.zip'
    Bundle 'bling/vim-airline'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'flazz/vim-colorschemes'
    Bundle 'mbbill/undotree'
    Bundle 'Yggdroot/indentLine'
    Bundle 'gcmt/wildfire.vim'
    Bundle 'kshenoy/vim-signature'
    Bundle 'TaskList.vim'

    Bundle 'scrooloose/syntastic'
    Bundle 'tpope/vim-fugitive'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'godlygeek/tabular'
    Bundle 'majutsushi/tagbar'

    Bundle 'honza/vim-snippets'
    Bundle 'SirVer/ultisnips'
    Bundle 'JazzCore/neocomplcache-ultisnips'
    Bundle 'Shougo/neocomplcache.vim'
    Bundle 'ervandew/supertab'

    Bundle 'klen/python-mode'
    Bundle 'python.vim'
    Bundle 'python_match.vim'
    Bundle 'pythoncomplete'

    Bundle 'elzr/vim-json'
    Bundle 'groenewege/vim-less'
    Bundle "pangloss/vim-javascript"

    Bundle "mattn/emmet-vim"
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'gorodinskiy/vim-coloresque'

    Bundle 'tpope/vim-markdown'

    Bundle 'Shougo/unite.vim'
    Bundle 'Shougo/neomru.vim'
    Bundle 'Shougo/unite-outline'
    Bundle "osyo-manga/unite-quickfix"
    Bundle 'ujihisa/unite-colorscheme'
    Bundle "ujihisa/unite-locate"
    Bundle "tacroe/unite-mark"

    " 代码存放在 vim script 上
    Bundle 'javacomplete'

    " 代码存放在其他地方
    " Bundle 'git://git.wincent.com/command-t.git'

    " Brief help
    " :BundleList          - list configured bundles
    " :BundleInstall(!)    - install(update) bundles
    " :BundleSearch(!) foo - search(or refresh cache first) for foo
    " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

    " see :h vundle for more details or wiki for FAQ
    " NOTE: comments after Bundle command are not allowed..
" }"}}}

" General {"{{{

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
    set helpheight=999              " 查看帮助文档全屏
    set scrolljump=3                " 当光标离开屏幕滑动行数
    set scrolloff=1                 " 保持在光标上下最少行数
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
    set encoding=utf-8              " 编码，使汉语正常显示
    set termencoding=utf-8,gb18030,ucs-bom,cp936,gb2312,big5,euc-jp,euc-kr,latin1
    set fileencodings=utf-8,gb18030,ucs-bom,cp936,gb2312,big5,euc-jp,euc-kr,latin1
    set langmenu=zh_CN.UTF-8
    language message zh_CN.UTF-8
    set dict+=$HOME/.vim/static/dict_with_cases

" }"}}}

" Formatting {"{{{

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
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o       " 下一行不自动添加注释
    au BufLeave * let b:winview = winsaveview()                                     " 切换buffer时保持光标所在行在窗口中到位置
    au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

" }"}}}

" Keymapping {"{{{

    let mapleader=","           " 映射<leader>键,默认'\' remain <Leader>y u i o p g
    let maplocalleader=" "      " 映射<localleader>键
    nmap j gj
    nmap k gk
    inoremap jj <ESC>
    noremap <Leader>m ggVG
    nnoremap <silent> J :bp<CR>
    nnoremap <silent> K :bn<CR>
    noremap <silent><Leader>h :noh<CR>
    noremap <silent><Leader>s :set rnu! rnu?<CR>
    noremap <silent><Leader>l :set list! list?<CR>
    noremap <silent><Leader>v :set spell! spell?<CR>
    nnoremap <LocalLeader>o @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
    nnoremap <LocalLeader>j <C-w>j:bd<CR>

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

    " Tab操作
    nnoremap <Leader>tc :tabc<CR>
    nnoremap <Leader>tn :tabn<CR>
    nnoremap <Leader>tp :tabp<CR>
    nnoremap <Leader>te :tabe<Space>

    " 修正易错命令
    command -bang -nargs=* Q q<bang>
    command -bang -nargs=* Wa wa<bang>
    command -bang -nargs=* WA wa<bang>
    command -bang -nargs=* -complete=file W w<bang> <args>
    command -bang -nargs=* -complete=file Wq wq<bang> <args>
    command -bang -nargs=* -complete=file WQ wq<bang> <args>

" }"}}}

" Vim UI {"{{{

    if has('gui_running')
        set guioptions-=m
        set guioptions-=T
        set guioptions-=r
        set guioptions-=L
        set lines=40                " 40 lines of text instead of 24
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
        let g:airline_powerline_fonts = 1                   " 是否使用powerline字体
        source $VIMRUNTIME/delmenu.vim
        "source $VIMRUNTIME/menu.vim
    else
        set t_Co=256                                        " 终端显示256色
        let g:airline_powerline_fonts = 0                   " 是否使用powerline字体
    endif

    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        color solarized             " 载入皮肤主题
        set background=dark
    endif

    set tabpagemax=15               " 最多15个Tab
    set showmode                    " 显示当前mode
    set cursorline                  " 高亮当前行
    set list                        " 显示特殊符号
    set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:.

    hi clear SignColumn             " 标记列背景和主题背景匹配
    hi clear LineNr                 " 当前行列背景和主题背景匹配

    hi CursorLineNr ctermfg=red guifg=red
    hi VertSplit ctermbg=Grey ctermfg=Grey cterm=none guibg=Grey guifg=Grey
    hi Visual ctermbg=81 ctermfg=black cterm=none guibg=cyan guifg=black
    hi Comment ctermfg=blue guifg=gray
    hi Statement ctermfg=cyan guifg=cyan
    hi DiffAdd ctermbg=blue ctermfg=white guibg=blue guifg=white
    hi DiffDelete ctermbg=green ctermfg=none guibg=green
    hi DiffChange ctermbg=red ctermfg=White guibg=red guifg=White
    hi DiffText ctermbg=yellow ctermfg=black guibg=yellow guifg=black

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

" }"}}}

" Function {"{{{

    function! Preserve(command)
        let _s=@/
        let l = line(".")
        let c = col(".")
        execute a:command
        let @/=_s
        call cursor(l, c)
    endfunction
    nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
    nmap <Leader>= :call Preserve("normal gg=G")<CR>

    function! s:VSetSearch()
        let temp = @s
        norm! gv"sy
        let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
        let @s = temp
    endfunction
    xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
    xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

    function! g:ToggleColorColumn()
        if &colorcolumn != ''
            setlocal colorcolumn&
        else
            setlocal colorcolumn=80
        endif
    endfunction
    nnoremap <LocalLeader>l :call g:ToggleColorColumn()<CR>

    command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()     " :Qargs 提取quicklist中文件为arglist
    function! QuickfixFilenames()
      let buffer_numbers = {}
      for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
      endfor
      return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
    endfunction

    " 以下function有外部依赖

    function! LinesOfCode()                         " 统计代码行数，需要cloc
        echo system('cloc --quiet '.bufname("%"))
    endfunction

    function! RangerChooser()                       " Ranger文件管理器
        exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
        if filereadable('/tmp/chosenfile')
            exec 'edit ' . system('cat /tmp/chosenfile')
            call system('rm /tmp/chosenfile')
        endif
        redraw!
    endfunction
    map <LocalLeader>r :call RangerChooser()<CR>

    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
        imap <buffer> <C-j> <Plug>(unite_select_next_line)
        imap <buffer> <C-k> <Plug>(unite_select_previous_line)
        nmap <buffer> <C-k> <C-w>k
    endfunction

" }"}}}

" Plugins {"{{{

    " vim-airline {
        set laststatus=2                                    " 显示状态栏
        let g:airline_theme='solarized'                     " 设置主题
        "let g:airline_powerline_fonts = 0                   " 是否使用powerline字体
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
        autocmd VimEnter * call AirlineInit()
    " }

    " Cscope {
        set cscopetag
        set cscopequickfix=s-,c-,d-,i-,t-,e-   " 使用QuickFix窗口来显示cscope查找结果
        if filereadable("cscope.out")
            cs add cscope.out
        elseif filereadable("tags")
            set tags=./tags
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

    " Tagbar {
        nmap <silent> <Leader>e :TagbarToggle<CR>
        let g:tagbar_left = 0                   " 在右侧
        let g:tagbar_width = 25                 " 设置宽度
    " }

    " NerdTree {
        map <Leader>w :NERDTreeToggle<CR>
        map <leader>wf :NERDTreeFind<CR>
        let NERDTreeWinPos=0                    " 在左侧
        let NERDTreeWinSize=25                  " 设置宽度
        let NERDTreeShowHidden=1                " 显示隐藏文件
        let NERDTreeQuitOnOpen=1                " 打开后退出NERDTree
        let NERDTreeShowBookmarks=1             " 显示书签
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    " }

    " UndoTree {
        nmap <silent> <Leader>q :UndotreeToggle<CR>
        let g:undotree_SetFocusWhenToggle = 1
    " }

    " persistent_undo {
        set nobackup noswapfile
        set history=200
        if has('persistent_undo')
            set undofile
            set undolevels=1000
            set undoreload=10000
            set undodir=~/.vim/.vimtmp/undo
        endif
        set viminfo+=n$HOME/.vim/.vimtmp/viminfo
        set viewoptions=folds,options,cursor,unix,slash                 " restore_view.vim
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize  " sessionman.vim
    " }

    " sessionman.vim {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize  " sessionman.vim
        nmap <LocalLeader>y :SessionList<CR>
        nmap <LocalLeader>u :SessionSave<CR>
        nmap <LocalLeader>i :SessionClose<CR>
    " }

    " ctrlp {
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
    " }

    " Syntastic {
        let g:syntastic_chek_on_open=1
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_warning_symbol = '⚠'
        let g:syntastic_always_populate_loc_list=1
        let g:syntastic_loc_list_height = 6
        let g:syntastic_enable_highlighting = 0
        hi SyntasticError ctermbg=red guibg=red
        hi SyntasticWarning ctermbg=yellow guibg=yellow
        nmap <Leader>r :SyntasticCheck<CR>:Errors<CR>
        nmap <Leader>x :lnext<CR>
        nmap <Leader>z :lpre<CR>
    " }

    " gitgutter {
        let g:gitgutter_enabled = 1
        let g:gitgutter_highlight_lines = 0
        let g:gitgutter_map_keys = 0
        let g:gitgutter_sign_column_always = 1
        nmap gh <Plug>GitGutterNextHunk
        nmap hg <Plug>GitGutterPrevHunk
        nmap <LocalLeader>d <Plug>GitGutterPreviewHunk
    " }

    " Unite {
        nmap <silent> <Leader>f :Unite file -start-insert<CR>
        nmap <silent> <Leader>fr :Unite file_mru -start-insert<CR>
        nmap <silent> <Leader>b :Unite buffer<CR>
        nnoremap <LocalLeader>p :Unite history/yank<CR>
        nnoremap <LocalLeader>q :Unite register<CR>
        nnoremap <LocalLeader>z :Unite -silent -auto-preview -winheight=25 quickfix<CR>
        nnoremap <LocalLeader>x :Unite -silent -auto-preview -winheight=25 location_list<CR>
        nnoremap <silent><Leader>a :Unite -silent -auto-preview -winheight=25 -no-quit grep<CR>
        nnoremap <silent><Leader>A :UniteWithCursorWord -silent -auto-preview -winheight=25 -no-quit grep<CR>
        nnoremap <silent><Leader>c :Unite -start-insert -silent -vertical -winwidth=40 -direction=topleft -toggle outline<CR>
        nnoremap <silent><Leader>k :Unite -silent -auto-preview -winheight=25 mark<CR>

        call unite#filters#matcher_default#use(['matcher_fuzzy'])
        call unite#filters#sorter_default#use(['sorter_rank'])
        call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
            \ 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/'], '\|'))
        let g:unite_prompt = '>>> '
        let g:unite_marked_icon = '✓'
        let g:unite_winheight = 16
        let g:unite_update_time = 200
        let g:unite_split_rule = 'botright'
        let g:unite_source_history_yank_enable = 1
        let g:unite_enable_start_insert = 0
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
    " }

    " Fugitive {
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
    "}

    " Tabularize {
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
    " }

    " indentLine {
        let g:indentLine_enabled=0
        nmap <Leader>g :IndentLinesToggle<CR>
    " }

    " PyMode {
        if !has('python')
            let g:pymode = 0
        endif
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whiteSpaces = 0
        let g:pymode_options = 0
    " }

    " vim-youdao-translater {
        vnoremap <silent> <Leader>d <Esc>:Ydv<CR>
        nnoremap <silent> <Leader>d <Esc>:Ydc<CR>
        noremap <Leader>de :Yde<CR>
    " }

    " OmniComplete {
        autocmd FileType c set omnifunc=ccomplete#Complete
        autocmd FileType java set omnifunc=javacomplete#Complete
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
        autocmd FileType ruby set omnifunc=rubycomplete#Complete
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
        autocmd FileType java inoremap <buffer> . .<C-X><C-O><C-P>
    " }

    " neocomplete {
    "    au Filetype c,cpp,java,python let g:neocomplete#enable_at_startup = 0
    "    au Filetype c,cpp,java,python let g:neocomplete_force_overwrite_completefunc = 0
    "    let g:acp_enableAtStartup = 0
    "    let g:neocomplete#max_list = 15
    "    let g:neocomplete#enable_at_startup = 1
    "    let g:neocomplete#enable_smart_case = 1
    "    let g:neocomplete#enable_camel_case = 1
    "    let g:neocomplete#enable_auto_delimiter = 1
    "    let g:neocomplete_force_overwrite_completefunc = 1
    "    let g:neocomplete#sources#syntax#min_keyword_length = 3
    "    let g:neocomplete#sources#dictionary#dictionaries = {'_' : $HOME.'/.vim/static/dict_with_cases'}
    " }

    " neocomplcache {
        au Filetype c,cpp,java,python let g:neocomplcache_enable_at_startup = 0
        au Filetype c,cpp,java,python let g:neocomplcache_force_overwrite_completefunc = 0
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
        let g:UltiSnipsExpandTrigger = "<C-j>"          " <C-j>代替<Tab>触发ultisnips补全代码段
    " }

    " YouCompleteMe {
    "    set completeopt=longest,menu                    " 关掉补全时的预览窗口
    "    let g:ycm_confirm_extra_conf = 0                " 不用每次提示加载.ycm_extra_conf.py文件
    "    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
    "    let g:ycm_show_diagnostics_ui = 0               " 关闭ycm的syntastic
    "    let g:ycm_filetype_whitelist = {'c': 1, 'cpp': 1, 'java': 1, 'python': 1}
    "    let g:ycm_complete_in_comments = 1              " 评论中也应用补全
    "    let g:ycm_min_num_of_chars_for_completion = 2   " 两个字开始补全
    "    let g:ycm_seed_identifiers_with_syntax = 1
    "    let g:ycm_collect_identifiers_from_tags_files = 1
    "    let g:ycm_key_invoke_completion = '<C-Space>'
    "    let g:UltiSnipsExpandTrigger = "<C-j>"          " <C-j>代替<Tab>触发ultisnips补全代码段
    "    let g:ycm_semantic_triggers =  {
    "        \   'c' : ['->', '.'],
    "        \   'objc' : ['->', '.'],
    "        \   'ocaml' : ['.', '#'],
    "        \   'cpp,objcpp' : ['->', '.', '::'],
    "        \   'perl' : ['->'],
    "        \   'php' : ['->', '::'],
    "        \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
    "        \   'ruby' : ['.', '::'],
    "        \   'lua' : ['.', ':'],
    "        \   'erlang' : [':'],
    "        \ }
    "    nnoremap <Leader>n :YcmForceCompileAndDiagnostics<CR>
    "    nnoremap <Leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
    " }

" }"}}}

" Unite Menu {"{{{
        let g:unite_source_menu_menus = {}
        nnoremap <LocalLeader>m :Unite menu<CR>

        let g:unite_source_menu_menus.navigation = {
            \ 'description' : '     navigate by buffers, tabs & windows
                \                    Map: <Space>n',
            \}
        let g:unite_source_menu_menus.navigation.command_candidates = [
            \['▷ buffers                                                                Map: ,b',
                \'Unite buffer'],
            \['▷ tabs                                                                   Map: ',
                \'Unite tab'],
            \['▷ windows                                                                Map: ',
                \'Unite window'],
            \['▷ location list                                                          Map: <Space>x',
                \'Unite location_list'],
            \['▷ quickfix                                                               Map: <Space>z',
                \'Unite quickfix'],
            \['▷ next buffer                                                            Map: K',
                \'bnext'],
            \['▷ prev buffer                                                            Map: J',
                \'bprevious'],
            \['▷ delete buffer                                                          Map: :bd',
                \'bd'],
            \['▷ next tab                                                               Map: ,tn',
                \'tabn'],
            \['▷ prev tab                                                               Map: ,tp',
                \'tabp'],
            \['▷ NERDTree                     (NERDTRee)                                Map: ,w',
                \'NERDTreeToggle'],
            \['▷ NERDTreeFind                 (NERDTRee)                                Map: ,wf',
                \'NERDTreeFind'],
            \['▷ new vertical window                                                    Map: <C-w>v',
                \'vsplit'],
            \['▷ new horizontal window                                                  Map: <C-w>s',
                \'split'],
            \['▷ toggle quickfix window                                                 Map: :cw',
                \'cw'],
            \['▷ close current window                                                   Map: :c',
                \'close'],
            \]
        nnoremap <LocalLeader>n :Unite menu:navigation<CR>

        let g:unite_source_menu_menus.bookmarks = {
            \ 'description' : '      bookmarks
                \                                              Map: <Space>b',
            \}
        let g:unite_source_menu_menus.bookmarks.command_candidates = [
            \['▷ Unite open bookmarks                                                   Map: ',
                \'Unite bookmark:*'],
            \['▷ Unite add bookmark                                                     Map: ',
                \'UniteBookmarkAdd'],
            \['▷ Text add mark                                                      Map: m[a-zA-Z]',
                \'normal m,'],
            \['▷ Add next mark                  (vim-signature)                     Map: m,',
                \'normal m,'],
            \['▷ Next mark                      (vim-signature)                     Map: ]`',
                \'normal ]`'],
            \['▷ Prev mark                      (vim-signature)                     Map: [`',
                \'normal [`'],
            \['▷ Clear mark                     (vim-signature)                     Map: m<Space>',
                \'normal m '],
            \]
        nnoremap <LocalLeader>b :Unite menu:bookmarks<CR>

        let g:unite_source_menu_menus.cscope = {
            \ 'description' : '         cscope
                \                                                 Map: <Space>e',
            \}
        let g:unite_source_menu_menus.cscope.command_candidates = [
            \['▷ find definition                            (cscope)                    Map: ,,g',
                \'normal ,,g'],
            \['▷ find call it                               (cscope)                    Map: ,,c',
                \'normal ,,c'],
            \['▷ find it call                               (cscope)                    Map: ,,d',
                \'normal ,,d'],
            \['▷ find c symbol                              (cscope)                    Map: ,,s',
                \'normal ,,s'],
            \['▷ find word                                  (cscope)                    Map: ,,4',
                \'normal ,,4'],
            \['▷ egrep word                                 (cscope)                    Map: ,,6',
                \'normal ,,6'],
            \['▷ find file                                  (cscope)                    Map: ,,7',
                \'normal ,,7'],
            \['▷ find include this file                     (cscope)                    Map: ,,8',
                \'normal ,,8'],
            \]
        nnoremap <LocalLeader>e :Unite menu:cscope<CR>

        let g:unite_source_menu_menus.code = {
            \ 'description' : '           coding
                \                                                 Map: <Space>c',
            \}
        let g:unite_source_menu_menus.code.command_candidates = [
            \['▷ Count lines of code                                                    Map: ',
                \'Unite -default-action= output:call\\ LinesOfCode()'],
            \['▷ Toggle indent lines                        (indent-guides)             Map: ,g',
                \'IndentLinesToggle'],
            \['▷ Tagbar                                     (Tagbar)                    Map: ,e',
                \'Tagbar'],
            \['▷ Syntastic toggle                           (syntastic)                 Map: ',
                \'SyntasticToggleMode'],
            \['▷ Syntastic check & errors                   (syntastic)                 Map: ,r',
                \'normal ,r'],
            \['▷ YCM compile and diagnostics                (YouCompleteMe)             Map: ,n',
                \'normal ,cm'],
            \['▷ YCM go to definition                       (YouCompleteMe)             Map: ,j',
                \'normal ,cm'],
            \['▷ Comment current line                       (nerdcommenter)             Map: ,cc',
                \'normal ,cc'],
            \['▷ Same as cc but forces nesting              (nerdcommenter)             Map: ,cn',
                \'normal ,cn'],
            \['▷ Uncomment current line                     (nerdcommenter)             Map: ,cu',
                \'normal ,cu'],
            \['▷ Comment sexily                             (nerdcommenter)             Map: ,cs',
                \'normal ,cs'],
            \['▷ Comment using one set                      (nerdcommenter)             Map: ,cm',
                \'normal ,cm'],
            \]
        nnoremap <LocalLeader>c :Unite menu:code<CR>

        let g:unite_source_menu_menus.files = {
            \ 'description' : '          files & dirs
                \                                           Map: <Space>f',
            \}
        let g:unite_source_menu_menus.files.command_candidates = [
            \['▷ open file                                                              Map: ,f',
                \'Unite -start-insert file'],
            \['▷ open file with recursive search                                        Map: ',
                \'Unite -start-insert file_rec/async'],
            \['▷ session list                                                           Map: <Space>y',
                \':SessionList'],
            \['▷ session save                                                           Map: <Space>u',
                \':SessionSave'],
            \['▷ session close                                                          Map: <Space>i',
                \':SessionClose'],
            \['▷ search directory                                                       Map: ',
                \'Unite -start-insert directory'],
            \['▷ search directory with recursive search                                 Map: ',
                \'Unite -start-insert directory_rec/async'],
            \['▷ edit new file                                                          Map: ',
                \'Unite -start-insert file/new'],
            \['▷ make new directory                                                     Map: ',
                \'Unite -start-insert directory/new'],
            \['▷ change working directory                                               Map: ',
                \'Unite -default-action=lcd directory'],
            \['▷ know current working directory                                         Map: ',
                \'Unite output:pwd'],
            \['▷ search recently used files                                             Map: ,fr',
                \'Unite -start-insert file_mru'],
            \['▷ search recently used directories                                       Map: ',
                \'Unite -start-insert directory_mru'],
            \['▷ save as root                                                           Map: :w!!',
                \'exe "write !sudo tee % >/dev/null"'],
            \['▷ open ranger                                                            Map: <Space>c',
                \'call RangerChooser()'],
            \]
        nnoremap <LocalLeader>f :Unite menu:files<CR>

        let g:unite_source_menu_menus.git = {
            \ 'description' : '            admin git repositories
                \                                 Map: <Space>g',
            \}
        let g:unite_source_menu_menus.git.command_candidates = [
            \['▷ git init                                                               Map: ,gn',
                \'Unite output:echo\ system("git\ init")'],
            \['▷ next hunk              (gitgutter)                                     Map: gh',
                \'GitGutterNextHunk'],
            \['▷ prev hunk              (gitgutter)                                     Map: hg',
                \'GitGutterPrevHunk'],
            \['▷ git status             (fugitive)                                      Map: ,gs',
                \'Gstatus'],
            \['▷ git diff               (fugitive)                                      Map: ,gd',
                \'Gdiff'],
            \['▷ git commit             (fugitive)                                      Map: ,gc',
                \'Gcommit'],
            \['▷ git log                (fugitive)                                      Map: ,gl',
                \'exe "silent Glog | Unite -no-quit quickfix"'],
            \['▷ git log - all          (fugitive)                                      Map: ,gL',
                \'exe "silent Glog -all | Unite -no-quit quickfix"'],
            \['▷ git blame              (fugitive)                                      Map: ,gb',
                \'Gblame'],
            \['▷ git add/stage          (fugitive)                                      Map: ,gw',
                \'Gwrite'],
            \['▷ git checkout           (fugitive)                                      Map: ,go',
                \'Gread'],
            \['▷ git rm                 (fugitive)                                      Map: ,gR',
                \'Gremove'],
            \['▷ git mv                 (fugitive)                                      Map: ,gm',
                \'exe "Gmove " input("destino: ")'],
            \['▷ git push               (fugitive, buffer output)                       Map: ,gp',
                \'Git! push'],
            \['▷ git pull               (fugitive, buffer output)                       Map: ,gP',
                \'Git! pull'],
            \['▷ git command            (fugitive, buffer output)                       Map: ,gi',
                \'exe "Git! " input("comando git: ")'],
            \['▷ git edit               (fugitive)                                      Map: ,gE',
                \'exe "command Gedit " input(":Gedit ")'],
            \['▷ git grep               (fugitive)                                      Map: ,gg',
                \'exe "silent Ggrep -i ".input("Pattern: ") | Unite -no-quit quickfix'],
            \['▷ git grep - messages    (fugitive)                                      Map: ,ggm',
                \'exe "silent Glog --grep=".input("Pattern: ")." | Unite -no-quit quickfix"'],
            \['▷ git grep - text        (fugitive)                                      Map: ,ggt',
                \'exe "silent Glog -S".input("Pattern: ")." | Unite -no-quit quickfix"'],
            \['▷ git cd                 (fugitive)                                      Map: ,gcd',
                \'Gcd'],
            \['▷ git lcd                (fugitive)                                      Map: ,glc',
                \'Glcd'],
            \['▷ git browse             (fugitive)                                      Map: ,gB',
                \'Gbrowse'],
            \['▷ github issues & PR                                                     Map: ,gS',
                \'normal ,gS'],
            \]
        nnoremap <LocalLeader>g :Unite menu:git<CR>

        let g:unite_source_menu_menus.history = {
            \ 'description' : '        yanks, registers & history
                \                             Map: <Space>h',
            \}
        let g:unite_source_menu_menus.history.command_candidates = [
            \['▷ yanks                                                                  Map: <Space>p',
                \'Unite history/yank'],
            \['▷ registers                                                              Map: <Space>q',
                \'Unite register'],
            \['▷ messages                                                               Map: ',
                \'Unite output:messages'],
            \['▷ search changes                                                         Map: ',
                \'Unite change'],
            \['▷ search jumps                                                           Map: ',
                \'Unite jump'],
            \['▷ search tasks                                                           Map: ,t',
                \'TaskList'],
            \['▷ undo tree      (Undotree)                                              Map: ,q',
                \'UndotreeToggle'],
            \]
        nnoremap <LocalLeader>h :Unite menu:history<CR>

        let g:unite_source_menu_menus.searching = {
            \ 'description' : '      searchs inside the current buffer
                \                      Map: <Space>s',
            \}
        let g:unite_source_menu_menus.searching.command_candidates = [
            \['▷ search line                                                            Map: ',
                \'Unite -auto-preview -start-insert line'],
            \['▷ grep (ag → ack → grep)                                                 Map: ,a',
                \'Unite -auto-preview -winheight=25 -no-quit grep'],
            \['▷ grep current word                                                      Map: ,A',
                \'UniteWithCursorWord -auto-preview -winheight=25 -no-quit grep'],
            \['▷ search word under the cursor in current buffer                         Map: ',
                \'UniteWithCursorWord -no-split -auto-preview line'],
            \['▷ search outlines & tags (ctags)                                         Map: ,c',
                \'Unite -vertical -winwidth=25 -start-insert -direction=topleft -toggle outline'],
            \['▷ search marks                                                           Map: ,k',
                \'Unite -auto-preview -winheight=25 mark'],
            \['▷ find                                                                   Map: ',
                \'Unite find'],
            \['▷ vimgrep (very slow)                                                    Map: ',
                \'Unite vimgrep'],
            \['▷ trigger easymotion               (easymotion)                          Map: ,,',
                \''],
            \]
        nnoremap <LocalLeader>s :Unite menu:searching<CR>

        let g:unite_source_menu_menus.text = {
            \ 'description' : '           text edition
                \                                           Map: <Space>t',
            \}
        let g:unite_source_menu_menus.text.command_candidates = [
            \['▷ toggle search results highlight                                        Map: ,h',
                \'normal ,h'],
            \['▷ toggle nu or rnu                                                       Map: ,s',
                \'normal ,s'],
            \['▷ show hidden chars                                                      Map: ,l',
                \'normal ,l'],
            \['▷ spell check                                                            Map: ,v',
                \'normal ,v'],
            \['▷ toggle fold                                                            Map: <Space>o',
                \'normal <Space>o'],
            \['▷ multiple-cursors: next               (vim-multiple-cursors)            Map: <C-n>',
                \'normal <C-n>'],
            \['▷ multiple-cursors: prev               (vim-multiple-cursors)            Map: <C-p>',
                \'normal <C-p>'],
            \['▷ multiple-cursors: skip               (vim-multiple-cursors)            Map: <C-x>',
                \'normal <C-x>'],
            \['▷ Dictionary                           (vim-youdao-translater)           Map: ,de',
                \'Yde'],
            \['▷ Translate cursor word                (vim-youdao-translater)           Map: ,d',
                \'Ydc'],
            \['▷ toggle surround in visualmode        (surround)                        Map: S',
                \'visual S'],
            \['▷ add surroundings in visualmode       (surround)                        Map: ys',
                \''],
            \['▷ change surroundings in visualmode    (surround)                        Map: cs',
                \''],
            \['▷ delete surroundings in visualmode    (surround)                        Map: ds',
                \''],
            \]
        nnoremap <LocalLeader>t :Unite menu:text<CR>

        let g:unite_source_menu_menus.tabularize = {
            \ 'description' : '     tabularize
                \                                             Map: <Space>a',
            \}
        let g:unite_source_menu_menus.tabularize.command_candidates = [
            \['▷ Tabularize &                                                           Map: <Space>&',
                \'Tabularize /&'],
            \['▷ Tabularize =                                                           Map: <Space>=',
                \'Tabularize /='],
            \['▷ Tabularize :                                                           Map: <Space>:',
                \'Tabularize /:'],
            \['▷ Tabularize ::                                                          Map: <Space>::',
                \'Tabularize /:\zs'],
            \['▷ Tabularize ,                                                           Map: <Space>,',
                \'Tabularize /,'],
            \['▷ Tabularize ,,                                                          Map: <Space>,,',
                \'Tabularize /,\zs'],
            \['▷ Tabularize <Bar>                                                       Map: <Space><Bar>',
                \'Tabularize /<Bar>'],
            \]
        nnoremap <LocalLeader>a :Unite menu:tabularize<CR>

        let g:unite_source_menu_menus.vim = {
            \ 'description' : '            vim
                \                                                    Map: <Space>v',
            \}
        let g:unite_source_menu_menus.vim.command_candidates = [
            \['▷ edit configuration file (vimrc)                                        Map: ',
                \'edit $MYVIMRC'],
            \['▷ choose colorscheme                                                     Map: ',
                \'Unite colorscheme -auto-preview'],
            \['▷ mappings                                                               Map: ',
                \'Unite mapping -start-insert'],
            \['▷ vim commands                                                           Map: ',
                \'Unite -start-insert command'],
            \['▷ vim functions                                                          Map: ',
                \'Unite -start-insert function'],
            \['▷ vim runtimepath                                                        Map: ',
                \'Unite -start-insert runtimepath'],
            \['▷ vim command output                                                     Map: ',
                \'Unite output'],
            \['▷ unite sources                                                          Map: ',
                \'Unite source'],
            \['▷ kill process                                                           Map: ',
                \'Unite -default-action=sigkill -start-insert process'],
            \['▷ launch executable (dmenu like)                                         Map: ',
                \'Unite -start-insert launcher'],
            \]
        nnoremap <LocalLeader>v :Unite menu:vim<CR>

        let g:unite_source_menu_menus.markdown = {
            \ 'description' : '       preview markdown extra docs
                \                            Map: <Space>k',
            \}
        let g:unite_source_menu_menus.markdown.command_candidates = [
            \['▷ preview                                                                Map: ',
                \'Me'],
            \['▷ refresh                                                                Map: ',
                \'Mer'],
            \]
        nnoremap <LocalLeader>k :Unite -silent menu:markdown<CR>

        let g:unite_source_menu_menus.web = {
            \ 'description' : '            web development
                \                                        Map: <Space>w',
            \}
        let g:unite_source_menu_menus.web.command_candidates = [
            \['▷ show emmet tutorial                                                    Map: ',
                \'h emmet-tutorial'],
            \]
        nnoremap <LocalLeader>w :Unite -silent menu:web<CR>

" }"}}}
