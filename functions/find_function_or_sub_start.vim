" FIND START OF CURRENT FUNCTION OR SUBROUTINE
" ;[[ jumps to the last sub/function declaration.

function! FindFunctionOrSubStart()
  execute '?\c\v^\s*%(%(static|private|protected|public)\s+)*%(sub|function!{0,1})\s+(\w+)'
endfunction

nnoremap ;[[ :call FindFunctionOrSubStart()<CR>

