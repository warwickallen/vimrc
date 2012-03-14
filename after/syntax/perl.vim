" ~/.vim/after/syntax/perl.vim


" ~~ SQL ~~
let s:bcs = b:current_syntax
unlet b:current_syntax
syntax include @SQL syntax/sql.vim
let b:current_syntax = s:bcs
syntax region perlHereDocSQL start=+<<['"]\?SQL['"]\?.*;\s*$+ end=+^\s*SQL$+ contains=@SQL


" ~~ MYSQL ~~
let s:bcs = b:current_syntax
unlet b:current_syntax
syntax include @MYSQL syntax/mysql.vim
let b:current_syntax = s:bcs
syntax region perlHereDocMYSQL start=+<<['"]\?MYSQL['"]\?.*;\s*$+ end=+^\s*MYSQL$+ contains=@MYSQL


" ~~ HTML ~~
let s:bcs = b:current_syntax
unlet b:current_syntax
syntax include @HTML syntax/html.vim
let b:current_syntax = s:bcs
syntax region perlHereDocHTML start=+<<['"]\?HTML['"]\?.*;\s*$+ end=+^\s*HTML$+ contains=@HTML


" ~~ XML ~~
let s:bcs = b:current_syntax
unlet b:current_syntax
syntax include @XML syntax/xml.vim
let b:current_syntax = s:bcs
syntax region perlHereDocXML start=+<<['"]\?XML['"]\?.*;\s*$+ end=+^\s*XML$+ contains=@XML

