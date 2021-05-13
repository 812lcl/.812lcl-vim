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
    set signcolumn=yes

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
                    \ 'vimcalc': 1,
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

    if SpaceVim#layers#isLoaded('leaderf')
        " leaderf don't show the help in normal mode
        let g:Lf_UseCache = 0
        let g:Lf_UseVersionControlTool = 0
        let g:Lf_IgnoreCurrentBufferName = 1
        " popup mode
        let g:Lf_WindowPosition = 'popup'
        let g:Lf_PopupPreviewPosition = 'bottom'
        let g:Lf_PreviewInPopup = 1
        " hi link Lf_hl_cursorline Underlined
    endif

    let g:ale_echo_msg_format = '[%linter%] %code: %%s'
    " roxma/nvim-yarp needs
    let g:python3_host_prog = "/usr/local/opt/python/bin/python3"
endfunction

function! myspacevim#after() abort
    inoremap jj <esc>
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    nnoremap <silent> _$ :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
    map f <Plug>(easymotion-bd-f)
    map + <Plug>(expand_region_expand)
    map _ <Plug>(expand_region_shrink)

    " gitgutter
    nmap gh :GitGutterNextHunk<CR>
    nmap hg :GitGutterPrevHunk<CR>
    omap ic <Plug>(GitGutterTextObjectInnerPending)
    omap ac <Plug>(GitGutterTextObjectOuterPending)
    xmap ic <Plug>(GitGutterTextObjectInnerVisual)
    xmap ac <Plug>(GitGutterTextObjectOuterVisual)
    nnoremap gt :GitGutterToggle<CR>
    nnoremap hl :GitGutterLineHighlightsToggle<CR>
    nnoremap gr :GitGutterAll<CR>
    autocmd! gitgutter CursorHold,CursorHoldI
    autocmd BufWritePost * GitGutter

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
    nmap - <Plug>(choosewin)

    nnoremap gob :OpenBrowserSmartSearch -baidu <C-R>=expand("<cword>")<cr><cr>
    nnoremap gog :OpenBrowserSmartSearch -google <C-R>=expand("<cword>")<cr><cr>
    nnoremap goh :OpenBrowserSmartSearch -github <C-R>=expand("<cword>")<cr><cr>
    nnoremap god :OpenBrowserSmartSearch -devdocs <C-R>=expand("<cword>")<cr><cr>
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)
    nmap gl <Plug>(openbrowser-open)
    vmap gl <Plug>(openbrowser-open)

    let g:mkdp_browserfunc = ''
    let g:coc_global_extensions = ['coc-marketplace', 'coc-dictionary', 'coc-eslint', 'coc-html', 'coc-phpls', 'coc-ultisnips', 'coc-snippets', 'coc-tag', 'coc-python', 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-yaml', 'coc-vimlsp', 'coc-lua', 'coc-pairs', 'coc-go']

    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    autocmd BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | exe "silent !chmod a+x <afile>" | endif
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    let g:terminal_kill='kill'
    let g:terminal_close=1
    let g:terminal_list=0
    let g:terminal_height=15
    " let g:terminal_pos='bo'
    call SpaceVim#mapping#space#def('nnoremap', ["'"], 'call TerminalToggle()', 'open terminal', 1)
    if has('nvim') == 0
        tnoremap <silent><space>' <c-_>:call TerminalToggle()<cr>
    else
        tnoremap <silent><space>' <c-\><c-n>:call TerminalToggle()<cr>
    endif

    " AsyncTask
    let g:asynctasks_term_pos = 'bottom'
    let g:asynctasks_term_rows = 10
    let g:asynctasks_term_cols = 80
    let g:asynctasks_term_focus = 0
    let g:asynctasks_term_reuse = 1
    let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', '.gitignore', 'ci.json', 'config-ci.json']

    " space mode mapping leader key remain: o u v y z
    let g:_spacevim_mappings_space.k = {'name' : '+MyOwn'}
    call SpaceVim#mapping#space#def('nnoremap', ['k', 'd'], 'ZoomToggle', 'zoom toggle', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['k', 'h'], 'nohl', 'no highlight', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['k', 'r'], 'call RangerChooser()', 'ranger', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['k', 's'], 'set rnu! run?', 'releated line num', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['k', 'y'], 'ToggleCopyMode', 'copy mode', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['b', 'j'], 'wincmd j<CR>:q', 'close below buffer', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['k', 'q'], 'MundoToggle', 'undo toggle', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['k', '?'], 'Leaderf menu --name CustomKeyMaps --regexMode --input \[SPC\]k', 'Fuzzy find my own key bindings', 1)

    if SpaceVim#layers#isLoaded('leaderf')
        let g:Lf_RootMarkers = ['.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', '.gitignore', 'ci.json', 'config-ci.json']
        let g:Lf_PopupHeight = 0.5
        let g:Lf_PopupWidth = 0.75
        let g:Lf_CommandMap = {
                    \ '<C-X>'    : ['<C-S>'],
                    \ '<C-]>'    : ['<C-V>'],
                    \ '<Home>'   : ['<C-A>'],
                    \ '<End>'    : ['<C-E>'],
                    \ '<C-Up>'   : ['<C-N>'],
                    \ '<C-Down>' : ['<c-M>'],
                    \ '<CR>'     : ['<CR>'],
                    \ }
        let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
        let g:Lf_Extensions.task = {
                    \ 'source': string(function('s:lf_task_source'))[10:-3],
                    \ 'accept': string(function('s:lf_task_accept'))[10:-3],
                    \ 'get_digest': string(function('s:lf_task_digest'))[10:-3],
                    \ 'highlights_def': {
                    \     'Lf_hl_funcScope': '^\S\+',
                    \     'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
                    \ },
                    \ }
        let g:Lf_Extensions.map = {
                    \ 'source': string(function('s:lf_map_source'))[10:-3],
                    \ 'accept': string(function('s:lf_map_accept'))[10:-3],
                    \ 'highlights_def': {
                    \     'Lf_hl_funcScope': '^\S\+',
                    \     'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
                    \ },
                    \ }
        call SpaceVim#mapping#space#def('nnoremap', ['j', 'v'], 'LeaderfBufTag', 'jump to a tag in buffer', 1)
        call SpaceVim#mapping#space#def('nnoremap', ['k', 'p'], 'Leaderf rg --hidden -S --wd-mode=ac', 'search in project dir', 1)
        call SpaceVim#mapping#space#def('nnoremap', ['k', 'P'], 'Leaderf rg --hidden -S --wd-mode=ac -e <C-R><C-W>', 'search cword in project dir', 1)
        call SpaceVim#mapping#space#def('nnoremap', ['k', 'o'], 'Leaderf rg --hidden -S --wd-mode=ac -w -e "FIXME|TODO"', 'open todo manager', 1)
        call SpaceVim#mapping#space#def('nnoremap', ['k', 'b'], 'LeaderfMarks', 'open marks list', 1)
        call SpaceVim#mapping#space#def('nnoremap', ['k', 't'], 'Leaderf --nowrap task', 'open task list', 1)
        call SpaceVim#mapping#space#def('nnoremap', ['k', 'm'], 'Leaderf --nowrap map', 'open map list', 1)
    endif
    call gina#custom#mapping#nmap(
          \ 'blame', 'c',
          \ ':call gina#action#call(''show:commit:below'')<CR>',
          \ {'noremap': 1, 'silent': 1},
          \)
    highlight GitGutterAdd ctermfg=46 ctermbg=235
    highlight GitGutterChange ctermfg=255 ctermbg=235
    highlight GitGutterDelete ctermfg=196 ctermbg=235

    call SpaceVim#mapping#space#def('nnoremap', ['k', 'a'], 'FloatermToggle', 'Toggle Floaterm', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['k', 'c'], 'FloatermKill', 'Kill Floaterm', 1)
    tnoremap <silent> <space>ka <C-\><c-n>:FloatermToggle<CR>
    tnoremap <silent> <space>kc <C-\><c-n>:FloatermKill<CR>
    let g:asynctasks_term_pos = "floaterm"
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
    let save_cursor = getpos('.')
    if !SpaceVim#layers#core#statusline#check_section('search status')
        call SpaceVim#layers#core#statusline#toggle_section('search status')
    endif
    let &l:statusline = SpaceVim#layers#core#statusline#get(1)
    keepjumps call setpos('.', save_cursor)
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

function! s:lf_task_source(...)
    let rows = asynctasks#source(&columns * 48 / 100)
    let source = []
    for row in rows
        let name = row[0]
        let source += [name . '  ' . row[1] . '  : ' . row[2]]
    endfor
    return source
endfunction


function! s:lf_task_accept(line, arg)
    let pos = stridx(a:line, '<')
    if pos < 0
        return
    endif
    let name = strpart(a:line, 0, pos)
    let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
    if name != ''
        exec "AsyncTask " . name
    endif
endfunction

function! s:lf_task_digest(line, mode)
    let pos = stridx(a:line, '<')
    if pos < 0
        return [a:line, 0]
    endif
    let name = strpart(a:line, 0, pos)
    return [name, 0]
endfunction

function! s:lf_win_init(...)
    setlocal nonumber
    setlocal nowrap
endfunction

function! s:align_pairs(list)
  let maxlen = 0
  let pairs = []
  for elem in a:list
    let match = matchlist(elem, '^\(\S*\)\s*\(.*\)$')
    let [_, k, v] = match[0:2]
    let maxlen = max([maxlen, len(k)])
    call add(pairs, [k, substitute(v, '^\*\?[@ ]\?', '', '')])
  endfor
  let maxlen = min([maxlen, 35])
  return map(pairs, "printf('%-'.maxlen.'s', v:val[0]).' '.v:val[1]")
endfunction

function! s:lf_map_source(...)
    redir => cout
    silent execute 'verbose' 'nmap'
    redir END
    let list = []
    let curr = ''
    for line in split(cout, '\n')
        if line =~ "^\t"
            let src = '  '.join(reverse(reverse(split(split(line)[-1], '/'))[0:2]), '/')
            call add(list, printf('%s %s', curr, src))
            let curr = ''
        else
            let curr = line[3:]
        endif
    endfor
    if !empty(curr)
        call add(list, curr)
    endif
    let aligned = s:align_pairs(list)
    let sorted  = sort(aligned)
    return sorted
endfunction

function! s:lf_map_accept(line, arg)
    let @" = a:line
    echohl ModeMsg
    echohl 'Yanked!'
    echohl None
endfunction

function! s:ToggleCopyMode()
    silent set nu! nu?
    silent set rnu! rnu?
    silent set list! list?
    IndentLinesToggle
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=yes
        let b:signcolumn_on=1
    endif
endfunction
command! ToggleCopyMode call s:ToggleCopyMode()
