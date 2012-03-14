" CHANGE BG COLOUR TO MAKE IT VERY OBVIOUS WHEN INSERT MODE IS ON
" Note this is set up for a black-on-white terminal.

:au InsertEnter * hi Normal ctermbg=3
:au InsertEnter * hi Statement cterm=bold
:au InsertEnter * hi Identifier cterm=bold
:au InsertLeave * hi Normal ctermbg=8
:au InsertLeave * hi Statement cterm=NONE
:au InsertLeave * hi Identifier cterm=NONE

