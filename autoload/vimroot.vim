if &cp || exists('autloaded_vimroot')
  finish
endif
let autloaded_vimroot = 1

" Options {{{1
if !exists('g:rootmarkers')
  let g:rootmarkers = ['.git']
endif

if !exists('g:enablevimroot')
  let g:enablevimroot = 1
endif

function! vimroot#root()
  " cd to current path of file
  let path = expand('%:p:h')
  silent! execute 'lcd' path
  " cd to git repo root
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if !v:shell_error
    execute 'lcd' root
  endif
endfunction

function! vimroot#init()
  if g:enablevimroot == 1
    augroup vimroot | autocmd Filetype,BufEnter * :call Root()
  endif
endfunction

function! vimroot#enable()
  let g:enablevimroot = 1
  exec vimroot#root()
  let b:ToggleVimRoot = function('vimroot#disable')
endfunction

function! vimroot#disable()
  let g:enablevimroot = 0
  let b:ToggleVimRoot = function('vimroot#enable')
endfunction