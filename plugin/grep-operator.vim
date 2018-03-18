" grep-operator.vim - create a grep operator
" Last Change:	03/18/18 
" Version:      0.1
" Maintainer:	Kevin Yang
" License:	    This file is placed in the public domain.

if exists('g:loaded_grep_operator_plugin')
  finish
endif
let g:loaded_grep_operator_plugin = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
