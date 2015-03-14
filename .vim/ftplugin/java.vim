nunmap <F2>
vunmap <F2>
iunmap <F2>
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>:ProjectOpen<cr>:ProjectBuild<cr>v
imap <F2> <esc>:w<cr>:ProjectOpen<cr>:ProjectBuild<cr>i

unmap <F12>
iunmap <F12>
map <F12> :ProjectTreeToggle<cr>
imap <F12> <esc>:ProjectTreeToggle<cr>

" Shift tab is autocompletion
inoremap <S-Tab> <C-x><C-u>
