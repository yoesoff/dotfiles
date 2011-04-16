" Vim indent file
" Language: Redcode
" Maintainer: Andreas Herrmann <andrherr@student.ethz.ch>
" Last Change: 2008 Jan 30

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" TODO still EXPERIMENTAL
finish

" indent expression
setlocal indentexpr=GetRedIndent()

" indent keys
" Input
setlocal indentkeys=o,O,<TAB>,!^F
" Comment
setlocal indentkeys+=0;
" Operators
setlocal indentkeys+=0=~dat,0=~mov,0=~add,0=~sub,0=~jmp,0=~jmz,0=~djn
setlocal indentkeys+=0=~slt,0=~cmp,0=~spl
setlocal indentkeys+=0=~mul,0=~div,0=~mod,0=~seq,0=~sne,0=~nop
setlocal indentkeys+=0=~ldp,0=~stp
" Pseudo operators
setlocal indentkeys+=0=~equ,0=~end,0=~for,0=~rof
setlocal indentkeys+=0=~org
setlocal indentkeys+=0=~pin

" Only define the function once.
if exists("*GetRedIndent()")
  finish
endif

function GetRedIndent()
  echo "Indent"
  return 0
endfunction
