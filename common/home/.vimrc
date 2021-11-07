call plug#begin('~/.config/nvim/plugged')

"Plug 'git@github.com:vimwiki/vimwiki.git'
Plug 'git@github.com:vim-scripts/rainbow_parentheses.vim'
Plug 'git@github.com:vim-scripts/taglist.vim'
"Plug 'git@github.com:vim-scripts/Indent-Guides.git'
"Plug 'git@github.com:vim-scripts/Tagbar.git'
"Plug 'git@github.com:vim-scripts/vim-gitgutter'
Plug 'git@github.com:airblade/vim-gitgutter'
Plug 'git@github.com:gentoo/gentoo-syntax'
Plug 'git@github.com:derekwyatt/vim-scala'
Plug 'git@github.com:zaiste/tmux.vim'
Plug 'git@github.com:editorconfig/editorconfig-vim'
Plug 'git@github.com:cespare/vim-toml'
Plug 'git@github.com:Chiel92/vim-autoformat'
"Plug 'git@github.com:kchmck/vim-coffee-script.git'
Plug 'git@github.com:leafgarland/typescript-vim.git'
Plug 'git@github.com:ekalinin/Dockerfile.vim.git'
Plug 'git@github.com:Shougo/deoplete.nvim'
Plug 'git@github.com:carlitux/deoplete-ternjs'
"Plug 'git@github.com:alopatindev/vim-scaladoc.git'
"Plug 'git@github.com:kassio/neoterm'
"Plug 'git@github.com:fidian/hexmode.git'
"Plug 'git@github.com:timburgess/extempore.vim.git'
Plug 'git@github.com:jparise/vim-graphql'
"Plug 'git@github.com:elubow/cql-vim'
Plug 'git@github.com:suan/vim-instant-markdown'
Plug 'git@github.com:tpope/vim-fugitive' "for git diff
Plug 'git@github.com:jremmen/vim-ripgrep'
"Plug 'pandysong/ghost-text.vim'
"Plug 'git@github.com:vigoux/LanguageTool.nvim'
"Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
Plug 'git@github.com:chiedojohn/vim-case-convert'

" rust
Plug 'git@github.com:rust-lang/rust.vim'
"Plug 'w0rp/ale' " autocompletion unused, used proselint
Plug 'airblade/vim-rooter' " changes current dir to project root (that contains .git)

" for go to definition (autocompletion unused)
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }


Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'ibhagwan/fzf-lua'
Plug 'vijaymarupudi/nvim-fzf', { 'do': 'cargo install skim fd-find' }
"Plug 'kyazdani42/nvim-web-devicons'


Plug 'ncm2/ncm2' " autocompletion for rust
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'markonm/traces.vim' " due to https://github.com/vim/vim/issues/8795#issuecomment-905734865

Plug 'alopatindev/cargo-limit', { 'do': 'cargo install cargo-limit nvim-send' }

" :PlugInstall

call plug#end()

syntax on

set ignorecase
set smartcase

set directory=/tmp/.vimswaps//
"set directory=~/.private/.vimswaps//
"set foldmethod=indent
set foldmethod=manual
"set textwidth=80
set textwidth=0
set nocompatible
set ruler  
set showcmd  
set nu
set incsearch
set nohlsearch
set scrolljump=4
set scrolloff=4
set novisualbell
set t_vb=   
"set mouse=a
set mouse=n
set mousemodel=popup
set mousehide
set termencoding=utf-8
set guioptions-=T
set ch=1
set sessionoptions=curdir,buffers,tabpages
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time
set tags=tags,.tags,rusty-tags.vi
set tags+=tags;/
se number
" se relativenumber
set shortmess=aoOtIT
set nowritebackup
set undodir=~/.vimundo
set undofile

set fileencodings=utf-8,cp1251,koi8-r,cp866
set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>
menu Encoding.utf-16 :e ++enc=utf16 <CR>
map <F8> :emenu Encoding.<TAB>

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" tab to spaces
set expandtab

set shiftwidth=4
set softtabstop=4
set tabstop=4

" set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set laststatus=2

" Fix <Enter> for comment
set fo+=cr


" Indents
set smartindent  " indent after {, etc.
set autoindent
vmap < <gv
vmap > >gv
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_start_level=2
"let g:indent_guides_guide_size=1
""let g:indent_guides_enable_on_vim_startup = 1
"hi IndentGuidesOdd  guibg=red   ctermbg=darkcyan
"hi IndentGuidesEven guibg=green ctermbg=Darkblue

" auto closing character
" imap [ []<LEFT>
imap {<CR> {<CR>}<Esc>O


" ctags: go to definition in C and some other languages
" requires running "ctags -R ." in the same dir first
" TODO: tab drop
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>



" .viminfo settings: remember certain things when we exit
"  '30  :  marks will be remembered for up to 10 previously edited files
"  "500 :  will save up to 100 lines for each register
"  :30  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='30,\"500,:30,%,n~/.viminfo
"set viminfo='100,n~/.config/nvim/nviminfo'


" Terminal hacks

" C-h for xterm + tmux + nvim
"if &term == "screen"
noremap <bs> :tabp<cr>
"endif

"set term=xterm
if v:version >= 700
  set numberwidth=3
endif

if &term ==? "xterm"
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2
endif

"" C-h for xterm => tmux => nvim
"if &term ==? "screen"
"  noremap <bs> :tabp<cr>
"endif



" Keyboard shortcuts

map . /

map U <esc>:redo<cr>
map Г <esc>:redo<cr>

map К R
map y y
map з p

map о j
map л k
map д l
map р h

map ш i
map к r
map м v
map М V

map О J
map г u
map Ж :
map ц w

map П G

map в d

" Clipboard
vmap <C-C> "+yi
"imap <C-V> <esc>"+gPi
imap <C-S-v> <esc>"*pi
set clipboard=unnamedplus

map <C-t> :tabnew<cr>
imap <C-t> <esc>:tabnew<cr>
vmap <C-t> <esc>:tabnew<cr>

" file browser
map <C-F3> :tabnew<cr>:Ex<cr>
imap <C-F3> <esc>:tabnew<cr>:Ex<cr>
vmap <C-F3> <esc>:tabnew<cr>:Ex<cr>
command! E Explore

noremap <C-l> :tabn<cr>
noremap <C-h> :tabp<cr>

noremap <S-H> :-tabmove<cr>
noremap <S-L> :+tabmove<cr>

vmap <C-l> <esc>:tabn<cr>
vmap <C-h> <esc>:tabp<cr>
vmap <bs> <esc>:tabp<cr>

" shift-insert behavior is similar to xterm
map <S-Insert> <MiddleMouse>

" search and replace current word
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

nmap <F2> :wa<cr>
vmap <F2> <esc>:wa<cr>v
imap <F2> <esc>:wa<cr>i

map cc <esc>:q<cr>

vmap s :sort<cr>

" Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
map <F12> :TagbarToggle<cr>
imap <F12> <esc>:TagbarToggle<cr>
vmap <F12> <esc>:TagbarToggle<cr>


" Colors
"colorscheme evening
colorscheme peachpuff
"hi clear
hi SpellBad cterm=underline
hi ModeMsg term=bold cterm=bold gui=bold
"hi StatusLine term=reverse,bold cterm=reverse,bold gui=reverse,bold
hi DiffText term=reverse cterm=bold gui=bold guibg=Red
hi Directory term=bold
hi MoreMsg term=bold gui=bold
hi NonText term=bold gui=bold
hi Question term=standout gui=bold
hi SpecialKey term=bold
hi Title term=bold gui=bold
hi DiffAdd term=bold
hi DiffChange term=bold
hi DiffDelete term=bold gui=bold
hi Special term=bold
hi Statement term=bold cterm=bold gui=bold
hi Type ctermfg=4 cterm=bold
hi String ctermfg=5 cterm=bold
hi Comment ctermfg=6 cterm=bold
hi LineNr ctermfg=3 cterm=bold
hi Search ctermfg=0
hi Constant cterm=bold
hi StatusLineNC cterm=bold ctermfg=0
hi StatusLine cterm=bold ctermfg=2
hi Title ctermfg=LightBlue ctermbg=Magenta
"hi TabLineFill cterm=bold ctermfg=2
"hi TabLine cterm=bold ctermfg=2
"hi TabLineSel cterm=bold ctermbg=4
hi PreProc cterm=bold ctermfg=4
"hi CursorLine ctermbg=LightBlue term=none cterm=none
hi CursorLineNr ctermfg=Yellow
set cursorline


" colorscheme slate
"colorscheme evening
"hi Normal ctermfg=lightgrey
"hi Normal ctermbg=black
"hi Type ctermfg=blue
"hi Special term=bold cterm=bold
"hi Folded ctermfg=white ctermbg=black
hi Folded ctermfg=darkgreen ctermbg=black
"hi Visual ctermbg=darkcyan
"hi StatusLine ctermfg=white ctermbg=darkcyan cterm=none
"hi StatusLine ctermfg=black ctermbg=darkgreen cterm=none
hi StatusLine ctermfg=white ctermbg=darkblue cterm=none
"hi Pmenu ctermfg=black ctermbg=green cterm=none guibg=brown gui=bold
"hi PmenuSel ctermfg=green ctermbg=black cterm=none guibg=red gui=bold
"hi PmenuSbar ctermfg=green ctermbg=black cterm=none guibg=red gui=bold
"hi PmenuThumb ctermfg=green ctermbg=black cterm=none guibg=red gui=bold
highlight Pmenu ctermbg=blue guibg=blue

""hi TabLineSel term=bold  ctermfg=white ctermbg=darkgreen
hi TabLineSel term=bold  ctermfg=black ctermbg=green
""ctermbg=darkblue
hi TabLine ctermfg=white ctermbg=black
hi TabLineFill term=bold,reverse  cterm=bold ctermfg=lightblue ctermbg=black
"hi Comment cterm=bold
"hi Directory ctermfg=3 cterm=none

hi Todo ctermfg=gray ctermbg=darkblue

highlight clear SpellBad
highlight clear SpellCap
highlight clear SpellLocal
highlight clear SpellRare

highlight SpellBad cterm=underline
highlight SpellCap cterm=underline
highlight SpellLocal cterm=underline
highlight SpellRare cterm=underline

"let xterm16_colormap = 'allblue'
"colo xterm16

"if $DISPLAY != ''
"	colorscheme default
"else
"	colorscheme evening
"endif

set spelllang=en,ru
"map <S-s> :set spell!<cr>
map <F7> :set spell!<cr>
imap <F7> <esc>:set spell!<cr>
map <A-n> :set nu!<cr>

function! Browser ()
  let line0 = getline (".")
  let line = matchstr (line0, "http[^ ]*")
  :if line==""
    let line = matchstr (line0, "ftp[^ ]*")
  :endif
  :if line==""
    let line = matchstr (line0, "file[^ ]*")
  :endif
  let line = escape (line, "#?&;|%")
"   echo line
"    exec ":silent !lynx ".line
  exec ":!elinks-remote ".line
endfunction

map \w :call Browser ()<cr><cr>

map z <C-o>

"urxvt and others terminals hack
map <End> $


" GIT
map <F10> :GitGutterToggle<cr>:se nu!<cr>:set paste!<cr>
nnoremap <C-d> :Git diff %<cr>
imap <C-d> <esc>:Git diff %<cr>
vmap <C-d> <esc>:Git diff %<cr>
map <C-b> <esc>:Git blame<cr>
set updatetime=250
let g:gitgutter_max_signs = 500
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_column_always = 1
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4




function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


" Rainbow Parentheses options {
  function! Config_Rainbow()
    call rainbow_parentheses#load(0) " Load Round brackets
    call rainbow_parentheses#load(1) " Load Square brackets
    call rainbow_parentheses#load(2) " Load Braces
    autocmd! TastetheRainbow VimEnter * call Load_Rainbow() " 64bit Hack - Set VimEnter after syntax load
  endfunction

  function! Load_Rainbow()
    call rainbow_parentheses#activate()
  endfunction

  augroup TastetheRainbow
    autocmd!
    autocmd Syntax * call Config_Rainbow() " Load rainbow_parentheses on syntax load
    autocmd VimEnter * call Load_Rainbow()
  augroup END

  " rainbow_parentheses toggle
  nnoremap <silent> <Leader>t :call rainbow_parentheses#toggle()<CR>

  let g:rbpt_colorpairs = [
    \ ['blue',     'RoyalBlue3'],
    \ ['white',  'SeaGreen3'],
    \ ['darkyellow',     'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['blue',  'RoyalBlue3'],
    \ ['white',   'SeaGreen3'],
    \ ['darkyellow', 'DarkOrchid3'],
    \ ['darkgreen',     'firebrick3'],
    \ ['blue',  'RoyalBlue3'],
    \ ['white',  'SeaGreen3'],
    \ ['darkyellow', 'DarkOrchid3'],
    \ ['darkgreen',  'firebrick3'],
    \ ['blue',   'RoyalBlue3'],
    \ ['white',  'SeaGreen3'],
    \ ['darkyellow',   'DarkOrchid3'],
    \ ['darkgreen',     'firebrick3'],
    \ ]
" }




" File types / Languages

filetype on
filetype plugin indent on

au BufNewFile,BufRead *.toml set filetype=toml
au BufNewFile,BufRead Cargo.lock set filetype=toml
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
autocmd BufNewFile,BufRead *.ny set syntax=lisp
autocmd BufNewFile,BufRead *.xges set syntax=xml

" txt
" Disable annoying auto line break
fu! DisableBr()
  set wrap
  set linebreak
  set nolist  " list disables linebreak
  set textwidth=0
  set wrapmargin=0
  set fo-=t
endfu
au BufNewFile,BufRead *.txt call DisableBr()

" XML
augroup XML
  autocmd!
  autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END
"au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"


" Rust
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']
let g:rustfmt_autosave = 1
let g:LanguageClient_loggingFile = expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }
let g:LanguageClient_useFloatingHover = 0
"let g:LanguageClient_useVirtualText = 0
let g:LanguageClient_useVirtualText = "No"
let g:LanguageClient_diagnosticsDisplay={
  \     '1': {
  \         "name": "Error",
  \         "texthl": "LanguageClientError",
  \         "signText": "x",
  \         "signTexthl": "LanguageClientWarningSign",
  \         "virtualTexthl": "Todo",
  \     },
  \     '2': {
  \         "name": "Warning",
  \         "texthl": "LanguageClientWarning",
  \         "signText": "!",
  \         "signTexthl": "LanguageClientWarningSign",
  \         "virtualTexthl": "Todo",
  \     },
  \     '3': {
  \         "name": "Information",
  \         "texthl": "LanguageClientInfo",
  \         "signText": "i",
  \         "signTexthl": "LanguageClientInfoSign",
  \         "virtualTexthl": "Todo",
  \     },
  \     '4': {
  \         "name": "Hint",
  \         "texthl": "LanguageClientInfo",
  \         "signText": ">",
  \         "signTexthl": "LanguageClientInfoSign",
  \         "virtualTexthl": "Todo",
  \     },
  \ }
autocmd BufEnter *.rs map <C-\> :tab call LanguageClient#textDocument_definition({'gotoCmd': 'tab drop'})<CR>
nnoremap r :call LanguageClient#textDocument_rename()<CR>
map f :call LanguageClient_textDocument_codeAction()<CR>

" enable autocomplete for Rust
autocmd BufEnter *.rs call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let g:ncm2#auto_popup=0
"g:ncm2#complete_length
"g:ncm2#manual_complete_length
"inoremap <your-key> <c-r>=ncm2#manual_trigger(...)<cr>
autocmd BufEnter *.rs inoremap <C-p> <c-r>=ncm2#manual_trigger()<cr>



" JavaScript/ECMAScript
let g:formatdef_jsbeautify_json = '"js-beautify --indent-size 2"'
au BufWrite *.ts :Autoformat
au BufWrite *.js :Autoformat
au BufWrite *.json :Autoformat

" Ruby
au BufWrite *.rb :Autoformat


autocmd BufEnter,FocusGained * checktime

function! s:close_tab_if_empty()
  "if empty(expand('%:p'))
  "if mode() == 't'
  "  q
  "end
  function! s:wat()
    if mode() == 't'
      q
    end
  endfunction
  call jobstart(['sleep', '1'], {'on_exit': function('s:wat')})
endfunction

" Search in filenames and file bodies

if executable('rg')
  let g:rg_opts = '
    \ --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --color "always"
    \ --glob "*.{c,C,cfg,conf,config,cpp,css,cxx,ebuild,go,h,hpp,hs,html,ini,j2,jade,java,js,lua,md,php,pl,py,rb,rs,scala,sh,sql,styl}"
    \ --glob "{Dockerfile,.gitignore,README,INSTALL,Makefile,Gemfile}"
    \ --glob "!{.git,build,node_modules,vendor,target}/*" '

  nnoremap <F3> :lua relevant_files()<cr>
  imap <F3> <esc>:lua relevant_files()<cr>
  vmap <F3> <esc>:lua relevant_files()<cr>

  nnoremap <F4> :lua relevant_grep()<cr>
  imap <F4> <esc>:lua relevant_grep()<cr>
  vmap <F4> <esc>:lua relevant_grep()<cr>

lua << EOF
  require('fzf-lua-ext')
  require('fzf-lua').setup {
    --fzf_bin = 'sk',
    winopts = {
      border = 'none',
      fullscreen = true,
      preview = {
        border = 'noborder',
        wrap = 'wrap',
        scrollbar = false,
        layout = 'vertical',
        title = false,
        vertical = 'up:50%'
      }
    },
    --fzf_opts = {
    --  ['--layout'] = 'default',
    --},
    grep = {
      rg_opts = vim.g.rg_opts,
      prompt = '> ',
    },
  }
EOF
endif

" vim:shiftwidth=2 softtabstop=2 tabstop=2
