"=============================================================================
" File: lilycomment.vim
" Author: Hanac
" Created: 2016-09-26
"=============================================================================

scriptencoding utf-8

if !exists('g:loaded_lilycomment')
    finish
endif
let g:loaded_lilycomment = 1

let s:save_cpo = &cpo
set cpo&vim

function! lilycomment#insert()
    echo 'hoge'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
