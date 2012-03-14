" PUT SOMETHING FROM THE COMMAND LINE TO THE BUFFER
" :PutImmediate <x> writes <x> to the buffer at the current cursor position.
" :pi <a> is an abbreviation for this.
" Sets register '"' as a side-effect.
" Examples:
"   :pi ^R^W<CR>  will insert the current file name.
"   :pi @%<CR>    will do the same

function! PutImmediate(x)
  let result = setreg('"', a:x)
  let i = col('.') - 1
  let this_line = getline('.')
  let result = setline('.', strpart(this_line, 0, i).a:x.strpart(this_line, i))
endfunction

command! -nargs=1 PutImmediate call PutImmediate(<args>)
cabbr pi PutImmediate
