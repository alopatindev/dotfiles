"colors slate
colors pablo
"set guifont=terminus
set guifont=DejaVu\ Sans\ Mono\ 20
"set nu
map <C-o> :browse tabnew<CR>
map <C-n> :tabnew<CR>
map <C-S-o> :browse sp<CR>
map <F3> :browse sp<CR>
"map <C-S-n> :sp<CR>
"map <F2> :w<CR>
"map <A-S-s> :confirm saveas<CR>
"map <C-F4> :q<CR>
"map <F9> :!python ~/scripts/py/dwm_1.py<CR>
" F9 - "make" команда
map <F9> :make<cr>
vmap <F9> <esc>:make<cr>
imap <F9> <esc>:make<cr>


" Меню выбора кодировки текста (koi8-r, cp1251, cp866, utf8)
set wildmenu
set wcm=<Tab>
menu Encoding.utf-8 :e ++enc=utf8 <CR>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>

" colors
hi StatusLine ctermfg=white ctermbg=darkgrey cterm=none
hi Folded ctermfg=grey ctermbg=black
hi Visual ctermbg=darkcyan

"set grepprg=grep\ -nH\ $*

se spell
