" SQL AUTOREPLACE
" :Sqlautoreplace sets useful abbreviations for writing SQL commands.
" :Nosqlautoreplace removes the abbreviations.

function! Set_SQL_autoreplace()
  iabbrev ct CREATE TABLE
  iabbrev at ALTER TABLE
  iabbrev ac ALTER COLUMN
  iabbrev nn NOT NULL
  iabbrev ai AUTO_INCREMENT
  iabbrev df DEFAULT
  iabbrev pk PRIMARY KEY
  iabbrev fk FOREIGN KEY
  iabbrev uk UNIQUE KEY
  iabbrev rf REFERENCES
  iabbrev cm COMMENT
  iabbrev uc ON UPDATE CASCADE
  iabbrev ii INSERT INTO
  iabbrev vals VALUES

  iabbrev tint tinyint
  iabbrev sint smallint
  iabbrev mint mediumint
  iabbrev bint bigint

  iabbrev us unsigned
  iabbrev utint tinyint unsigned
  iabbrev usint smallint unsigned
  iabbrev umint mediumint unsigned
  iabbrev uint  int unsigned
  iabbrev ubint bigint unsigned

  iabbrev dec decimal
  iabbrev chr char
  iabbrev yn enum('Y','N')
  iabbrev tstmp TIMESTAMP
  iabbrev ctstmp CURRENT_TIMESTAMP
endfunction

function! Clear_SQL_autoreplace()
  unabbrev ct
  unabbrev at
  unabbrev ac
  unabbrev nn
  unabbrev ai
  unabbrev df
  unabbrev pk
  unabbrev fk
  unabbrev uk
  unabbrev rf
  unabbrev cm
  unabbrev ii
  unabbrev vals

  unabbrev uc

  unabbrev tint
  unabbrev sint
  unabbrev mint
  unabbrev bint

  unabbrev us
  unabbrev utint
  unabbrev usint
  unabbrev umint
  unabbrev uint 
  unabbrev ubint

  unabbrev dec
  unabbrev chr
  unabbrev yn
  unabbrev tstmp
  unabbrev ctstmp
endfunction

command! Sqlautoreplace call Set_SQL_autoreplace()
command! Nosqlautoreplace call Clear_SQL_autoreplace()
