setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
se ts=4 sw=2 et
let g:indent_guides_start_level=2
"let g:indent_guides_guide_size=1
let g:indent_guides_guide_size=2
"IndentGuidesEnable

nunmap <F2>
vunmap <F2>
iunmap <F2>
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>:ProjectOpen<cr>:ProjectRefreshAll<cr>v
imap <F2> <esc>:w<cr>:ProjectOpen<cr>:ProjectRefreshAll<cr>i

unmap <F12>
iunmap <F12>
map <F12> :ProjectTreeToggle<cr>
imap <F12> <esc>:ProjectTreeToggle<cr>

" Shift tab is autocompletion
inoremap <S-Tab> <C-x><C-u>
