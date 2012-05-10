" .vimrc

" ------------------------ Summary of custom mappings ------------------------
"   Keys     Modes   Action
"  <space>    nv    Fold Perl subroutine.
"  <F9>       nvi   Toggle paste mode.
"  <home>     ni    Smart home.
"  ;i<x>      n     Insert <x> under the cursor.
"  ;a<x>      n     Insert <x> after the cursor.
"  ;n         i     Toggle line numbers.
"  ;p         nv    Toggle paste mode.
"  ;r<x><y>   i     Copy register <x> to register <y> (where <x> & <y> are any
"                     alpha-numeric register names.
"  ;Ss        nv    Toggle display current subroutine name.
"  ;Sc        n     Scratch buffer.
"  ;s         n     Set s mark to the top of current sub and display sub name.
"  ;w         v     Word-wrap block.
"  ;;         nv    Start substitute command.
"  ;#         v     Wrap in "deleted_code" POD block.
"  ;(  ;)     v    \ 
"  ;{  ;}     v    | Wrap highlighted block in brackets or quotes. Open brackets
"  ;[  ;]     v    | or quotes leave the cursor at the start of the block,
"  ;<  ;>     v    | close brackets leave it at the end. (;C is a special case
"  ;"  ;'     v    | that wraps the block in 'C<< ... >>' for POD code snippits).
"  ;%  ;C     v    /
"  ;?         n     Show this help.
"  ;/         n     Search with results set to quickfix list.
"  ;!         n     Save and execute the current buffer in the shell.
"  ;<esc>     nv    Nothing.
"  ,          n     Replaces default behaviour of ; (i.e., repeat last fFtT).
"  <alt-pgup> n     Previous buffer.
"  <alt-pgdn> n     Next buffer.
"  {          i     Smart braces.
"  <C-b>      i     Dumb opening brace (for when you don't want a smart one).
"  gs         n     Set the " mark at the current position then jump to the
"                     declaration of the sub/function under cursor.
"  ;[[        n     Jump to the last sub/function declaration.
"  ;j         n     Jump to the previous item in the location list.
"  ;k         n     Jump to the previous item in the location list.
"  g;t        nv    Convert text to title case.
"  ]x         nv    Go to next line that begins differently and centre.
"  [x         nv    Go to previous line that begins differently and centre.
"  ~ Vimdiff commands ~
"  dc         n     Toggle between normal and diff colour schemes.
"  du         n     Diff update.
"  ]z         n     Jump to the next change and centre.
"  [z         n     Jump to the previous change and centre.
"  ~ Template Toolkit ~
"  ;%         n     Inserts [%  %], leaving in insert mode.
" ------------------------ Summary of custom commands ------------------------
"   Command            Action
"  :er                Save register to file.
"  :ir                Load register from file.
"  :eR                Save all registers to file.
"  :iR                Load all registers from file.
"  :RegCopy           Copy register.
"  :pi                Put from command line to buffer.
"  :PutImmediate      Put from command line to buffer.
"  :Pod               Create a POD heading for the current subroutine or
"                       function.
"  :W                 Write buffer to disk.
"  :Scratch           Scratch buffer.
"  :Subs              Find subroutines.
"  :Funs              Find functions.
"  :Grep              Search within this buffer, results to quickfix list.
"  :Bvimgrep          Search across buffers (results to quickfix list).
"  :Blvimgrep         Search across buffers (results to location list).
"  :Sqlautoreplace    Set useful abbreviations for writing SQL commands.
"  :Nosqlautoreplace  Remove the SQL abbreviations.
" ------------------------ A Few Useful Built-Ins ----------------------------
"  %     Jump to matching parenthesis
"  =%    Indent the code between parenthesis
"  >     Indent visual block.
"  <     Un-indent visual block.
"  [[    Jump to function start
"  [{    Jump to block start
"  I     Repeat an edit for each line of a visual-block (<C-v>).  "i" doesn't
"          work so "I" has to be used instead.  Other commands like, "s", "r",
"          "x" and "~", work as expected.
"  ]z    Move to the start of the current open fold.
"  [z    Move to the end of the curent open fold.
"  zj    Move to the next fold.
"  zk    Move to the previous fold.
"  ~ Vimdiff commands ~
"  ]c    Jump to the next.
"  [c    Jump to the previous change.
" ------------------------ Resources -----------------------------------------
"  http://raffy.ch/projects/vim.html  One of the best list of tips I've found.
" ----------------------------------------------------------------------------


" Remove ALL autocommands for the current group.
autocmd!

" Some settings only apply to the buffer they're called in.
autocmd BufNewFile,BufRead <buffer> set shiftwidth=4
autocmd BufNewFile,BufRead <buffer> set tabstop=4
autocmd BufNewFile,BufRead <buffer> set expandtab
autocmd BufNewFile,BufRead <buffer> set foldenable

syntax enable
set cmdheight=1
set autoindent
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set smartcase           " Do smart case matching.
set incsearch           " Incremental search.
set hidden              " Hide buffers when they are abandoned.

" ":set spell" turns the spell checker on, but this needs to be done for each
" file.  The setting is sticky, so you should only have to do it once for each
" file.  I decided not to put it in a "bufdo" loop, so I can decide per file
" whether I want spell checking on.  ":set nospell" turns spell checking off.
set spelllang=en_nz
let perl_include_pod=1  " Turns on syntax highlighting, with spell-check, inside POD portions of Perl files.

" MOUSE STUFF
" Make the middle click paste the clipboard _in paste mode_.
inoremap <S-Insert> "*p
" See :help mouse for other mouse options.


" DO NOTHING
" ; is used to begin many custom mappings, so <ESC> cancels waiting for a second key without flashing the
" screen or repeating the last fFtT command (which is the default behaviour of ;).
nnoremap ;<ESC> :echo ""<CR>


" REPEAT LAST fFtT COMMAND
" , replaces default behaviour of ;
nnoremap , ;


" HELP
" ;? shows help for custom mappings and commands.
source $HOME/.vim/functions/help_for_vimrc.vim


" SAVE AND EXECUTE CURRENT BUFFER
" ;! saves and executes the current buffer in the shell.
nnoremap ;! :w<CR>:!./%<CR>


" NEXT OR PREVIOUS BUFFER SHORTCUT
" <alt-pgup> for previous buffer, <alt-pgdn> for next buffer.
nnoremap [5;3~ :bp<CR>
nnoremap [6;3~ :bn<CR>


" Go to next/previous line that begins differently from the current one.
nnoremap ]x :if len(getline('.')) \| let @/='^\($\\|[^'.escape(getline('.')[0],'.[]*').']\)' \| else \| let @/='^.' \| endif<CR>nzz
nnoremap [x :if len(getline('.')) \| let @/='^\($\\|[^'.escape(getline('.')[0],'.[]*').']\)' \| else \| let @/='^.' \| endif<CR>Nzz
vnoremap ]x <ESC>'>:if len(getline('.')) \| let @/='^\($\\|[^'.escape(getline('.')[0],'.[]*').']\)' \| else \| let @/='^.' \| endif<CR>'<V'>n
vnoremap [x <ESC>'<:if len(getline('.')) \| let @/='^\($\\|[^'.escape(getline('.')[0],'.[]*').']\)' \| else \| let @/='^.' \| endif<CR>'>V'<N


"  FIND CURRENT SUB NAME
"  ;s sets s mark to the top of current sub and display sub name.
source $HOME/.vim/functions/find_currect_sub.vim


" FIND START OF CURRENT FUNCTION OR SUBROUTINE
" ;[[ jumps to the last sub/function declaration.
source $HOME/.vim/functions/find_function_or_sub_start.vim


" GOTO SUB/FUNCTION UNDER CURSOR
" gs jumps to the declaration of the sub/function under the cursor.
" Also sets the " mark so you can jump back to where the function is called from.
nnoremap gs m"/^\s*\(\(static\|private\|protected\|public\)\s\+\)*\(sub\|function!\{0,1\}\)\s\+<C-R><C-W>[ (\n]<CR>


" GET VIMDIFF SETTINGS
source $HOME/.vim/functions/vimdiff.vim


" CHANGE BG COLOUR TO MAKE IT OBVIOUS WHEN INSERT MODE IS ON
source $HOME/.vim/functions/change_insert_mode_colours.vim


" MAKE :W THE SAME AS :w
" This is a common typo I make.
:cabbrev W w


" WORD-WRAP BLOCK
" ;w wraps highlighted block to 80 characters.
vnoremap ;w  !fold -s -w80<CR>


" TITLE CASE
" g;t converts text to title case.
nnoremap g;t :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>
vnoremap g;t :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>


" SINGLE-CHARACTER INSERT
" ;ix inserts x under the cursor.
" ;ax inserts x after the cursor.
" Supports repetitions.
source $HOME/.vim/functions/single_char_insert.vim


" CONDITIONAL FOLDING
" Enables Perl folding for files that aren't too big (folding on big files can be slow).
" g:max_file_size_for_folding controls how big is considered to big.
" <Space> folds Perl subroutines.
source $HOME/.vim/functions/folding.vim


" TOGGLE LINE NUMBERS
" ;n toggles line numbers.
nnoremap ;n :set invnumber number?<CR>

" TOGGLE PASTE MODE
" ;p toggles paste mode.
nnoremap ;p     :set invpaste paste?<CR>
nnoremap <F9>   :set invpaste paste?<CR>
vnoremap ;p     <F9>
set pastetoggle=<F9>
set showmode


" CLEVER HOME KEY
" <Home> goes to the start of the line (like '0'), or first character on the line
" (like '^') if the cursor is already at the start.  Very handy in insert mode.
source $HOME/.vim/functions/clever_home_key.vim


" SMART BRACES
" Adds a } and starts a new line when a { is typed, but only when it makes
" sense to.  No special action is taken if paste mode is on.
source $HOME/.vim/functions/smart_braces.vim
" Dumb opening brace.
inoremap <C-b> {

" PARENTHESIS, SQUARE BRACKET, BRACE, QUOTE EXPANDING
" ;<open bracket or quote> or ;<close bracket> wraps the visual-mode higlighted 
" block in a bracket or quote pair.  Using an opening bracket or quote leaves the 
" cursor at the start of the block, where a closing bracket leaves it at the end 
" of the block. Works for: (, [, {, ", ', %.
" ;C is a special case that wraps the block in 'C<< ... >>' for POD code snippits.

" " In insert mode, these bracket pairs typed quickly will automatically move the
" " cursor left to be inside the brackets or quotes: (), [], {}, <>, "", '' and %%.
" "  ()  []     i    \
" "  {}  <>     i    | Moves the cursor inside the character pair.
" "  ""  ''     i    |
" "  %%         i    /
source $HOME/.vim/functions/expand_brackets.vim


" SHOW CURRENT SUB ON STATUS LINE
" ;Ss
" Disabled for subroutines of g:maxlines_in_sub lines.
source $HOME/.vim/functions/show_current_sub.vim


" EXPORT / IMPORT REGISTERS
" :er <r> to save register <r> to file.
" :ir <r> to load register <r> from file.
" :eR to save all registers to file.
" :iR to load all registers from file.
" See the file for more help.
source $HOME/.vim/functions/export_import_registers.vim


" COPY REGISTER
" :Re[gCopy] <a> <b><CR> copies contents of register <a> to register <b>.
" ;r<a><b> (in normal mode), but this has to be typed quickly.
source $HOME/.vim/functions/copy_registers.vim


" PUT SOMETHING FROM THE COMMAND LINE TO THE BUFFER
" :PutImmediate <x> writes <x> to the active buffer at the current cursor position.
" :pi <a> is an abbreviation for this.
" Sets register '"' as a side-effect.
" See the file for more help.
source $HOME/.vim/functions/put_immediate.vim


" CREATE POD HEADING FOR CURRENT SUBROUTINE OR FUNCTION
" :Pod inserts a POD heading immediately above the subroutine or function that the
" cursor is currently in.
source $HOME/.vim/functions/pod_sub_heading.vim


" SUBSTITUTE COMMANDS SHORTCUTS
" ;; starts substitute commands.
:noremap ;; :%s:::g<Left><Left><Left>
:vnoremap ;; :s:::g<Left><Left><Left>


" FIND SUBROUTINES AND FUNCTIONS
" :Su[ubs] populates (and then opens) the location list with the first lines
" of subroutine declarations (i.e., lines starting with the word "sub") in the
" current buffer.
" :Fu[ns] does the same thing but for function declarations (lines starting
" with the word "function" proceded by zero or more function modifier keywords).
command! Subs  lvimgrep /^\s*sub\>/ % | lw
command! Funs  lvimgrep /^\s*\(\(static\|private\|protected\|public\)\s\+\)*function\>/ % | lw


" GREP
" ;/ searches with results set to location list.
command! -nargs=1 Grep lvimgrep <args> % | cw
nnoremap ;/ :Grep //<left>
nnoremap ;j :lnext<CR>
nnoremap ;k :lprevious<CR>

" SEARCH ACROSS BUFFERS
" Looks for a pattern in all the open buffers.
" :Bvimgrep 'pattern' puts results into the quickfix list
" :Blvimgrep 'pattern' puts results into the location list
source $HOME/.vim/functions/search_across_buffers.vim


" SCRATCH BUFFER
" :Scratch or ;Sc switches to a scratch buffer.
source $HOME/.vim/functions/scratch_buffer.vim


" ENCLOSE IN POD "deleted_code" BLOCK
" ;# wraps the highlighted code in a "deleted_code" POD block.
vnoremap ;# d:let tmp=&paste<CR>:set paste<CR>O<CR>=begin deleted_code<CR><CR><CR>=end deleted_code<CR><CR>=cut<CR><ESC>kkkkkp:let &paste=tmp<CR>:echo "deleted_code"<CR>


" SHOW BUFFERS ON LAUNCH
" List all the buffers when launching Vim, but only if there is more than one.
source $HOME/.vim/functions/show_buffers_on_launch.vim


" SQL AUTOREPLACE
" :Sqlautoreplace sets useful abbreviations for writing SQL commands.
" :Nosqlautoreplace removes the abbreviations.
source $HOME/.vim/functions/sql_autoreplace.vim


"  ~ TEMPLATE TOOLKIT ~
nnoremap ;% i[%  %]<left><left><left>


" " PERSISTENT UNDO
" set undofile                " Save undo's after file closes
" set undodir=$HOME/.vim/undo " where to save undo histories
" set undolevels=1000         " How many undos
" set undoreload=10000        " number of lines to save for undo


" " Set the time-out for multi-character mappings.
" " Since mapping time-out settings by default also set the time-outs for
" " multi-character 'keys codes' (like <F1>), you should also set ttimeout and
" " ttimeoutlen: otherwise, you will experience strange delays as Vim waits for a
" " keystroke after you hit ESC (it will be waiting to see if the ESC is actually
" " part of a key code like <F1>). If you experience problems and have a slow
" " terminal or network connection, set it higher.
" " If you don't set ttimeoutlen, the value for timeoutlent (default: 1000 = 1
" " second, which is sluggish) is used.
" set timeoutlen=4000
" set ttimeout 
" set ttimeoutlen=100

" See file "termcap-settings" for default termcap settings.

