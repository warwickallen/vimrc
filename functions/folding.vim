" FOLDING
" Enables folding for files that are no larger than
" g:max_file_size_for_folding

let perl_fold = 1
let g:max_file_size_for_folding = 1048576

" In normal mode, press Space to toggle the current fold open/closed. However,
" if the cursor is not in a fold, move to the right (the default behavior). In
" addition, with the manual fold method, you can create a fold by visually
" selecting some lines, then pressing Space.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

"" Remember folds.
"if filereadable('<afile>')
"  au BufWinLeave * mkview
"endif
"if filereadable('<afile>')
"  au BufWinEnter * silent loadview
"endif

function! FileSizeOkForFolding(file_name)
  let file_size = getfsize(a:file_name)
  return file_size > 1 && file_size <= g:max_file_size_for_folding
endfunction

function! FoldingCallbackWhenLeavingABuffer()
  let file_name = expand('%')
  let fsize_ok = FileSizeOkForFolding(file_name)
  if filereadable(file_name) && fsize_ok
    mkview
  endif
endfunction

function! FoldingCallbackWhenEnteringABuffer()
  let file_name = expand('%')
  let fsize_ok = FileSizeOkForFolding(file_name)
  if fsize_ok
    set foldenable
    let perl_fold = 1
  else
    set nofoldenable
    let perl_fold = 0
  endif
  if filereadable(file_name) && fsize_ok
    loadview
  endif
endfunction

command! -nargs=0 FoldingWhenLeaving  call FoldingCallbackWhenLeavingABuffer()
command! -nargs=0 FoldingWhenEntering call FoldingCallbackWhenEnteringABuffer()
autocmd! BufWinLeave * FoldingWhenLeaving
autocmd! BufWinEnter * FoldingWhenEntering


" " Fold on braces with <F3>
" nmap <F3> 0v/{<CR>%zf
