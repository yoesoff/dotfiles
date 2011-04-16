augroup filetypedetect
" Redcode filetype detection
	au BufRead,BufNewFile ?\+.red	setf redcode
" My Website content filetype detection
	au BufRead,BufNewFile *.con	set ft=xhtml
" CUDA c files
	au BufRead,BufNewFile *.cu	set ft=c
" Lilypond files
        au BufNewFile,BufRead *.ly      setf lilypond
" shell scripts
	au BufRead,BufNewFile *.ch	set ft=sh
augroup END
