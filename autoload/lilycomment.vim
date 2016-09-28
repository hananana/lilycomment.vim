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
    let currentRow = nextnonblank(line('.'))
    let splited = split(getline(currentRow), ' ')

    if index(splited, 'class') == 1
        call s:doInsertNormalComment(currentRow)
        return
    endif

    let current = getline('.')
    if stridx(current, '(') >= 0 && stridx(current, ')') >= 0
        call s:doInsertMethodComment(currentRow, s:detectVaribleName(row))
        return
    endif

    call s:doInsertNormalComment(currentRow)
endfunction

function! s:doInsertNormalComment(row)
    let slashes = "/// "
    let itr = 0
    let spaces = ''
    while  itr < indent(a:row)
        let spaces = spaces . ' '
        let itr += 1
    endwhile
    let insertRow = a:row - 1
    call append(insertRow, spaces . slashes . "</summary>")
    call append(insertRow, spaces . slashes . " ")
    call append(insertRow, spaces . slashes . "<summary>")
    call cursor(a:row + 1, indent(a:row) + len(slashes) + 1)
    :startinsert
endfunction

function! s:doInsertMethodComment(row, variables)
endfunction

function! s:detectVaribleName(row)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
