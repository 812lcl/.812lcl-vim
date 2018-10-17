"=============================================================================
" init.vim --- local config for SpaceVim development
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

let g:spacevim_force_global_config = 1
call SpaceVim#custom#SPC('nnoremap', ['a', 'r'], 'call SpaceVim#dev#releases#open()', 'Release SpaceVim', 1)
call SpaceVim#custom#SPC('nnoremap', ['a', 'w'], 'call SpaceVim#dev#website#open()', 'Open SpaceVim local website', 1)
call SpaceVim#custom#SPC('nnoremap', ['a', 't'], 'call SpaceVim#dev#website#terminal()', 'Close SpaceVim local website', 1)
call SpaceVim#custom#SPC('nnoremap', ['a', 'o'], 'call SpaceVim#dev#todo#list()', 'Open todo manager', 1)

let g:spacevim_colorscheme = 'neosolarized'
let g:spacevim_relativenumber = 1
let g:spacevim_enable_guicolors = 0
let g:spacevim_enable_language_specific_leader = 0
let g:spacevim_github_username = '812lcl'
let g:spacevim_enable_vimfiler_gitstatus = 0
let g:spacevim_enable_vimfiler_filetypeicon = 0
let g:spacevim_enable_tabline_filetype_icon = 1
let g:spacevim_windows_index_type = 2
let g:spacevim_buffer_index_type = 4
let g:spacevim_enable_statusline_mode = 1
let g:_spacevim_autocomplete_delay = 50

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
" set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:.

inoremap jj <esc>
nnoremap <silent> E :bp<CR>
nnoremap <silent> R :bn<CR>
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
nnoremap <silent> _$ :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
nmap hj <plug>(signify-next-hunk)
nmap hg <plug>(signify-prev-hunk)

nnoremap <silent>,h :noh<CR>
nnoremap <silent>,s :set rnu! rnu?<CR>
nnoremap <silent>,p :set spell! spell?<CR>
nnoremap <silent>,l :set list! list?<CR>
nnoremap <silent>,g :IndentLinesToggle<CR>
nnoremap <silent>,e :TagbarToggle<CR>

autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
autocmd BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | exe "silent !chmod a+x <afile>" | endif
autocmd FileType vim setlocal keywordprg=:help
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

call SpaceVim#layers#load('shell')
call SpaceVim#layers#load('cscope')
call SpaceVim#layers#load('git')
call SpaceVim#layers#load('chinese')
call SpaceVim#layers#load('insearch')
call SpaceVim#layers#load('sudo')
call SpaceVim#layers#load('tags')
call SpaceVim#layers#load('tmux')
call SpaceVim#layers#load('tools')
call SpaceVim#layers#load('tools#dash')
call SpaceVim#layers#load('VersionControl')
call SpaceVim#layers#load('unite')
call SpaceVim#layers#load('colorscheme')
call SpaceVim#layers#load('lang#c')
call SpaceVim#layers#load('lang#go')
call SpaceVim#layers#load('lang#html')
call SpaceVim#layers#load('lang#javascript')
call SpaceVim#layers#load('lang#json')
call SpaceVim#layers#load('lang#markdown')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#sh')
call SpaceVim#layers#load('lang#toml')
call SpaceVim#layers#load('lang#vim')
call SpaceVim#layers#load('lang#xml')

let g:spacevim_custom_plugins = [
            \ ['skywind3000/vim-keysound'],
            \ ['wakatime/vim-wakatime'],
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
nnoremap ,w :call ToggleFileTree()<CR>
nnoremap ,wf :VimFiler<CR>

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
nnoremap <silent> ,d :ZoomToggle<CR>

function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
xnoremap ,j :s@\%V@@gn<Left><Left><Left><Left>
nnoremap ,j :%s@@@gn<Left><Left><Left><Left><CR>
