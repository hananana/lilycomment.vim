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

function! lilycomment#insert() abort
    let targetRow = nextnonblank(line('.'))
    let targetString = getline(targetRow)

    if s:isMethod(targetString)
        call s:doInsertMethodComment(targetRow, s:getVariableNames(targetRow))
        call s:fixCursor(targetRow + 1, len(s:getSpacesAndSlashes(targetRow)) + 1)
    else
        call s:doInsertNormalComment(targetRow)
        call s:fixCursor(targetRow + 1, len(s:getSpacesAndSlashes(targetRow)) + 1)
    endif
endfunction

function! s:isMethod(targetString) abort
    return stridx(a:targetString, '(') >= 0 && stridx(a:targetString, ')') >= 0
endfunction

function! s:isClass(targetString) abort
    return stridx(a:targetString, 'class') != -1
endfunction
    
function! s:fixCursor(row, col) abort
    call cursor(a:row, a:col)
    startinsert
endfunction

function! s:doInsertNormalComment(row) abort
    let insertRow = a:row - 1
    call append(insertRow, s:getSpacesAndSlashes(a:row) . '</summary>')
    call append(insertRow, s:getSpacesAndSlashes(a:row) . ' ')
    call append(insertRow, s:getSpacesAndSlashes(a:row) . '<summary>')
endfunction

function! s:doInsertMethodComment(row, variables) abort
    call s:doInsertNormalComment(a:row)
    let insertRow = a:row + 2
    for val in a:variables
        let idx = index(a:variables, val)
        let str = s:getSpacesAndSlashes(a:row) . '<param name=\"' . val . '\"> </param>'
        call append(insertRow + idx, str)
    endfor
    if s:returnable(a:row)
        call append(insertRow + len(a:variables), s:getSpacesAndSlashes(a:row) . '<returns> </returns>')
    endif
endfunction

function! s:getSpacesAndSlashes(row) abort
    let slashes = '/// '
    let itr = 0
    let spaces = ''
    while  itr < indent(a:row)
        let spaces = spaces . ' '
        let itr += 1
    endwhile
    return spaces . slashes
endfunction

function! s:getVariableNames(row) abort
    let target = getline(a:row)
    let leftBracketsIndex = stridx(target, '(')
    let rightBracketsIndex = stridx(target, ')')
    let innerStr = target[leftBracketsIndex + 1 : rightBracketsIndex - len(target) - 1]
    let candidates = filter(split(innerStr, '\v( |,)'), {idx, val -> val != ''})
    return filter(candidates, {idx, val -> idx % 2 != 0})
endfunction

function! s:returnable(row) abort
    let target = getline(a:row)
    let splited = split(target, ' ')
    let filterd = filter(split(target, ' '), 
                \{idx, val -> val != 'public' && val != 'private'})
    return filterd[0] !=? 'void'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
