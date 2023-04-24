function! SpaceVim#layers#tags#loadable() abort
  return !has('nvim')
endfunction

function! SpaceVim#layers#tags#plugins() abort
  return [
        \ ['812lcl/gutentags_plus', {
        \ 'merged' : 0,
        \ 'depends': 'denite.nvim',
        \ }],
        \ ['ludovicchabant/vim-gutentags', {'merged' : 0}],
        \ ]
endfunction

function! SpaceVim#layers#tags#config() abort
    let $GTAGSLABEL = 'native-pygments'
    let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
    let g:gutentags_ctags_tagfile = 'tags'
    let g:gutentags_exclude_filetypes = ['go']
    let s:vim_tags = expand('$HOME/.cache/tags')
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
    autocmd FileType go,gitcommit,gitrebase let g:gutentags_enabled=0

    let g:_spacevim_mappings_space.m.g = {'name' : '+gtags'}
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 'g'] , ':CscopeFindCurrentWord g' , 'Find this definition'                   , 1)
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 'd'] , ':CscopeFindCurrentWord d' , 'Find functions called by this function' , 1)
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 'c'] , ':CscopeFindCurrentWord c' , 'Find functions calling this function'   , 1)
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 's'] , ':CscopeFindCurrentWord s' , 'Find this C symbol'                     , 1)
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 't'] , ':CscopeFindCurrentWord t' , 'Find this text string'                  , 1)
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 'e'] , ':CscopeFindCurrentWord e' , 'Find this egrep pattern'                , 1)
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 'f'] , ':CscopeFindCurrentFile f' , 'Find this file'                         , 1)
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 'i'] , ':CscopeFindCurrentFile i' , 'Find files #including this file'        , 1)
    call SpaceVim#mapping#space#def('noremap' , ['m' , 'g' , 'k'] , ':GscopeKill<CR>'          , 'GscopeKill'                             , 1)
endfunction

command! -nargs=? CscopeFindCurrentWord call <SID>CscopeFind(<q-args>)
function! s:CscopeFind(...) abort
    let query = get(a:000, 0, '')
    exe "GscopeFind " . query . " " . expand("<cword>")
    if len(getqflist()) > 1
        if SpaceVim#layers#isLoaded("leaderf")
            Leaderf quickfix
        elseif SpaceVim#layers#isLoaded("fzf")
            FzfQuickfix
        elseif SpaceVim#layers#isLoaded("denite")
            Denite quickfix
        endif
    endif
endfunction


command! -nargs=? CscopeFindCurrentFile call <SID>CscopeFindFile(<q-args>)
function! s:CscopeFindFile(...) abort
    let query = get(a:000, 0, '')
    exe "GscopeFind " . query . " " . expand("<cfile>")
    if len(getqflist()) > 1
        if SpaceVim#layers#isLoaded("leaderf")
            Leaderf quickfix
        elseif SpaceVim#layers#isLoaded("fzf")
            FzfQuickfix
        elseif SpaceVim#layers#isLoaded("denite")
            Denite quickfix
        endif
    endif
endfunction
