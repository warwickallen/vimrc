" SMART BRACES
" Adds a } and starts a new line when a {<CR> is typed, but only when it makes
" sense to.  Assumes no-smartindent and turns on autoindent.
" Only does magic if:
"   - paste mode is not on,
"   - the cursor is at the end of the line and
"   - the line is empty, only contains white space or starts with if, sub etc.
"   - the line has an open parenthesis on it (so it works for "if ($hash{$value})").

function! SmartBrace_checkWord(this_line, start_idx, word)
  let l:word_len = strlen(a:word)
  let l:next_char = strpart(a:this_line, a:start_idx + l:word_len, 1)
  return strpart(a:this_line, a:start_idx, l:word_len) == a:word && (l:next_char == ' ' || l:next_char == '{' || l:next_char == '(' || l:next_char == "\t")
endfunction

"   let last_char_is_brace = strpart(this_line, line_length - 2, 1) == '{'
"   let do_magic = !&paste && last_char_is_brace
function! SmartBrace()
  set autoindent
  let column_num = col('.')
  let line_num = line('.')
  let this_line = getline(line_num)
  let line_length = strlen(this_line)
  "let is_empty_line = line_length < 1
  let is_empty_line = match(this_line, '^\s*{') == 0
  let is_at_end_of_line = column_num == line_length
  let open_parens = matchlist(this_line, '(')
  let close_parens = matchlist(this_line, ')')
  let line_has_open_bracket = len(open_parens) > len(close_parens)
  let do_magic = !&paste && (is_empty_line || is_at_end_of_line) && !line_has_open_bracket
  if do_magic && !is_empty_line
    let i = -1
    let found_word = 0
    while i < (line_length - 1) && !found_word
      let i = i + 1
      let c = strpart(this_line, i, 1)
      let found_word = c != " " && c != "\t"
    endwhile
    let do_magic = !found_word
    if found_word
      let do_magic = SmartBrace_checkWord(this_line, i, 'if')      ||
                   \ SmartBrace_checkWord(this_line, i, 'elsif')   ||
                   \ SmartBrace_checkWord(this_line, i, 'else')    ||
                   \ SmartBrace_checkWord(this_line, i, 'do')      ||
                   \ SmartBrace_checkWord(this_line, i, 'sub')     ||
                   \ SmartBrace_checkWord(this_line, i, 'while')   ||
                   \ SmartBrace_checkWord(this_line, i, 'unless')  ||
                   \ SmartBrace_checkWord(this_line, i, 'for')     ||
                   \ SmartBrace_checkWord(this_line, i, 'foreach') ||
                   \ SmartBrace_checkWord(this_line, i, 'function')
    endif
  endif
  if do_magic
    "let result = setline(line_num, this_line.'{')
    execute "normal o}\<esc>kA\<cr>\<tab>\<esc>"
 " else
 "   let result = setline(line_num, strpart(this_line,0,column_num).'{'.strpart(this_line,column_num))
 "   let result = setpos('.',[0,line_num,column_num+1,0])
  endif
endfunction

inoremap <silent> { {<ESC>:call SmartBrace()<CR>a
