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
Plug 'vijaymarupudi/nvim-fzf', { 'do': 'cargo install skim' }
"Plug 'kyazdani42/nvim-web-devicons'


Plug 'ncm2/ncm2' " autocompletion for rust
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'markonm/traces.vim' " due to https://github.com/vim/vim/issues/8795#issuecomment-905734865

Plug 'alopatindev/cargo-limit', { 'do': 'cargo install nvim-send' }

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
  set grepformat=%f:%m

  let g:rg_opts = '
    \ --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --color "always"
    \ --glob "*.{c,C,cfg,conf,config,cpp,css,cxx,ebuild,go,h,hpp,hs,html,ini,j2,jade,java,js,lua,md,php,pl,py,rb,rs,scala,sh,sql,styl}"
    \ --glob "{Dockerfile,.gitignore,README,INSTALL,Makefile,Gemfile}"
    \ --glob "!{.git,build,node_modules,vendor,target}/*" '
  let g:rg_command = 'rg' . g:rg_opts

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>1)
  "command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, fzf#vim#with_preview({'sink': 'tab drop'}), <bang>1) " TODO: broken

  let g:rg_highlight = 'true'

  nnoremap <F3> :call fzf#run({'sink': 'tab drop', 'options': '--multi'})<cr>
  imap <F3> <esc>:call fzf#run({'sink': 'tab drop', 'options': '--multi'})<cr>
  vmap <F3> <esc>:call fzf#run({'sink': 'tab drop', 'options': '--multi'})<cr>

  " TODO: tabnew? if tab is empty - close it. handle exiting from terminal?
  "nnoremap <F4> :tabnew<cr>:F<cr>:call s:close_tab_if_empty()<cr>
  "nnoremap <F4> :tabnew<cr>:call s:close_tab_if_empty()<cr>:F<cr>

  " TODO: current solution
"  nnoremap <F4> :tabnew<cr>:F<cr>
"  nnoremap <C-f> :tabnew<cr>:F<cr>
"  imap <F4> <esc>:tabnew<cr>:F<cr>
"  vmap <F4> <esc>:tabnew<cr>:F<cr>

"  nnoremap <F4> :F<cr>
"  nnoremap <C-f> :F<cr>
"  imap <F4> <esc>:F<cr>
"  vmap <F4> <esc>:F<cr>

"  nnoremap <F4> :lua require'fzf-lua'.live_grep()<cr>
"  nnoremap <C-f> :lua require'fzf-lua'.live_grep()<cr>
"  imap <F4> <esc>:lua require'fzf-lua'.live_grep()<cr>
"  vmap <F4> <esc>:lua require'fzf-lua'.live_grep()<cr>

" TODO
  nnoremap <F4> :lua universal_search()<cr>
"  nnoremap <C-f> :lua require'fzf-lua'.universal_search()<cr>
"  imap <F4> <esc>:lua require'fzf-lua'.universal_search()<cr>
"  vmap <F4> <esc>:lua require'fzf-lua'.universal_search()<cr>

  nnoremap <S-F3> :call fzf#run({'sink': 'split', 'options': '--multi'})<cr>
  imap <S-F3> <esc>:call fzf#run({'sink': 'split', 'options': '--multi'})<cr>
  vmap <S-F3> <esc>:call fzf#run({'sink': 'split', 'options': '--multi'})<cr>
endif

lua << EOF
local core = require "fzf-lua.core"
local path = require "fzf-lua.path"
local utils = require "fzf-lua.utils"
local config = require "fzf-lua.config"
local actions = require "fzf-lua.actions"
--actions = require "fzf-lua.actions"

require('fzf-lua').setup{
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
      --vertical = 'up:60%'
      vertical = 'up:20%'
    }
  },
  fzf_opts = {
    ['--layout'] = 'default',
  },
  grep = {
    rg_opts = vim.g.rg_opts
  },
  tabs = {
    prompt = '> ',
  }
}

function dbg(data)
  f = io.open("/tmp/wat.txt", "a+")
  f:write(vim.inspect(data) .. "\n")
  f:close()
end

local make_buffer_entries = function(opts, bufnrs, tabnr, curbuf)
  local header_line = false
  local buffers = {}
  curbuf = curbuf or vim.fn.bufnr('')
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == curbuf and '%' or (bufnr == vim.fn.bufnr('#') and '#' or ' ')

    local element = {
      bufnr = bufnr,
      flag = flag,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    -- get the correct lnum for tabbed buffers
    if tabnr then
      local winid = utils.winid_from_tab_buf(tabnr, bufnr)
      if winid then
        element.info.lnum = vim.api.nvim_win_get_cursor(winid)[1]
        element.info.cnum = vim.api.nvim_win_get_cursor(winid)[2]
      end
    end

    if opts.sort_lastused and (flag == "#" or flag == "%") then
      if flag == "%" then header_line = true end
      local idx = ((buffers[1] ~= nil and buffers[1].flag == "%") and 2 or 1)
      table.insert(buffers, idx, element)
    else
      table.insert(buffers, element)
    end
  end
  return buffers, header_line
end

local format_item = function(bufnr, flags, bufname, line, column, text)
  local prefix = ("%d)"):format(bufnr)

  -- TODO: if flags contains t
  local bufname = utils.ansi_codes.magenta(#bufname>0 and bufname or "[No Name]")

  local flags = ''
  return string.format("%s%s%s:%s%s%s",
    prefix,
    utils.nbsp,
    bufname,
    line,
    column>0 and string.format(':%d', column) or '',
    string.format(': %s', text))
end

local function add_buffer_entry(opts, buf, items, bufnames, header_line)
  -- local hidden = buf.info.hidden == 1 and 'h' or 'a'
  local hidden = ''
  local readonly = vim.api.nvim_buf_get_option(buf.bufnr, 'readonly') and '=' or ' '
  local changed = buf.info.changed == 1 and '+' or ' '
  local flags = hidden .. readonly .. changed
  local leftbr = utils.ansi_codes.clear('[')
  local rightbr = utils.ansi_codes.clear(']')
--  local bufname = string.format("%s:%s",
--    utils._if(#buf.info.name>0, path.relative(buf.info.name, vim.loop.cwd()), "[No Name]"),
--    utils._if(buf.info.lnum>0, buf.info.lnum, ""))
  local bufname = utils._if(#buf.info.name>0, path.relative(buf.info.name, vim.loop.cwd()), "[No Name]")
  if buf.flag == '%' then
    flags = utils.ansi_codes.red(buf.flag) .. flags
    if not header_line then
      leftbr = utils.ansi_codes.green('[')
      rightbr = utils.ansi_codes.green(']')
      bufname = utils.ansi_codes.green(bufname)
    end
  elseif buf.flag == '#' then
    flags = utils.ansi_codes.cyan(buf.flag) .. flags
  else
    flags = utils.nbsp .. flags
  end
  local bufnrstr = string.format("%s%s%s", leftbr,
    utils.ansi_codes.yellow(string.format(buf.bufnr)), rightbr)
  local buficon = ''
  local hl = ''
  if opts.file_icons then
    if utils.is_term_bufname(buf.info.name) then
      -- get shell-like icon for terminal buffers
      buficon, hl = core.get_devicon(buf.info.name, "sh")
    else
      local filename = path.tail(buf.info.name)
      local extension = path.extension(filename)
      buficon, hl = core.get_devicon(filename, extension)
    end
    if opts.color_icons then
      buficon = utils.ansi_codes[hl](buficon)
    end
  end
  local flags = 't' .. flags

  local text = vim.api.nvim_buf_get_lines(buf.bufnr, buf.info.lnum - 1, buf.info.lnum, false)[1]
  local item_str = format_item(buf.bufnr, flags, bufname, buf.info.lnum, buf.info.cnum, text)
  table.insert(items, item_str)
  table.insert(bufnames, bufname)
  return items, bufnames
end

local filter_buffers = function(opts, unfiltered)
  local curtab_bufnrs = {}
  if opts.current_tab_only then
    local curtab = vim.api.nvim_win_get_tabpage(0)
    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(curtab)) do
      local b = vim.api.nvim_win_get_buf(w)
      curtab_bufnrs[b] = true
    end
  end

  local excluded = {}
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      excluded[b] = true
    end
    -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
    if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
      excluded[b] = true
    end
    if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
      excluded[b] = true
    end
    if opts.current_tab_only and not curtab_bufnrs[b] then
      excluded[b] = true
    end
    if opts.no_term_buffers and utils.is_term_buffer(b) then
      excluded[b] = true
    end
    if opts.cwd_only and not path.is_relative(vim.api.nvim_buf_get_name(b), vim.loop.cwd()) then
      excluded[b] = true
    end
    if #vim.api.nvim_buf_get_name(b) == 0 then
      -- TODO: it's boring to support new unsaved tabs
      excluded[b] = true
    end
    return not excluded[b]
  end, unfiltered)

  return bufnrs, excluded
end


local search_in_tabs = function(items, bufnames, opts)
  local curtab = vim.api.nvim_win_get_tabpage(0)

  opts._tab_to_buf = {}
  opts._list_bufs = function()
    local res = {}
    for _, t in ipairs(vim.api.nvim_list_tabpages()) do
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(t)) do
        local b = vim.api.nvim_win_get_buf(w)
        opts._tab_to_buf[t] = opts._tab_to_buf[t] or {}
        opts._tab_to_buf[t][b] = true
        table.insert(res, b)
      end
    end
    return res
  end


  local filtered, excluded = filter_buffers(opts, opts._list_bufs())
  if not next(filtered) then return end

  -- remove the filtered-out buffers
  for b, _ in pairs(excluded) do
    for _, bufnrs in pairs(opts._tab_to_buf) do
      bufnrs[b] = nil
    end
  end


  for t, bufnrs in pairs(opts._tab_to_buf) do
--    table.insert(items, ("%d)%s%s\t%s"):format(t, utils.nbsp,
--      utils.ansi_codes.blue("%s%s#%d"):format(opts.tab_title, utils.nbsp, t),
--        (t==curtab) and utils.ansi_codes.blue(utils.ansi_codes.bold(opts.tab_marker)) or ''))

    local bufnrs_flat = {}
    for b, _ in pairs(bufnrs) do
      table.insert(bufnrs_flat, b)
    end

    opts.sort_lastused = false
    opts._prefix = ("%d)%s%s%s"):format(t, utils.nbsp, utils.nbsp, utils.nbsp)
    local buffers = make_buffer_entries(opts, bufnrs_flat, t)
    for _, buf in pairs(buffers) do
      items, bufnames = add_buffer_entry(opts, buf, items, bufnames, true)
    end
  end

  return items, bufnames
end


local buffer_lines = function(items, bufnames, opts)
  opts.no_term_buffers = true
  local buffers = filter_buffers(opts,
    opts.current_buffer_only and { vim.api.nvim_get_current_buf() } or
    vim.api.nvim_list_bufs())

  for _, bufnr in ipairs(buffers) do
    local prefix = ("%d)%s%s%s"):format(bufnr, utils.nbsp, utils.nbsp, utils.nbsp)

    local data = {}
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    if vim.api.nvim_buf_is_loaded(bufnr) then -- TODO: extract
      data = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    elseif vim.fn.filereadable(filepath) ~= 0 then
      data = vim.fn.readfile(filepath, "")
    end
    local bufname = path.relative(filepath, vim.fn.getcwd())
    local buficon, hl
    if opts.file_icons then
      local filename = path.tail(bufname)
      local extension = path.extension(filename)
      buficon, hl = core.get_devicon(filename, extension)
      if opts.color_icons then
        buficon = utils.ansi_codes[hl](buficon)
      end
    end

    for line, text in ipairs(data) do
      local flags = '#'
      table.insert(items, format_item(bufnr, flags, bufname, line, 0, text))
    end
    table.insert(bufnames, bufname)
  end

  return items, bufnames
end


universal_search = function(opts)
  opts = config.normalize_opts(opts, config.globals.tabs)
  if not opts then return end

  coroutine.wrap(function ()
    local items = {}
    local bufnames = {}

    items, bufnames = search_in_tabs(items, bufnames, opts)
    items, bufnames = buffer_lines(items, bufnames, opts)

    opts.fzf_opts["--no-multi"] = ''
    opts.fzf_opts["--preview-window"] = 'hidden:right:0'
    opts.fzf_opts["--delimiter"] = vim.fn.shellescape('[\\)]')
    opts.fzf_opts["--with-nth"] = '2'

    if opts.search and #opts.search>0 then
      dbg('query!')
      opts.fzf_opts['--query'] = vim.fn.shellescape(opts.search)
    end

    local selected = core.fzf(opts, items)
    if not selected then return end
    open(selected, opts)
  end)()
end

open = function(selected, opts)
  local fields = utils.strsplit(utils.strsplit(selected[2], utils.nbsp)[2], ':')
  local bufname = vim.fn.fnameescape(fields[1])
  local line = fields[2]
  local column = tonumber(utils.strsplit(fields[3], ' ')[1])
  local column = column == nil and 1 or column
  vim.cmd("tab drop " .. bufname)
  vim.cmd('call cursor(' .. line .. ',' .. column .. ')')
end
EOF

" vim:shiftwidth=2 softtabstop=2 tabstop=2
