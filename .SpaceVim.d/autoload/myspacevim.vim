function! myspacevim#init() abort
    let g:startify_custom_header = [
                \'             __   _  ____  _        _               _',
                \'           //  \\/ |/__  || |  ____| |      __   __(_)_ __ ___',
                \'           \\__//| |  / / | | / __/| | _____\ \ / /| | `_ ` _ \',
                \'           //  \\| | / /_ | | | |_ | ||_____|\ V / | | | | | | |',
                \'           \\__//|_|/____||_| \___\|_|        \_/  |_|_| |_| |_|',
                \]

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

    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    autocmd BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | exe "silent !chmod a+x <afile>" | endif
    autocmd FileType vim setlocal keywordprg=:help
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " skywind3000/vim-keysound
    let g:keysound_enable = 1
    let g:keysound_theme = 'default'    " default, typewriter, mario, bubble, sword
    let g:keysound_volume = 1000

    " vim-go
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
endfunction

function! myspacevim#after() abort
    inoremap jj <esc>
    nnoremap <silent> _$ :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
    nmap gh <plug>(signify-next-hunk)
    nmap hg <plug>(signify-prev-hunk)
    map f <Plug>(easymotion-overwin-f)

    nnoremap <silent>,h :noh<CR>
    nnoremap <silent>,s :set rnu! rnu?<CR>
    nnoremap <silent>,p :set spell! spell?<CR>
    nnoremap <silent>,l :set list! list?<CR>
    nnoremap <silent>,g :IndentLinesToggle<CR>
    nnoremap <silent>,e :TagbarToggle<CR>
    nnoremap <silent>,w :VimFiler<CR>
    nnoremap <silent>,y :set nu! nu?<CR>:set rnu! rnu?<CR>:set list! list?<CR>:IndentLinesToggle<CR>:SignifyToggle<CR>
    nnoremap <silent>,q :MundoToggle<CR>

    let g:incsearch#auto_nohlsearch = 0
    xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
    xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
    xnoremap ,j :s@\%V@@gn<Left><Left><Left><Left>
    nnoremap ,j :%s@@@gn<Left><Left><Left><Left><CR>
    nnoremap <silent> n  :call <SID>update_search_index('d')<cr>
    nnoremap <silent> N  :call <SID>update_search_index('r')<cr>

    nnoremap <silent> ,d :ZoomToggle<CR>
    map + <Plug>(expand_region_expand)
    map _ <Plug>(expand_region_shrink)
    nmap ,jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

    noremap <silent> ,,g :GscopeFind g <C-R><C-W><cr>:call <SID>open_qf()<CR>
    noremap <silent> ,,d :GscopeFind d <C-R><C-W><cr>:call <SID>open_qf()<CR>
    noremap <silent> ,,c :GscopeFind c <C-R><C-W><cr>:call <SID>open_qf()<CR>
    noremap <silent> ,,s :GscopeFind s <C-R><C-W><cr>:call <SID>open_qf()<CR>
    noremap <silent> ,,4 :GscopeFind t <C-R><C-W><cr>:call <SID>open_qf()<CR>
    noremap <silent> ,,6 :GscopeFind e <C-R><C-W><cr>:call <SID>open_qf()<CR>
    noremap <silent> ,,7 :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>:call <SID>open_qf()<CR>
    noremap <silent> ,,8 :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>:call <SID>open_qf()<CR>
    noremap <silent> ,,k :GscopeKill<cr>

    nmap ,6 :GoAddTags<CR>
    nmap ,7 :GoRemoveTags<CR>
    vmap ,7 :GoRemoveTags<CR>
    nmap ,8 gv:GoAddTags<CR>

    call unite#custom#profile('default', 'context', {
                \   'prompt_direction' : 'top',
                \   'safe': 0,
                \   'start_insert': 1,
                \   'ignorecase' : 1,
                \   'short_source_names': 1,
                \   'update_time': 200,
                \   'direction': 'rightbelow',
                \   'winwidth': 40,
                \   'winheight': 15,
                \   'max_candidates': 100,
                \   'no_auto_resize': 1,
                \   'vertical_preview': 1,
                \   'cursor_line_time': '0.10',
                \   'hide_icon': 0,
                \   'candidate-icon': ' ',
                \   'marked_icon': '✓',
                \   'prompt' : '➭ '
                \ })
endfunction

function! s:open_qf() abort
    if len(getqflist()) > 1
        Unite -silent quickfix
    endif
endfunction

function! s:update_search_index(key) abort
    if a:key ==# 'd'
        normal! n
    elseif a:key ==# 'r'
        normal! N
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
    VimFiler
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
