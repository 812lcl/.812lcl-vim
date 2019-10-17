function! SpaceVim#layers#lang#go#plugins() abort
  let plugins = [['fatih/vim-go', { 'on_ft' : 'go', 'loadconf_before' : 1}]]
  if has('nvim') && g:spacevim_autocomplete_method ==# 'deoplete'
    call add(plugins, ['zchee/deoplete-go', {'on_ft' : 'go', 'build': 'make'}])
  endif
  return plugins
endfunction


function! SpaceVim#layers#lang#go#config() abort
  let g:go_highlight_function_calls = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:neomake_go_gometalinter_args = ['--disable-all']
  let g:go_fmt_autosave = 1
  let g:go_fmt_fail_silently = 0
  let g:go_fmt_command = "goimports"
  let g:go_list_type = "locationlist"
  let g:go_snippet_case_type = "camelcase"
  let g:go_addtags_transform = "camelcase"

  let g:go_def_mapping_enabled = 0
  let g:go_def_reuse_buffer = 1
  let g:go_def_mode = 'gopls'
  let g:go_info_mode = 'gopls'

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

  let g:go_decls_includes = 'func,type'

  if SpaceVim#layers#lsp#check_filetype('go')
      call SpaceVim#mapping#gd#add('go',
                  \ function('SpaceVim#lsp#go_to_def'))
  else
      call SpaceVim#mapping#gd#add('go', function('s:go_to_def'))
  endif
  call SpaceVim#mapping#space#regesit_lang_mappings('go', function('s:language_specified_mappings'))
  call SpaceVim#plugins#runner#reg_runner('go', 'go run %s')
endfunction

function! s:go_to_def() abort
  call go#def#Jump('')
endfunction

function! s:language_specified_mappings() abort

  call SpaceVim#mapping#space#langSPC('nmap', ['l','a'],
        \ '<Plug>(go-alternate-vertical)',
        \ 'go alternate vertical', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','b'],
        \ '<Plug>(go-build)',
        \ 'go build', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','c'],
        \ '<Plug>(go-coverage-toggle)',
        \ 'go coverage toggle', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','d'],
        \ '<Plug>(go-doc)',
        \ 'go doc', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','D'],
        \ '<Plug>(go-doc-vertical)',
        \ 'go doc (vertical)', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','e'],
        \ '<Plug>(go-rename)',
        \ 'go rename', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','f'],
        \ '<Plug>(go-def-vertical)',
        \ 'go def vertical', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','g'],
        \ '<Plug>(go-def)',
        \ 'go def', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','G'],
        \ ':GoGenerate',
        \ 'go generate', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','h'],
        \ '<Plug>(go-info)',
        \ 'go info', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','i'],
        \ '<Plug>(go-implements)',
        \ 'go implements', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','I'],
        \ ':GoImpl',
        \ 'impl stubs', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','k'],
        \ ':GoAddTags',
        \ 'add tags', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','K'],
        \ ':GoRemoveTags',
        \ 'remove tags', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','j'],
        \ 'gv:GoAddTags<CR>',
        \ 'add tags for virtual block', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','J'],
        \ 'gv:GoRemoveTags<CR>',
        \ 'remove tags for virtual block', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','l'],
        \ ':GoDecls',
        \ 'decl file', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','L'],
        \ ':GoDeclsDir',
        \ 'decl dir', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','m'],
        \ ':GoImports',
        \ 'format imports', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','M'],
        \ ':GoImport ',
        \ 'add import', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','r'],
        \ ':GoReferrers',
        \ 'go referrers', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s'],
        \ ':GoFillStruct',
        \ 'fill struct', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','t'],
        \ '<Plug>(go-test)',
        \ 'go test', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','v'],
        \ 'gv:GoFreevars<CR>',
        \ 'freevars', 0)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','x'], 'call SpaceVim#plugins#runner#open()', 'execute current file', 1)
endfunction
