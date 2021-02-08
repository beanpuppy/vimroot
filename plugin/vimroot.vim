" vimroot.vim - very basic root plugin
" Maintainer: Justin Duch
" Version:    0.1
" License:    MIT

if &cp || exists('loaded_vimroot')
  finish
endif
let loaded_vimroot = 1

augroup vimrootinit
  autocmd!
  autocmd BufEnter * :call vimroot#init()
augroup END

command! Root :call vimroot#root()
command! ToggleVimRoot :call g:ToggleVimRoot()
command! EnableVimRoot :call vimroot#enable()
command! DisableVimRoot :call vimroot#disable()
