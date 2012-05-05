" CHANGE BG COLOUR TO MAKE IT OBVIOUS WHEN INSERT MODE IS ON
" Note this is set up for a black-on-white terminal.


" OPTION 1: Change the entire background (this can be take a long time over slow connections).
":au InsertEnter * hi Normal ctermbg=3
":au InsertEnter * hi Statement cterm=bold
":au InsertEnter * hi Identifier cterm=bold
":au InsertLeave * hi Normal ctermbg=8
":au InsertLeave * hi Statement cterm=NONE
":au InsertLeave * hi Identifier cterm=NONE


" OPTION 2: Change the cursor colour (this plays with the terminal settings, and you lose the nice feature of the cursor simply transposing the foreground and background).
"if &term =~ "xterm\\|rxvt"
"
"    " use an orange cursor in insert mode
"    let &t_SI = "\<Esc>]12;orange\x7"
"    " use a red cursor otherwise
"    let &t_EI = "\<Esc>]12;red\x7"
"    silent !echo -ne "\033]12;red\007"
"    " reset cursor when vim exits
"    autocmd VimLeave * silent !echo -ne "\033]112\007"
"    " use \003]12;gray\007 for gnome-terminal
"
"elseif &term =~ "screen"
"    " For screen, need to escape sequences with \e ... \\
"
"    " use an orange cursor in insert mode
"    let &t_SI = "\e\<Esc>]12;orange\x7\\"
"    " use a red cursor otherwise
"    let &t_EI = "\e\<Esc>]12;red\x7\\"
"    silent !echo -ne "\e\033]12;red\007\\"
"    " reset cursor when vim exits
"    autocmd VimLeave * silent !echo -ne "\e\033]112\007\\"
"    " use \003]12;gray\007 for gnome-terminal
"
"endif


" OPTION 3: Highlight the cursor line.

" Option 3a: Always have a cursor line (you lose syntax highlighting on the highlighted line).
"" Enable CursorLine
"set cursorline
"" Default Colors for CursorLine
"highlight  CursorLine ctermbg=None ctermfg=None
"" Change Color when entering Insert Mode
"autocmd InsertEnter * highlight  CursorLine ctermbg=Red ctermfg=White
"" Revert Color to default when leaving Insert Mode
"autocmd InsertLeave * highlight  CursorLine ctermbg=None ctermfg=None

" Option 3b: Only have a cursor line in insert mode.
highlight CursorLine ctermbg=Red ctermfg=White
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline
