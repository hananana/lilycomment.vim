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
    let l:currentRow = line(".")
    let l:splited = split(getline('.'), ' ')

    if index(l:splited, 'class') == 1
        "         echo 'this row is class definition'
        call append(l:currentRow - 1, "/// </summary>")
        call append(l:currentRow - 1, "/// ")
        call append(l:currentRow - 1, "/// <summary>")
        return
    endif

    let l:current = getline('.')
    if stridx(l:current, '(') >= 0 && stridx(l:current, ')') >= 0
        "         echo 'this row is method definition'
        call append(l:currentRow - 1, "/// </summary>")
        call append(l:currentRow - 1, "/// ")
        call append(l:currentRow - 1, "/// <summary>")
        return
    endif

    "     echo 'this row is NOT difinition'
    call append(l:currentRow - 1, "/// </summary>")
    call append(l:currentRow - 1, "/// ")
    call append(l:currentRow - 1, "/// <summary>")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
