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
    let current = getline('.')

    if stridx(current, '(') >= 0 && stridx(current, ')') >= 0
        call s:doInsertMethodComment(currentRow, s:detectVaribleNames(currentRow))
    else
        call s:doInsertNormalComment(currentRow)
    endif
    call cursor(currentRow + 1, len(s:getSpacesAndSlashes(currentRow)) + 1)
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

function! s:detectVaribleNames(row)
    let target = getline(a:row)
    let leftBracketsIndex = stridx(target, '(')
    let rightBracketsIndex = stridx(target, ')')
    let innerStr = target[leftBracketsIndex + 1 : rightBracketsIndex - len(target) - 1]
    let splited = split(innerStr, ',')
    let variables = []
    for s in splited
        let words = split(s, ' ')
    
        for w in words
            if w[0] == ' '
                let w = w[1:]
            endif
            if index(words, w) == 1
                call add(variables, w)
            endif
        endfor
    endfor
    return variables
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
