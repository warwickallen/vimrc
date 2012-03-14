" EXPORT / IMPORT REGISTERS
" ":er <r>" to save register <r> to file.
" ":ir <r>" to load register <r> from file.
" ":eR" to save all registers to file.
" ":iR" to load all registers from file.
" Example:
"   Type ":er<C-]>ab<CR>" to save registers "a" and "b" to file
"   and  ":ie<C-]>ab<CR>" to load them up again.
"
" ":call ExportRegisters(<register names>,<identifier>)"
" (where <register names> is a string of all the registers to
" retrieve) will save the specified registers in files suffixed
" with <identifier>.  This allows for several versions of the
" same register to be saved.  Similarly,
" ":call ImportRegisters(<register names>,<identifier>)"
" will load a particular version of the registers.
"
" If a register has been exported in the past, the previously
" exported contents will be kept as an "old" version and can
" be retrived with
" ":call ImportRegisters(<register names>,'old')".
"
" :call BrowseRegisters() displays the contents of all the
" saved registers.

let s:register_dir = $HOME."/.vim/registers/"

function! IsInList(check_list, item)
  for check_item in a:check_list
    if a:item == check_item
      return 1
    endif
  endfor
  return 0
endfunction

let g:valid_registers = ['"', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'z', '-', '/', '*', '+', '~', '.', ':', '%', '#']
let g:writable_registers = ['"', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'z', '-', '/']

function! RegName2FName(RegName)
  if a:RegName == '#'
    let reg_name = '_hash'
  elseif a:RegName == '/'
    let reg_name = '_forward_slash'
  elseif a:RegName == '*'
    let reg_name = '_asterisk'
  elseif a:RegName == '-'
    let reg_name = '_hyphen'
  elseif a:RegName == '.'
    let reg_name = '_dot'
  else
    let reg_name = a:RegName
  endif
  return s:register_dir.reg_name
endfunction

function! ExportRegisters(RegNames,...)
  if !isdirectory($HOME."/.vim/registers/")
    call system("mkdir ".s:register_dir)
  endif
  let appendage = ''
  if a:0 > 0
    let appendage = '.'.a:1
  endif
  for reg_name in split(a:RegNames, '\zs')
    if IsInList(g:valid_registers, reg_name)
      let fname = RegName2FName(reg_name).appendage
      echo("exporting register '".reg_name."' to '".fname."'")
      if glob(fname) != ''
        call system("mv '".fname."' '".fname.".old'")
      endif
      let contents = add([], eval("@".reg_name))
      call writefile(contents, fname)
    endif
  endfor
endfunction

function! ImportRegisters(RegNames,...)
  let appendage = ''
  if a:0 > 0
    let appendage = '.'.a:1
  endif
  for reg_name in split(a:RegNames, '\zs')
    if IsInList(g:writable_registers, reg_name)
      let fname = RegName2FName(reg_name).appendage
      if filereadable(fname)
        echo("importing register '".reg_name."' from '".fname."'")
        let contents = remove(readfile(fname), 0)
        execute ":let @".reg_name."=contents"
      else
        echo("cannot find file '".fname."'!")
      endif
    endif
  endfor
endfunction

function! BrowseRegisters()
  let fname = s:register_dir.".head"
  call system("head '".s:register_dir."'* >'".fname."'")
  new
  execute "edit ".fname
  call system("rm '".fname."'")
endfunction


cab er call ExportRegisters('')<Left><Left>
cab eR call ExportRegisters('"0123456789abcdefghilmnopqrstuwxz-/*+~.:%#')
cab ir call ImportRegisters('')<Left><Left>
cab iR call ImportRegisters('"0123456789abcdefghilmnopqrstuwxz-/')
