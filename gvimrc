"--------------------------------------------------------------------
" GVim Einstellungsdatei
"--------------------------------------------------------------------
" Diese Datei sollte alle Einstellungen enthalten, die GVim im
" Speziellen betreffen.
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

"---------------------------------------------------------------------
" Generelle Einstellungen
"---------------------------------------------------------------------

" Aus gvimrc_example von Bram Moolenar
set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
" Aus gvimrc_example von Bram Moolenar
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
" Aus gvimrc_example von Bram Moolenar
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  " Aus gvimrc_example von Bram Moolenar
  set hlsearch

endif

" Schriftart setzen - evtl. in filetype plugins per autocmd auslagern
"set guifont=Monospace\ 8
set guifont=Inconsolata\ 10

" Toolbar standardmäßig deaktivieren
set guioptions-=T
" Menubar standardmäßig deaktivieren
set guioptions-=m
" Scrollbar standardmäßig deaktivieren
set guioptions-=r

" Farbschema für GVim setzen
" Eine andere gute Alternative zu sienna ist biogoo
colorscheme zenburn

"---------------------------------------------------------------------
" Key mappings für eigene Makros
"---------------------------------------------------------------------

" Mit F11 die Menubar an- und ausschalten
" Falls das nicht funktioniert muss evtl.
" ~/.gnome2/Vim gelöscht werden.
map <silent> <F11> :if &guioptions =~# 'm' <Bar>
			\set guioptions-=m <Bar>
			\else <Bar>
			\set guioptions+=m <Bar>
			\endif<CR>
" Mit Ctrl-F11 die Toolbar an- und ausschalten
" Aus "Hacking Vim" von Kim Schulz
map <silent> <C-F11> :if &guioptions =~# 'T' <Bar>
			\set guioptions-=T <Bar>
			\else <Bar>
			\set guioptions+=T <Bar>
			\endif<CR>

"---------------------------------------------------------------------
" Skript-spezifische Einstellungen
"---------------------------------------------------------------------

"---------------------------------------------------------------------
" Spielplatz
"---------------------------------------------------------------------

