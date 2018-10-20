function! myspacevim#init() abort
    let g:spacevim_project_rooter_automatically = 1
    let g:spacevim_project_rooter_patterns = ['.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', '.gitignore']
    let g:spacevim_force_global_config = 1
    let g:spacevim_relativenumber = 1
    let g:spacevim_enable_language_specific_leader = 0
    let g:spacevim_github_username = '812lcl'
    let g:spacevim_enable_vimfiler_gitstatus = 0
    let g:spacevim_enable_vimfiler_filetypeicon = 0
    let g:spacevim_windows_index_type = 2
    let g:spacevim_buffer_index_type = 4
    let g:spacevim_enable_statusline_mode = 1
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

    let g:spacevim_custom_plugins = [
                \ ['skywind3000/vim-keysound'],
                \ ['wakatime/vim-wakatime'],
                \ ['gorodinskiy/vim-coloresque'],
                \ ]
    let g:keysound_enable = 1
    let g:keysound_theme = 'default'    " default, typewriter, mario, bubble, sword
    let g:keysound_volume = 1000

    let g:startify_custom_header = [
                \'             __   _  ____  _        _               _',
                \'           //  \\/ |/__  || |  ____| |      __   __(_)_ __ ___',
                \'           \\__//| |  / / | | / __/| | _____\ \ / /| | `_ ` _ \',
                \'           //  \\| | / /_ | | | |_ | ||_____|\ V / | | | | | | |',
                \'           \\__//|_|/____||_| \___\|_|        \_/  |_|_| |_| |_|',
                \]
endfunction

function! myspacevim#after() abort
    inoremap jj <esc>
    nnoremap <silent> J :bp<CR>
    nnoremap <silent> K :bn<CR>
    vnoremap <silent> J :m '>+1<CR>gv=gv
    vnoremap <silent> K :m '<-2<CR>gv=gv
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

    let g:incsearch#auto_nohlsearch = 0
    xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
    xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
    xnoremap ,j :s@\%V@@gn<Left><Left><Left><Left>
    nnoremap ,j :%s@@@gn<Left><Left><Left><Left><CR>

    nnoremap <silent> ,d :ZoomToggle<CR>
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
