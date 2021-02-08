if &cp || exists('autoloaded_vimroot')
  finish
endif
let autoloaded_vimroot = 1

" Options
if !exists('g:vimroot_enable')
  let g:vimroot_enable = 1
endif

function! s:use_known_shell() abort
  if has('unix') && &shell !=# 'sh'
    let [s:shell, s:shellcmdflag, s:shellredir, s:shellpipe, s:shellquote, s:shellxquote] = [&shell, &shellcmdflag, &shellredir, &shellpipe, &shellquote, &shellxquote]
    let &shell = 'sh'
    set shellcmdflag=-c shellredir=>%s\ 2>&1
  endif
  if has('win32') && (&shell ==# 'pwsh' || &shell ==# 'powershell')
    let [s:shell, s:shellcmdflag, s:shellredir, s:shellpipe, s:shellquote, s:shellxquote] = [&shell, &shellcmdflag, &shellredir, &shellpipe, &shellquote, &shellxquote]
    let &shell = 'cmd.exe'
    set shellcmdflag=/s\ /c shellredir=>%s\ 2>&1 shellpipe=>%s\ 2>&1 shellquote= shellxquote="
  endif
endfunction

function! s:restore_shell() abort
  if (has('unix') || has('win32')) && exists('s:shell')
    let [&shell, &shellcmdflag, &shellredir, &shellpipe, &shellquote, &shellxquote] = [s:shell, s:shellcmdflag, s:shellredir, s:shellpipe, s:shellquote, s:shellxquote]
  endif
endfunction

function! vimroot#system(cmd, ...) abort
  call s:use_known_shell()
  silent let output = (a:0 == 0) ? system(a:cmd) : system(a:cmd, a:1)
  call s:restore_shell()

  return output
endfunction

function! vimroot#root()
  try
    Gcd " from vim-fugitive, sets cwd to project's git folder
  catch
    let path = expand('%:p:h')

    " lcd to current path of file
    silent! execute 'lcd' path

    " lcd to git repo root
    let root = vimroot#system('git rev-parse --show-toplevel')

    if !v:shell_error
      execute 'lcd' root
    endif
  endtry
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
