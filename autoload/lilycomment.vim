"=============================================================================
" File: lilycomment.vim
" Author: hananana
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
    let currentRow = s:getTargetRow()
    let splited = split(s:getTargetString(), ' ')

    if index(splited, 'class') == 1
        "         echo 'this row is class definition'
        call s:doInsert(currentRow)
        return
    endif

    let current = getline('.')
    if stridx(current, '(') >= 0 && stridx(current, ')') >= 0
        "         echo 'this row is method definition'
        call s:doInsert(currentRow)
        return
    endif

    "     echo 'this row is NOT difinition'
    call s:doInsert(currentRow)
endfunction

function! s:getTargetString()
    let row = line('.')
    while empty(getline(row))
        let row += 1
    endwhile
    return getline(row)
endfunction

function! s:getTargetRow()
    let row = line('.')
    while empty(getline(row))
        let row += 1
    endwhile
    return row
endfunction

function! s:doInsert(row)
    call cursor(a:row, 0)
    "wip 
    execute "normal! <underscore>"
    
"     call append(a:row - 1, "/// </summary>")
"     call append(a:row - 1, "/// ")
"     call append(a:row - 1, "/// <summary>")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
