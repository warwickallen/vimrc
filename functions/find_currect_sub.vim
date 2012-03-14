"  FIND CURRENT SUB NAME
"  ;s sets s mark to the top of current sub or function and display sub name.

function! FindCurrentSub()
  call search('^\s*\(sub\|function\)\>','sbe')
  let line = getline(".")
  let i = stridx(line, '{')
  if i > 0
    let line = strpart(line, 0, i)
  endif
  call setpos("'s", getpos("."))
  call setpos('.', getpos("''"))
  echo line
endfunction

nnoremap ;s :call FindCurrentSub()<CR>
