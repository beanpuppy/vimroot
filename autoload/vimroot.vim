if &cp || exists('autoloaded_vimroot')
  finish
endif
let autoloaded_vimroot = 1

" Options {{{1
if !exists('g:enablevimroot')
  let g:enablevimroot = 1
endif

function! vimroot#root()
  " lcd to current path of file
  let path = expand('%:p:h')
  silent! execute 'lcd' path
  " lcd to git repo root
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if !v:shell_error
    execute 'lcd' root
  endif
endfunction

function! vimroot#init()
  if g:enablevimroot == 1
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
