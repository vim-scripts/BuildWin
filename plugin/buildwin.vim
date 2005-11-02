" File: buildwin.vim
" Author: Jason Heddings (vim at heddway dot com)
" Version: 1.0
" Last Modified: 28 October, 2005
"
" See ':help buildwin' for more information.
"   
if exists('g:BuildWin_Loaded')
  finish
endif
let g:BuildWin_Loaded = 1


" set the default options for the plugin
if !exists("g:BuildWin_Height")
  let g:BuildWin_Height = 15
endif

if !exists("g:BuildWin_Position")
  let g:BuildWin_Position = "botright"
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" perform a build in the build window
command! -nargs=* Build call Build(<q-args>)
function! Build(args)
  let l:file = substitute(tempname(), "\\", "/", "g")
  augroup BuildWin
    autocmd!

    execute "autocmd BufWinEnter " . l:file . " call BuildWin_Setup()"
    execute "autocmd BufWinLeave " . l:file . " call BuildWin_Destroy()"
  augroup END

  silent execute g:BuildWin_Position . " " . g:BuildWin_Height . "new " . l:file
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" destroy the build window
function! BuildWin_Destroy()
  autocmd! BuildWin
  augroup! BuildWin
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" setup the build window
function! BuildWin_Setup()
  setlocal noswapfile
  setlocal noshowcmd
  setlocal bufhidden=delete
  setlocal nobuflisted
  setlocal nomodifiable
  setlocal nowrap
  setlocal nonumber
endfunction
