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
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'm'], 'FzfMaps', 'FZF mappings', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'h'], 'FzfHelptags', 'FZF Helptags', 1)
    call SpaceVim#mapping#space#def('nnoremap', ['j', 'l'], 'FzfLines', 'FZF lines', 1)
endfunction
