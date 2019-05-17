if &cp || exists('autoloaded_vimroot')
  finish
endif
let autoloaded_vimroot = 1

" Options {{{1
if !exists('g:vimroot_enable')
  let g:vimroot_enable = 1
endif

function! vimroot#root()
  " lcd to current path of file
  let path = expand('%:p:h')
  silent! execute 'lcd' path
  " lcd to git repo root
  let root = systemlist('git rev-parse --show-toplevel')
  if !v:shell_error
    call add(root, '.')
    execute 'lcd' root[0]
  endif
endfunction

function! vimroot#init()
  if g:vimroot_enable == 1
    call vimroot#enable()
  else
    call vimroot#disable()
  endif
endfunction

function! vimroot#enable()
  let g:ToggleVimRoot = function('vimroot#disable')
  call vimroot#root()
  augroup vimroot | autocmd Filetype,BufEnter * :call vimroot#root()
endfunction

function! vimroot#disable()
  let g:ToggleVimRoot = function('vimroot#enable')
  augroup vimroot | autocmd!
endfunction
