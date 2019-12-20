function! SpaceVim#layers#fzf#plugins() abort
  let plugins = []
  call add(plugins, ['junegunn/fzf',        { 'build': './install --all', 'merged' : 0 }])
  call add(plugins, ['junegunn/fzf.vim',    { 'depends':'fzf', 'merged' : 0 }])
  return plugins
endfunction


function! SpaceVim#layers#fzf#config() abort
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }
    " let g:fzf_layout = {'window': 'enew'}
    let g:fzf_layout = { 'window': '15split' }
    let g:fzf_command_prefix = 'Fzf'

    nnoremap <silent> <C-p> :FZF<cr>
    let g:_spacevim_mappings_space.j.f = {'name' : '+FZF'}
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'f', 'm'], 'FzfMaps', 'FZF mappings', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'f', 'h'], 'FzfHelptags', 'FZF Helptags', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'f', 'l'], 'FzfLines', 'FZF lines', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'f', 's'], 'FzfSnippets', 'FZF snippets', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'f', 'p'], 'FzfMenu Projects', 'FZF projects', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'f', 'h'], 'FzfMenu StatusCodeDefinitions', 'FzfMenu StatusCodeDefinitions', 1)
endfunction

" fzf menu command
function! SpaceVim#layers#fzf#complete_menu(ArgLead, CmdLine, CursorPos) abort
  return join(keys(g:unite_source_menu_menus), "\n")
endfunction

command! -nargs=* -complete=custom,SpaceVim#layers#fzf#complete_menu FzfMenu call <SID>menu(<q-args>)
function! s:menu_action(e) abort
  let action = get(s:menu_action, a:e, '')
  exe action
endfunction
function! s:menu(name) abort
  let s:source = 'menu'
  let s:menu_name = a:name
  let s:menu_action = {}
  function! s:menu_content() abort
    let menu = get(g:unite_source_menu_menus, s:menu_name, {})
    if has_key(menu, 'command_candidates')
      let rt = []
      for item in menu.command_candidates
        call add(rt, item[0])
        call extend(s:menu_action, {item[0] : item[1]}, 'force')
      endfor
      return rt
    else
      return []
    endif
  endfunction
  call fzf#run(fzf#wrap('menu', {
        \   'source':  reverse(<sid>menu_content()),
        \   'sink':    function('s:menu_action'),
        \   'options': '+m',
        \   'down': '40%'
        \ }))
endfunction
