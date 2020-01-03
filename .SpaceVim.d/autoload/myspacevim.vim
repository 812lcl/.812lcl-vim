function! myspacevim#init() abort
    let g:startify_custom_header = [
                \'             __   _  ____  _        _               _',
                \'           //  \\/ |/__  || |  ____| |      __   __(_)_ __ ___',
                \'           \\__//| |  / / | | / __/| | _____\ \ / /| | `_ ` _ \',
                \'           //  \\| | / /_ | | | |_ | ||_____|\ V / | | | | | | |',
                \'           \\__//|_|/____||_| \___\|_|        \_/  |_|_| |_| |_|',
                \]
    let g:startify_custom_footer =
                \ ['', "   Vim is charityware. Please read ':help uganda'.", '']
    let g:startify_bookmarks = [
                \ { 'f': '~/go/src/gitlab.myteksi.net/gophers/go/food/food-delivery-taskpool/server/serve.go' },
                \ { 'o': '~/go/src/gitlab.myteksi.net/gophers/go/food/food-order-batching/server/serve.go' },
                \ { 'c': '~/go/src/gitlab.myteksi.net/gophers/go/food/food-dax-capability/server/serve.go' },
                \ { 'v': '~/.SpaceVim.d/init.toml' },
                \ { 'm': '~/.SpaceVim.d/autoload/myspacevim.vim' },
                \ { 'z': '~/.zshrc' },
                \ { 't': '~/.tmux.conf' },
                \ ]
    let g:sessionman_save_on_exit = 0

    set wrap
    set noswapfile
    set ignorecase
    set smartcase
    set wildmenu
    set wildmode=list:longest,full
    set splitright
    set splitbelow
    set helpheight=20
    set completeopt=longest,menuone
    set scrolloff=2
    set mouse=v
    set mousehide
    set list
    set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:.
    set updatetime=100
    " set signcolumn=yes

    " skywind3000/vim-keysound
    let g:keysound_enable = 1
    let g:keysound_theme = 'default'    " default, typewriter, mario, bubble, sword
    let g:keysound_volume = 1000

    if g:spacevim_enable_ycm
        let g:ycm_min_num_of_chars_for_completion = 1
        let g:ycm_min_num_identifier_candidate_chars = 2
        let g:ycm_collect_identifiers_from_comments_and_strings = 1
        let g:ycm_confirm_extra_conf = 0
        let g:ycm_global_ycm_extra_conf = '~/.cache/vimfiles/repos/github.com/Valloric/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
        let g:ycm_show_diagnostics_ui = 0
        let g:ycm_complete_in_comments = 1
        let g:ycm_seed_identifiers_with_syntax = 1
        let g:ycm_collect_identifiers_from_tags_files = 1
        let g:ycm_key_invoke_completion = '<c-z>'
        let g:ycm_use_ultisnips_completer = 1
        let g:ycm_semantic_triggers =  {
                    \ 'c,cpp,python,java,erlang,perl': ['re!\w{2}'],
                    \ 'cs,lua,javascript': ['re!\w{2}'],
                    \ }
        let g:ycm_filetype_blacklist = {
                    \ 'tagbar': 1,
                    \ 'notes': 1,
                    \ 'markdown': 1,
                    \ 'netrw': 1,
                    \ 'unite': 1,
                    \ 'denite': 1,
                    \ 'denite-filter': 1,
                    \ 'text': 1,
                    \ 'vimwiki': 1,
                    \ 'pandoc': 1,
                    \ 'infolog': 1,
                    \ 'mail': 1
                    \}
    endif

    let g:projectionist_heuristics = {
                \   '*': {
                \     '*.c': {
                \         'alternate': '{}.h',
                \         'type': 'source'
                \     },
                \     '*.h': {
                \         'alternate': '{}.c',
                \         'type': 'header'
                \     },
                \     '*.cc': {
                \         'alternate': '{}.h',
                \         'type': 'source'
                \     },
                \     '*.go': {
                \         'alternate': '{}_test.go',
                \         'type': 'source'
                \     },
                \     '*_test.go': {
                \         'alternate': '{}.go',
                \         'type': 'test'
                \     }
                \   }
                \ }
    " don't show the help in normal mode
    let g:Lf_UseCache = 0
    let g:Lf_UseVersionControlTool = 0
    let g:Lf_IgnoreCurrentBufferName = 1
    " popup mode
    let g:Lf_WindowPosition = 'popup'
    let g:Lf_PopupPreviewPosition = 'bottom'
    let g:Lf_PreviewInPopup = 1
endfunction

function! myspacevim#after() abort
    inoremap jj <esc>
    nnoremap <silent> _$ :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
    nmap gh :GitGutterNextHunk<CR>
    nmap hg :GitGutterPrevHunk<CR>
    omap ic <Plug>(GitGutterTextObjectInnerPending)
    omap ac <Plug>(GitGutterTextObjectOuterPending)
    xmap ic <Plug>(GitGutterTextObjectInnerVisual)
    xmap ac <Plug>(GitGutterTextObjectOuterVisual)
    nnoremap gt :GitGutterToggle<CR>
    nnoremap hl :GitGutterLineHighlightsToggle<CR>
    nnoremap gr :GitGutterAll<CR>
    map f <Plug>(easymotion-bd-f)

    nnoremap <silent>,h :noh<CR>
    nnoremap <silent>,s :set rnu! rnu?<CR>
    nnoremap <silent>,y :set nu! nu?<CR>:set rnu! rnu?<CR>:set list! list?<CR>:IndentLinesToggle<CR>:GitGutterToggle<CR>:ALEToggle<CR>
    nnoremap <silent>,q :MundoToggle<CR>
    nnoremap <silent>,t :TaskList<CR>
    noremap <C-F> :<C-U><C-R>=printf("Leaderf rg --wd-mode=ac -e %s", expand("<cword>"))<CR><CR>
    vnoremap <silent> J :m '>+1<CR>gv=gv
    vnoremap <silent> K :m '<-2<CR>gv=gv

    " let g:incsearch#auto_nohlsearch = 0
    xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
    xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
    xnoremap ,j :s@\%V@@gn<Left><Left><Left><Left>
    nnoremap <silent> n  :call <SID>update_search_index('d')<cr>
    nnoremap <silent> N  :call <SID>update_search_index('r')<cr>
    nmap * <Plug>(anzu-star)
    nmap # <Plug>(anzu-sharp)

    nnoremap <silent> ,d :ZoomToggle<CR>
    nnoremap <silent> ,r :call RangerChooser()<CR>
    map + <Plug>(expand_region_expand)
    map _ <Plug>(expand_region_shrink)
    nmap ,jt <Esc>:s/\\//g<CR><Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

    if g:spacevim_snippet_engine ==# 'ultisnips'
        smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
        imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
        smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
        imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
    endif
    nnoremap gob :OpenBrowser http://www.baidu.com/s?wd=<C-R>=expand("<cword>")<cr><cr>
    nnoremap gog :OpenBrowser http://www.google.com/?#newwindow=1&q=<C-R>=expand("<cword>")<cr><cr>
    let g:mkdp_browserfunc = ''
    autocmd! gitgutter CursorHold,CursorHoldI
    let g:coc_global_extensions = ['coc-marketplace', 'coc-ccls', 'coc-dictionary', 'coc-eslint', 'coc-html', 'coc-phpls', 'coc-ultisnips', 'coc-snippets', 'coc-tag', 'coc-python', 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-yaml', 'coc-vimlsp']
    autocmd FileType denite-filter let b:coc_suggest_disable = 1
    autocmd FileType denite-filter call s:denite_settings()
    function! s:denite_settings()
        imap <silent><buffer> jj <Plug>(denite_filter_quit)
        imap <silent><buffer> <Esc> <Plug>(denite_filter_quit):q<Cr>
        imap <silent><buffer> <C-c> <Plug>(denite_filter_quit):q<Cr>
        inoremap <silent><buffer> <c-j> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
        inoremap <silent><buffer> <c-k> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
    endfunction

    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    autocmd BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | exe "silent !chmod a+x <afile>" | endif
    autocmd FileType vim setlocal keywordprg=:help
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    autocmd BufWritePost * GitGutter
    autocmd! gitgutter CursorHold,CursorHoldI

    let g:Lf_CommandMap = {
          \ '<C-X>'  : ['<C-S>'],
          \ '<C-]>'  : ['<C-V>'],
          \ '<Home>' : ['<C-A>'],
          \ '<End>'  : ['<C-E>'],
          \ }
endfunction

function! s:update_search_index(key) abort
    if a:key ==# 'd'
        if mapcheck('<Plug>(anzu-n)') !=# ''
            call feedkeys("\<Plug>(anzu-n)")
        else
            normal! n
        endif
    elseif a:key ==# 'r'
        if mapcheck('<Plug>(anzu-N)') !=# ''
            call feedkeys("\<Plug>(anzu-N)")
        else
            normal! N
        endif
    endif
    normal! ml
    if !SpaceVim#layers#core#statusline#check_section('search status')
        call SpaceVim#layers#core#statusline#toggle_section('search status')
    endif
    let &l:statusline = SpaceVim#layers#core#statusline#get(1)
    normal! `l
endfunction

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
" Zoom / Restore window.
command! ZoomToggle call s:ZoomToggle()

function! ToggleFileTree()
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
command! ToggleFileTree call ToggleFileTree()

function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

function! RangerChooser()                       " Ranger文件管理器
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfunction
command! Ranger call RangerChooser()
