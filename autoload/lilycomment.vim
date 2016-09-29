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
    let targetRow = nextnonblank(line('.'))
    let splited = split(getline(targetRow), ' ')
    let current = getline('.')

    if stridx(current, '(') >= 0 && stridx(current, ')') >= 0
        call s:doInsertMethodComment(targetRow, s:getVariableNames(targetRow))
    else
        call s:doInsertNormalComment(targetRow)
    endif
    call cursor(targetRow + 1, len(s:getSpacesAndSlashes(targetRow)) + 1)
    startinsert
endfunction

function! s:doInsertNormalComment(row)
    let insertRow = a:row - 1
    call append(insertRow, s:getSpacesAndSlashes(a:row) . "</summary>")
    call append(insertRow, s:getSpacesAndSlashes(a:row) . " ")
    call append(insertRow, s:getSpacesAndSlashes(a:row) . "<summary>")
endfunction

function! s:getSpacesAndSlashes(row)
    let slashes = "/// "
    let itr = 0
    let spaces = ''
    while  itr < indent(a:row)
        let spaces = spaces . ' '
        let itr += 1
    endwhile
    return spaces . slashes
endfunction

function! s:doInsertMethodComment(row, variables)

endfunction

function! s:getVariableNames(row)
    echo 'hoge'
    let target = getline(a:row)
    let leftBracketsIndex = stridx(target, '(')
    let rightBracketsIndex = stridx(target, ')')
    let innerStr = target[leftBracketsIndex + 1 : rightBracketsIndex - len(target) - 1]
    let candidates = filter(split(innerStr, '\v( |,)'), {idx, val -> val != ''})
    return filter(candidates, {idx, val -> idx % 2 != 0})
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
