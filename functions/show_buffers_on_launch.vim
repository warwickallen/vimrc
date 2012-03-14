" SHOW BUFFERS ON LAUNCH
" List all the buffers when launching Vim, but only if there is more than one.

function! ListMultipleBuffers()
  if bufexists(2)
    ls
  endif
endfunction

autocmd! VimEnter * call ListMultipleBuffers()
