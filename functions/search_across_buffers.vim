" SEARCH ACROSS BUFFERS
" Looks for a pattern in all the open buffers.
" :Bvimgrep 'pattern' puts results into the quickfix list
" :Blvimgrep 'pattern' puts results into the location list

function! BuffersVimgrep(pattern,cl)
  let str = ''
  if (a:cl == 'l')
    let str = 'l'
  endif
  let str = str.'vimgrep /'.a:pattern.'/'
  for i in range(1, bufnr('$'))
    let str = str.' '.bufname(i)
  endfor
  execute str
  execute a:cl.'w'
endfunction

command! -nargs=1 Bvimgrep  call BuffersVimgrep(<args>,'c')
command! -nargs=1 Blvimgrep call BuffersVimgrep(<args>,'l')

