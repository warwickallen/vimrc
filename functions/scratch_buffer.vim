" SCRATCH BUFFER
" :Scratch or ;s switches to a scratch buffer.

function! Scratch()
  edit scratch
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal nobuflisted
  setlocal noswapfile
  setlocal modifiable
endfunction

command! Scratch call Scratch()
nnoremap ;Sc :Scratch<CR>
