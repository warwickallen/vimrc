" HELP
" ;? shows help for custom mappings and commands.

function! HelpForVimRC()
  help help
  set modifiable
  silent execute "normal ggdG"
  read $HOME/.vimrc
  silent execute 'normal ggV/^" --kd/^\s*$dG:%s/^" //gggL'
  set nomodified
  set nomodifiable
endfunction

nnoremap ;? :call HelpForVimRC()<CR>
