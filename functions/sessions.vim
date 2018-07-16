" SAVE AND RELOAD SESSIONS
" :Sa[veSession] <name><CR> saves the current session.
" :Loa[dSession] <name><CR> saves the current session.

function! GetSessionPath(session_name)
  if !exists('g:session_directory')
    let g:session_directory = '~/.vim/sessions'
  endif

  let s:session_path = fnamemodify(g:session_directory, ':p')
  if !isdirectory(s:session_path)
    call mkdir(s:session_path, 'p')
  endif
  if filewritable(s:session_path) != 2
    let s:msg = printf('The sessions directory %s is not writable', s:session_path)
    echoerr(msg)
    unlet s:msg
    finish
  endif

  let s:session_path = fnamemodify(s:session_path . a:session_name . '.vim', ':p')
  return s:session_path
endfunction


function! SaveSession(session_name)
  let s:session_path = GetSessionPath(a:session_name)
  execute "mksession! ".s:session_path
endfunction

command! -nargs=1 SaveSession :execute "call SaveSession('<args>')"


function! LoadSession(session_name)
  let s:session_path = GetSessionPath(a:session_name)
  execute "source ".s:session_path
endfunction

command! -nargs=1 LoadSession :execute "call LoadSession('<args>')"
