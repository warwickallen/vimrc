" SHOW CURRENT SUB ON STATUS LINE
" Implemented for Perl and Vimrc files.
" This is disabled for subroutines of g:maxlines_in_sub lines (which defaults
" to 1000) because it slows Vim down too much for big subroutines.

let g:maxlines_in_sub = 1000
let s:show_current_sub = 0

nnoremap ;Ss :call ToggleShowCurrentSub()<CR>
vnoremap ;Ss :call ToggleShowCurrentSub()<CR>

highlight User1 ctermbg=black ctermfg=magenta guibg=blue  guifg=white
highlight User3 ctermbg=black ctermfg=magenta guibg=blue  guifg=white

function! ToggleShowCurrentSub()
  let s:show_current_sub = !s:show_current_sub
  set statusline=
  if (s:show_current_sub)
    set statusline+=%1*
    set statusline+=%f
    set statusline+=%{CurrSubName()}
    set statusline+=\ %y\ %m%r%h%w
    set statusline+=%=
    set statusline+=%3*
    set statusline+=%-110.130([L:\ %l/%L\ %p%%]\ [C:\ %c%V]%)
    set laststatus=2
  else
    set laststatus=1
  endif
endfunction

function! CurrSubName()
  let g:filename = expand("%")
  let g:subname = ""
  let g:bracketcount = 0
  let g:trueloop = 1

  " See if this is a Perl file
  let l:firstline = getline(1)

  if ( l:firstline =~ '#!.*perl' || l:firstline =~ '^package ' || g:filename =~ '\.pl$' || g:filename =~ '\.pm$' || g:filename =~ '\.cgi' )
    call GetSubNamePerl(line("."))
  elseif ( l:firstline =~ '" VIMRC FILE' || g:filename =~ '\.vimrc$' )
    call GetSubNameVim(line("."))
  endif

  return g:subname
endfunction

function! GetSubNamePerl(line)
  let l:str = getline(a:line)
  let l:strorig = l:str
  let l:ourline = a:line
  let l:lines_in_sub = 0

  if l:str =~ '^ *sub '
    let l:str = substitute( l:str, " *{.*", "", "" )
    let l:str = substitute( l:str, " *sub *", ": ", "" )
    let g:subname = l:str
    return 1
  elseif l:str =~ '^BEGIN *{'
    let l:str = substitute( l:str, " *{.*", "", "" )
    let l:str = substitute( l:str, "^", ": ", "" )
    let g:subname = l:str
    return 1
  elseif l:str =~ '^END *{'
    let l:str = substitute( l:str, " *{.*", "", "" )
    let l:str = substitute( l:str, "^", ": ", "" )
    let g:subname = l:str
    return 1
  elseif l:ourline > 2
    while g:trueloop == 1 && l:lines_in_sub < g:maxlines_in_sub
      " get } count
      if l:str =~ '}'
        let l:str2 = l:str
        while l:str2 =~ '}'
          let g:bracketcount = g:bracketcount - 1
          let l:str2 = substitute( l:str2, "[^}]*}", "", "" )
        endwhile
      endif
      " get { count
      if l:str =~ '{'
        let l:str3 = l:str
        while l:str3 =~ '{'
          let g:bracketcount = g:bracketcount + 1
          let l:str3 = substitute( l:str3, "[^{]*{", "", "" )
        endwhile
      endif
      if l:str =~ '^ *sub '
        let g:trueloop = 0
      elseif l:str =~ '^BEGIN *{'
        let g:trueloop = 0
      elseif l:str =~ '^END *{'
        let g:trueloop = 0
      elseif l:ourline > 2
        let l:ourline = l:ourline -1
        let l:lines_in_sub = l:lines_in_sub+1
        let l:str = getline(l:ourline)
      elseif l:ourline <= 2
        return -1
      endif
    endwhile
  else
    return -1
  endif

  if l:lines_in_sub >= g:maxlines_in_sub
    let g:subname = ": Too many lines in sub"
    return 1
  endif
  if g:bracketcount > 0
    let l:str = substitute( l:str, " *{.*", "", "" )
    if l:str =~ '^ *sub '
      let l:str = substitute( l:str, " *sub *", ": ", "" )
    elseif l:str =~ '^BEGIN'
      let l:str = substitute( l:str, "^", ": ", "" )
    elseif l:str =~ '^END'
      let l:str = substitute( l:str, "^", ": ", "" )
    endif
    let g:subname = l:str
    return 1
  elseif g:bracketcount == 0
    if l:strorig =~ '^ *}'
      let l:str = substitute( l:str, " *{.*", "", "" )
      if l:str =~ '^ *sub '
        let l:str = substitute( l:str, " *sub *", ": ", "" )
      elseif l:str =~ '^BEGIN'
        let l:str = substitute( l:str, "^", ": ", "" )
      elseif l:str =~ '^END'
        let l:str = substitute( l:str, "^", ": ", "" )
      endif
      let g:subname = l:str
      return 1
    else
      return -1
    endif
  else 
    return -1
  endif
endfunction

function! GetSubNameVim(line)
  let l:str = getline(a:line)
  let l:strorig = l:str
  let l:ourline = a:line

  if l:str =~ '^ *function '
    let l:str = substitute( l:str, "function!", "function", "" )
    let l:str = substitute( l:str, " *function *", ": ", "" )
    let g:subname = l:str
    return 1
  elseif l:ourline > 2
    while g:trueloop == 1
      if ( l:str =~ '^ *endfunction' && l:strorig !~ '^ *endfunction')
        return -1
      elseif l:str =~ '^ *function'
        let g:trueloop = 0
        let l:str = substitute( l:str, "function!", "function", "" )
        let l:str = substitute( l:str, " *function *", ": ", "" )
        let g:subname = l:str
        return 1
      elseif l:ourline > 2
        let l:ourline = l:ourline -1
        let l:str = getline(l:ourline)
      elseif l:ourline <= 2
        return -1
      endif
    endwhile
  else
    return -1
  endif
endfunction
