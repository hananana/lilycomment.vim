"=============================================================================
" File: tester.vim
" Author: hananana
" Created: 2016-09-26
"=============================================================================

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

so autoload/lilycomment.vim
so plugin/lilycomment.vim
call lilycomment#insert()

let &cpo = s:save_cpo
unlet s:save_cpo
