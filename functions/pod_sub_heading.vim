" CREATE POD HEADING FOR CURRENT SUBROUTINE OR FUNCTION
" :Pod inserts a POD heading immediately above the subroutine or function that the
" cursor is currently in.

function! Pod()
  call FindFunctionOrSubStart()
  normal k
  execute '/\v<%(sub|function!{0,1})\s'
  normal f wve""y
  normal O=head2 ""p0i=cutkkkA
endfunction

command! Pod call Pod()
