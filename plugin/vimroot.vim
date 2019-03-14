" vimroot.vim - very basic root plugin
" Maintainer: Justin Duch
" Version:    0.1
" License:    The same license as Vim itself, see `:h license`

if &cp || exists('loaded_vimroot')
  finish
endif
let loaded_vimroot = 1

augroup vimrootinit
  autocmd!
  autocmd BufReadPre,FileReadPre * vimroot#init()
augroup END

command! Root :call vimroot#root()
command! ToggleVimRoot :call b:ToggleVimRoot()

