"--------------------------------------------------------------------
" Vim Einstellungsdatei
"--------------------------------------------------------------------
" Diese Datei sollte alle Einstellungen enthalten, die Vim im
" Allgemeinen und im Speziellen betreffen. Einstellungen, die GVim
" im Speziellen betreffen gehören in $HOME/.gvimrc .
"
" Alle Einstellungen sind grob in vier Bereiche eingeteilt:
" - Generelle Einstellungen
" - Key mappings für eigene Makros
" - Skript-spezifische Einstellungen
" - Spielplatz (Testweise eingebaute Einstellungen, Makros und
"   Snippets. Einstellungen, die wirklich nur kurz ausprobiert
"   werden sollen, sollten zunächst in einer seperaten Datei stehen
"   und per source eingebunden werden.)
"
" Sollten einige dieser Einstellungsbereiche zu groß werden, oder zu
" einem bestimmten Skript zu viele Einstellungen nötig sein, lohnt es
" sich diese in eine eigene Datei zu exportieren und in dieser Datei
" per source einzubinden.
" Alle Einstellungen sollte sorgfältig und am besten mit Zweck,
" Quelle, Autor kommentiert werden!
"
" Diese Tipps stammen aus "Hacking Vim" von Kim Schulz aus dem
" "Appendix B".

" Pathogen
" --------
" These lines have to be called before enabling filetype detection.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


"---------------------------------------------------------------------
" Generelle Einstellungen
"---------------------------------------------------------------------

" When started as "evim", evim.vim will already have done these settings.
" Aus vimrc_example von Bram Moolenar
if v:progname =~? "evim"
  finish
endif

" Keine Kompatibilität mit Vi! Viele Scripts setzen das voraus.
set nocompatible

" allow backspacing over everything in insert mode
" Aus vimrc_example von Bram Moolenar
set backspace=indent,eol,start

" Aus vimrc_example von Bram Moolenar
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" In many terminal emulators the mouse works just fine, thus enable it.
" Aus vimrc_example von Bram Moolenar
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" Aus vimrc_example von Bram Moolenar
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Searching test will find test, Test, tEst, etc.
" while search Test will find Test.
" set ignorecase
set smartcase

" Lilypond config file
set runtimepath+=/usr/share/lilypond/2.10.33/vim/

" Only do this part when compiled with support for autocommands.
" Aus vimrc_example von Bram Moolenar
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " Lädt automatisch abhängig von der Dateiendung ein Template, sofern
  " vorhanden Aus "Hacking Vim" von Kim Schulz
  if has("autocmd")
    autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl
  endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Aus vimrc_example von Bram Moolenar
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

" Farbschema für Vim auf der Konsole setzen.
colorscheme zenburn

" Informative Statuszeile, die immer sichtbar ist
" Aus "Hacking Vim" von Kim Schulz
" Der komplizierte, lange Befehl erfragt das encoding und Byte Order Mark
" geklaut aus der VIM-Wiki:
" http://vim.wikia.com/wiki/Show_fileencoding_and_bomb_in_the_status_line
set statusline=%<%f%h%m%r\ [%{&ff}]%{\"
    \[\".(&fenc==\"\"?&enc:&fenc).
    \((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").
    \\"]\"}%=\ [\%03.3b,0x\%02.2B]\ [%v,%l][%p%%][%L]
" Backup of a working status-line ;)
" set statusline=%<%f%h%m%r\ [%{&ff}]%=[\%03.3b,0x\%02.2B]\ [%v,%l]\ [%p%%]
" 			\\ [%L]
set laststatus=2

" Sprachen für die Rechtschreibprüfung. Die Rechtschreibprüfung selbst
" sollte in ftplugins gesetzt werden.
set spelllang=de,en

" Eigene allgemeine Abkürzungen einbinden
" Aus "Hacking Vim" von Kim Schulz
source $HOME/.vim/abbreviations.vim

" Ermöglicht es nichtgespeicherte Puffer zu verstecken, wenn ein Kommando wie
" :edit {file} den aktuellen Puffer braucht.
set hidden

" Cooleres Tab-Menü
set wildmenu

" Shiftwidth auf 4 stellen. Tabstop sollte unberührt bleiben!
" Shiftwidth nur für den aktuellen Puffer setzen, in anderen könnte es
" durch ftplugins beeinflusst sein.
setlocal sw=4
" softtabstop bewirkt 4-Zeichen tab im insert-mode ohne tabstop zu ändern.
setlocal softtabstop=4

" Tabulator am Zeilenanfang auf sw setzen.
set smarttab

" cd into the directory the current buffer is in.
com! CD cd %:p:h
com! LCD lcd %:p:h

" Quick editing and automatic sourcing of vimrc file.
if has("autocmd")
  " :autocmd! config to disable automatic sourcing
  augroup config
    au!
    autocmd bufwritepost .vimrc source $MYVIMRC | let &ft=&ft
    autocmd bufwritepost .gvimrc source $MYGVIMRC | let &ft=&ft
  augroup END
endif
com! Evimrc tabedit $MYVIMRC
com! Egvimrs tabedit $MYGVIMRC
com! SOrc source $MYVIMRC | source $MYGVIMRC | let &ft=&ft

" Soft linewrapping
"   to insert unicode characters use ctrl-vu charcode
command! -nargs=* Wrap set wrap linebreak nolist showbreak=…
command! -nargs=* Nowrap set nowrap
map  <A-j> gj
map  <A-k> gk
map  <A-4> g$
map  <A-6> g^
map  <A-^> g^
map  <A-0> g^
imap <A-j> <C-o>gj
imap <A-k> <C-o>gk
imap <A-4> <C-o>g$
imap <A-6> <C-o>g^
imap <A-^> <C-o>g^
imap <A-0> <C-o>g^

"---------------------------------------------------------------------
" Key mappings für eigene Makros
"---------------------------------------------------------------------

" Don't use Ex mode, use Q for formatting
" Aus vimrc_example von Bram Moolenar
map Q gq

" Ermöglicht es gf einzusetzen ohne vorher Änderungen speichern zu müssen.
" VORSICHT: Vor einem :q! dreimal nachdenken!
map gf :edit <cfile><CR>

" Intuitives Springen durch Zeilen, die umgebrochen wurden.
" Aus "Hacking Vim" von Kim Schulz
map <DOWN> gj
map <UP> gk
imap <DOWN> <C-o>gj
imap <UP> <C-o>gk

" Text bubbling - http://vimcasts.org/episodes/bubbling-text/
" using the unimpared.vim package
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Visually select the text that way last edited/pasted
nmap gV `[v`]

" Einige aus den MS Visual Studios gewohnte Tastenkürzel
imap <C-CR> <ESC>O
imap <C-BS> <C-w>

" Schneller Zugang zur Hilfe automatisch zum Wort unter dem Cursor
" Aus "Hacking Vim" von Kim Schulz
map <F1> <ESC>:exec "help ".expand("<cWORD>")<CR>

"---------------------------------------------------------------------
" Skript-spezifische Einstellungen
"---------------------------------------------------------------------

" snipMate
" --------
let g:snips_author = 'Andreas Herrmann'
" To redifine the trigger key, refer tp :help snipMate-remap
" Indentation is affected by softtabstop or expandtab

" NERD-Tree
" ---------
map <F2> :NERDTreeToggle<CR>

" Gundo
" -----
nnoremap <F3> :GundoToggle<CR>

" Alternate
" ---------
map ,a :A<CR>

" Tabular
" -------
" short-keys [http://vimcasts.org/episodes/aligning-text-with-tabular-vim/]
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
" [:help \zs, :help \ze]
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>

" Automatical alignment
"   [http://vimcasts.org/episodes/aligning-text-with-tabular-vim/]
"   requires that the first line of the table is already aligned.
"   I.e. | 1 | 2 | 3 | rather than |1|2|3|.
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Latex-Suite
" -----------
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_CompileRule_pdf='latexmk -pdf -f -r ~/.latexmkrc_nonstop $*'
"let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*\ /dev/null
"set iskeyword+=:

"---------------------------------------------------------------------
" Spielplatz
"---------------------------------------------------------------------

