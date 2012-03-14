" COPY REGISTERS
" :Re[gCopy] <a> <b><CR> copies contents of register <a> to register <b>.
" ;r<a><b> (in normal mode), but this has to be typed quickly.

function! CopyRegister(src_reg, dst_reg)
  execute "let contents = getreg('".a:src_reg."')"
  let result = setreg(a:dst_reg, contents)
  echo "Copied contents of register '".a:src_reg."' to register '".a:dst_reg."'"
endfunction

command! -register -nargs=1 RegCopy :execute "call CopyRegister('<reg>', '<args>')"

let my_registers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
for src_reg in my_registers
  for dst_reg in my_registers
    execute "nmap ;r".src_reg.dst_reg." :RegCopy ".src_reg." ".dst_reg."<CR>"
  endfor
endfor
