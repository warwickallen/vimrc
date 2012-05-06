" PARENTHESIS, SQUARE BRACKET, BRACE, QUOTE EXPANDING
" ;<open bracket or quote> or ;<close bracket> wraps the visual-mode higlighted 
" block in a bracket or quote pair.  Using an opening bracket or quote leaves the 
" cursor at the start of the block, where a closing bracket leaves it at the end 
" of the block. Works for: (, [, {, ", ', %.
" ;C is a special case that wraps the block in 'C<< ... >>' for POD code snippits.
"
" In insert mode, these bracket pairs typed quickly will automatically move the
" cursor left to be inside the brackets or quotes: (), [], {}, <>, "", '' and %%.

function! WrapBlockInBrackets(opening_bracket, finish_at_top) range
  let l:closing_bracket =
    \ a:opening_bracket == 'C' ? ' >>' :
    \ a:opening_bracket == '(' ? ')' :
    \ a:opening_bracket == '"' || a:opening_bracket == "'" || a:opening_bracket == '%' ? a:opening_bracket :
    \ nr2char(char2nr(a:opening_bracket) + 2)
  let l:new_opening_bracket = a:opening_bracket == 'C' ? 'C<< ' : a:opening_bracket
  let paste_mode = &paste
  let vmode = visualmode()
  if vmode ==# 'v'
    set paste
    if  a:finish_at_top
      execute "normal `>a".l:closing_bracket."\<esc>`<i".l:new_opening_bracket."\<esc>"
    else
      execute "normal `<i".l:new_opening_bracket."\<esc>`>la".l:closing_bracket."\<esc>"
    endif
  elseif vmode == 'V'
    normal! gv>
    set nopaste
    if  a:finish_at_top
      execute "normal `>o".l:closing_bracket."\<esc><h`<O.\<esc>:set paste\<cr>s".l:new_opening_bracket."\<esc><h"
    else
      execute "normal `<O.\<esc>:set paste\<cr>s".l:new_opening_bracket."\<esc><h`>o".l:closing_bracket."\<esc><h"
    endif
  elseif vmode == "\<C-V>"
    set paste
    let finish_pos = a:finish_at_top ? getpos("'<") : getpos("'>")
    let vleft = min([col("'<"), col("'>")])
    let vright = max([col("'<"), col("'>")]) + 1
    for line in range(a:firstline, a:lastline)
      call setpos('.', [0, line, vleft, 0])
      execute "normal i".l:new_opening_bracket."\<esc>"
      call setpos('.', [0, line, vright, 0])
      execute "normal a".l:closing_bracket."\<esc>"
    endfor
    if a:finish_at_top
      call setpos('.', [0, a:firstline, vleft, 0])
    else
      call setpos('.', [0, a:lastline, vright + 1, 0])
    end
  endif
  if paste_mode
    set paste
  else
    set nopaste
  end
endfunction

vnoremap ;( :call WrapBlockInBrackets('(', 1)<cr>
vnoremap ;) :call WrapBlockInBrackets('(', 0)<cr>
vnoremap ;[ :call WrapBlockInBrackets('[', 1)<cr>
vnoremap ;] :call WrapBlockInBrackets('[', 0)<cr>
vnoremap ;{ :call WrapBlockInBrackets('{', 1)<cr>
vnoremap ;} :call WrapBlockInBrackets('{', 0)<cr>
vnoremap ;< :call WrapBlockInBrackets('<', 1)<cr>
vnoremap ;> :call WrapBlockInBrackets('<', 0)<cr>
vnoremap ;" :call WrapBlockInBrackets('"', 1)<cr>
vnoremap ;' :call WrapBlockInBrackets("'", 1)<cr>
vnoremap ;C :call WrapBlockInBrackets("C", 1)<cr>
vnoremap ;% :call WrapBlockInBrackets("%", 1)<cr>

inoremap () ()<LEFT>
inoremap [] []<LEFT>
inoremap {} {}<LEFT>
inoremap <> <><LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap %% %%<LEFT>
