" CLEVER HOME KEY
" <Home> goes to the start of the line, or first character on the line
" if the cursor is alrealdy at the start.

" Doesn't work for visual mode.

function! GoToStartOfLineOrFirstChar()
  execute "normal".(getpos('.')[2] == 1 ? "^" : "0")
endfunction

nmap <silent> [1~ :call GoToStartOfLineOrFirstChar()
imap <silent> [1~ <C-O>:call GoToStartOfLineOrFirstChar()
