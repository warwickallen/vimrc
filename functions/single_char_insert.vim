" SINGLE-CHARACTER INSERT
" ;ix inserts x under the cursor.
" ;ax inserts x after the cursor.
" Supports repetitions.

function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction

nnoremap ;i :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap ;a :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
