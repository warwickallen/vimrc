" vimdiff rc

set diffopt  =filler " Add vertical spaces to keep left and right pane aligned.
set diffopt +=iwhite " Ignore whitespace.

" Other diffopt settings:
" - icase       (ignore case)
" - horizontal  (horizontal windows)

" Tweak the colours.
highlight DiffText ctermfg=2 cterm=bold ctermbg=1

" Some useful commands:
"   do              Obtain changes from other window into the current window.
"   dp              Put the changes from current window into the other window.
"   du              Diff update.
"   dc              Toggle color settings to suit vimdiff.
"   ]c              Jump to the next change.
"   [c              Jump to the previous change.
"   ]z              Jump to the next change and centre.
"   [z              Jump to the previous change and centre.
"   <C-W> + <C-W>   Switch to the other split window.
"   zo              Open folded text.
"   zc              Close folded text.

function! VimDiffMode()
  let s:vimdiff_mode = !s:vimdiff_mode
  if s:vimdiff_mode
    highlight Comment cterm=none

    " These are useful for looking at diff files not with vimdiff.
    nnoremap ]z /^ .*\_\s[-+]<CR>jzz
    nnoremap [z ?^[-+].*\_\s <CR>zz

  else
    highlight Comment cterm=bold

    nnoremap ]z ]czz
    nnoremap [z [czz

    echo "VimDiff mode on"
  endif
  highlight Comment ctermfg=4
endfunction

nnoremap du :diffupdate<CR>
nnoremap dc :call VimDiffMode()<CR>

let s:vimdiff_mode = 0
call VimDiffMode()
