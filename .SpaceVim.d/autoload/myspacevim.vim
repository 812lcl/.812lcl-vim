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
    autocmd FileType go,gitcommit,gitrebase let g:gutentags_enabled=0

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

    let g:go_metalinter_autosave = 0
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
    let g:go_metalinter_autosave_enabled = ['vet', 'golint']
    let g:go_metalinter_deadline = "5s"

    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1

    let g:go_template_autocreate = 0
    let g:go_doc_keywordprg_enabled = 1
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
                    \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                    \ 'cs,lua,javascript': ['re!\w{2}'],
                    \ }
    endif

endfunction

function! myspacevim#after() abort
    inoremap jj <esc>
    nnoremap <silent> _$ :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
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
    map f <Plug>(easymotion-overwin-f)

    nnoremap <silent>,h :noh<CR>
    nnoremap <silent>,s :set rnu! rnu?<CR>
    nnoremap <silent>,p :set spell! spell?<CR>
    nnoremap <silent>,l :set list! list?<CR>
    nnoremap <silent>,g :IndentLinesToggle<CR>
    nnoremap <silent>,e :TagbarToggle<CR>
    nnoremap <silent>,w :call ToggleFileTree()<CR>
    nnoremap <silent>,wf :NERDTreeFind<CR>
    nnoremap <silent>,y :set nu! nu?<CR>:set rnu! rnu?<CR>:set list! list?<CR>:IndentLinesToggle<CR>:SignifyToggle<CR>:ALEToggle<CR>
    nnoremap <silent>,q :MundoToggle<CR>
    nnoremap <silent>,m :FencAutoDetect<CR>
    nnoremap <silent>,t :TaskList<CR>
    nmap <silent>,v <Plug>(go-coverage-toggle)

    let g:incsearch#auto_nohlsearch = 0
    xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
    xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
    xnoremap ,j :s@\%V@@gn<Left><Left><Left><Left>
    nnoremap ,j :%s@@@gn<Left><Left><Left><Left><CR>
    nnoremap <silent> n  :call <SID>update_search_index('d')<cr>
    nnoremap <silent> N  :call <SID>update_search_index('r')<cr>
	nmap * <Plug>(anzu-star)
	nmap # <Plug>(anzu-sharp)

    nnoremap <silent> ,d :ZoomToggle<CR>
    map + <Plug>(expand_region_expand)
    map _ <Plug>(expand_region_shrink)
    nmap ,jt <Esc>:s/\\//g<CR><Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

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

    au FileType unite call s:unite_settings()
    function! s:unite_settings()
        nmap <buffer> <C-h> <C-w>h
        nmap <buffer> <C-j> <C-w>j
        nmap <buffer> <C-k> <C-w>k
        nmap <buffer> <C-l> <C-w>l
    endfunction
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
    call SpaceVim#mapping#space#def('nnoremap', ['g', 'b'], 'Gblame', 'view git blame', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['g', 'd'], 'Gdiff', 'view git diff', 1)

    if g:spacevim_snippet_engine ==# 'ultisnips'
        smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
        imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
        smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
        imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
    endif

endfunction

function! s:open_qf() abort
    if len(getqflist()) > 1
        Unite -silent quickfix
    endif
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
