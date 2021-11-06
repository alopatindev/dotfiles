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
  nnoremap <F4> :lua universal_grep()<cr>
  nnoremap <C-f> :lua universal_grep()<cr>
  imap <F4> <esc>:lua universal_grep()<cr>
  vmap <F4> <esc>:lua universal_grep()<cr>

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
local libuv = require "fzf-lua.libuv"
local win = require "fzf-lua.win"
local uv = vim.loop

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
      vertical = 'up:50%'
    }
  },
  fzf_opts = {
    ['--layout'] = 'default',
  },
  grep = {
    rg_opts = vim.g.rg_opts,
    prompt = '> ',
  },
}

local function dbg(data)
  f = io.open("/tmp/wat.txt", "a+")
  f:write(vim.inspect(data) .. "\n")
  f:close()
end

local function make_buffer_entries(opts, bufnrs, tabnr, curbuf)
  local header_line = false
  local buffers = {}
  curbuf = curbuf or vim.fn.bufnr('')
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == curbuf and '%' or (bufnr == vim.fn.bufnr('#') and '#' or ' ') -- TODO: remove?

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

    if opts.sort_lastused and (flag == "#" or flag == "%") then -- TODO: remove?
      if flag == "%" then header_line = true end
      local idx = ((buffers[1] ~= nil and buffers[1].flag == "%") and 2 or 1)
      table.insert(buffers, idx, element)
    else
      table.insert(buffers, element)
    end
  end
  return buffers, header_line
end

local function format_item(bufnr, flags, bufname, line, column, text, is_tab)
  local colon = utils.ansi_codes.green(':')
  local bufname = #bufname>0 and bufname or "[No Name]"
  bufname = is_tab and utils.ansi_codes.yellow(bufname) or utils.ansi_codes.cyan(bufname)
  return string.format("%s%s%s%s%s",
    bufname,
    colon,
    line,
    column>0 and string.format('%s%d', colon, column) or '',
    string.format('%s %s', colon, text))
end

local function add_buffer_entry(opts, buf, items, bufnames_with_lines, header_line)
  local hidden = ''
  local readonly = vim.api.nvim_buf_get_option(buf.bufnr, 'readonly') and '=' or ' '
  local changed = buf.info.changed == 1 and '+' or ' '
  local flags = hidden .. readonly .. changed
  local leftbr = utils.ansi_codes.clear('[')
  local rightbr = utils.ansi_codes.clear(']')
  local bufname = utils._if(#buf.info.name>0, path.relative(buf.info.name, vim.loop.cwd()), "[No Name]")
  if buf.flag == '%' then
    flags = utils.ansi_codes.red(buf.flag) .. flags
    if not header_line then -- TODO: remove
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
  local buficon = '' -- TODO: remove?
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
  local flags = 't' .. flags -- TODO

  local text = vim.api.nvim_buf_get_lines(buf.bufnr, buf.info.lnum - 1, buf.info.lnum, false)[1]
  local item_str = format_item(buf.bufnr, flags, bufname, buf.info.lnum, buf.info.cnum, text, true)
  table.insert(items, item_str)
  bufnames_with_lines[bufname .. buf.info.lnum] = true -- TODO
  return items, bufnames_with_lines
end

local function filter_buffers(opts, unfiltered)
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


local function search_in_tabs(items, bufnames_with_lines, opts)
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
    local bufnrs_flat = {}
    for b, _ in pairs(bufnrs) do
      table.insert(bufnrs_flat, b)
    end

    opts.sort_lastused = false
    opts._prefix = ("%d)%s%s%s"):format(t, utils.nbsp, utils.nbsp, utils.nbsp) -- TODO: remove?
    local buffers = make_buffer_entries(opts, bufnrs_flat, t)
    for _, buf in pairs(buffers) do
      items, bufnames_with_lines = add_buffer_entry(opts, buf, items, bufnames_with_lines, true)
    end
  end

  return items, bufnames_with_lines
end


local function buffer_lines(items, bufnames_with_lines, opts)
  opts.no_term_buffers = true
  local buffers = filter_buffers(opts,
    opts.current_buffer_only and { vim.api.nvim_get_current_buf() } or
    vim.api.nvim_list_bufs())

  for _, bufnr in ipairs(buffers) do
    local prefix = ("%d)%s%s%s"):format(bufnr, utils.nbsp, utils.nbsp, utils.nbsp) -- TODO: remove

    local data = {}
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    if vim.api.nvim_buf_is_loaded(bufnr) then -- TODO: extract
      data = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    elseif vim.fn.filereadable(filepath) ~= 0 then
      data = vim.fn.readfile(filepath, "")
    end
    local bufname = path.relative(filepath, vim.fn.getcwd())
    local buficon, hl
    if opts.file_icons then -- TODO: remove?
      local filename = path.tail(bufname)
      local extension = path.extension(filename)
      buficon, hl = core.get_devicon(filename, extension)
      if opts.color_icons then
        buficon = utils.ansi_codes[hl](buficon)
      end
    end

    for line, text in ipairs(data) do
      if #text > 0 and bufnames_with_lines[bufname .. line] == nil then
        local flags = '#' -- TODO: remove
        table.insert(items, format_item(bufnr, flags, bufname, line, 0, text, false))
        bufnames_with_lines[bufname .. line] = true -- TODO: extract?
      end
    end
  end

  return items, bufnames_with_lines
end


local function get_grep_cmd(opts, search_query, no_esc)
  if opts.cmd_fn and type(opts.cmd_fn) == 'function' then
    return opts.cmd_fn(opts, search_query, no_esc)
  end
  if opts.raw_cmd and #opts.raw_cmd>0 then
    return opts.raw_cmd
  end
  local command = nil
  if opts.cmd and #opts.cmd > 0 then
    command = opts.cmd
  elseif vim.fn.executable("rg") == 1 then
    command = string.format("rg %s", opts.rg_opts)
  else
    command = string.format("grep %s", opts.grep_opts)
  end

  -- filename takes precedence over directory
  -- filespec takes precedence over all and doesn't shellescape
  -- this is so user can send a file populating command instead
  local search_path = ''
  if opts.filespec and #opts.filespec>0 then
    search_path = opts.filespec
  elseif opts.filename and #opts.filename>0 then
    search_path = vim.fn.shellescape(opts.filename)
  end

  search_query = search_query or ''
  if not (no_esc or opts.no_esc) then
    search_query = utils.rg_escape(search_query)
  end

  -- do not escape at all
  if not (no_esc == 2 or opts.no_esc == 2) then
    search_query = vim.fn.shellescape(search_query)
  end

  return string.format('%s %s %s', command, search_query, search_path)
end

local function get_lines_from_file(file)
  local t = {}
  for v in file:lines() do
    table.insert(t, v)
  end
  return t
end

local function raw_fzf(contents, items, fzf_cli_args, opts)
  dbg('raw_fzf 1')
  if not coroutine.running() then
    error("please run function in a coroutine")
  end
  dbg('raw_fzf 2')

  if not opts then opts = {} end
  local cwd = opts.fzf_cwd or opts.cwd
  local cmd = opts.fzf_binary or opts.fzf_bin or 'fzf'
  local fifotmpname = vim.fn.tempname()
  local outputtmpname = vim.fn.tempname()
  dbg('raw_fzf 3')

  if fzf_cli_args then cmd = cmd .. " " .. fzf_cli_args end
  if opts.fzf_cli_args then cmd = cmd .. " " .. opts.fzf_cli_args end

  if contents then
    if type(contents) == "string" and #contents>0 then
      cmd = ("%s | %s"):format(contents, cmd)
    else
      cmd = ("%s < %s"):format(cmd, vim.fn.shellescape(fifotmpname))
    end
  end
  dbg('raw_fzf 4')

  cmd = ("%s > %s"):format(cmd, vim.fn.shellescape(outputtmpname))

  local fd, output_pipe = nil, nil
  local finish_called = false
  local write_cb_count = 0

  -- Create the output pipe
  vim.fn.system(("mkfifo %s"):format(vim.fn.shellescape(fifotmpname)))
  dbg('raw_fzf 5')

  local function finish(waat)
    dbg('finish 1')
    dbg(waat)
    -- mark finish if once called
    finish_called = true
    -- close pipe if there are no outstanding writes
    dbg('finish 2')
    if output_pipe and write_cb_count == 0 then
      dbg('finish 2.1')
      output_pipe:close()
      output_pipe = nil
    end
    dbg('finish 3')
  end
  dbg('raw_fzf 6')

  local function write_cb(data, cb)
    if not output_pipe then return end
    write_cb_count = write_cb_count + 1
    output_pipe:write(data, function(err)
      -- decrement write call count
      write_cb_count = write_cb_count - 1
      -- this will call the user's cb
      if cb then cb(err) end
      if err then
        -- can fail with premature process kill
        finish(2)
      elseif finish_called and write_cb_count == 0 then
        -- 'termopen.on_exit' already called and did not close the
        -- pipe due to write_cb_count>0, since this is the last call
        -- we can close the fzf pipe
        finish(3)
      end
    end)
  end
  dbg('raw_fzf 7')

  -- nvim-fzf compatibility, builds the user callback functions
  -- 1st argument: callback function that adds newline to each write
  -- 2nd argument: callback function thhat writes the data as is
  -- 3rd argument: direct access to the pipe object
  local function usr_write_cb(nl)
    local function end_of_data(usrdata, cb)
      if usrdata == nil then
        if cb then cb(nil) end
        finish(5)
        return true
      end
      return false
    end
    if nl then
      return function(usrdata, cb)
        if not end_of_data(usrdata, cb) then
          write_cb(tostring(usrdata).."\n", cb)
        end
      end
    else
      return function(usrdata, cb)
        if not end_of_data(usrdata, cb) then
          write_cb(usrdata, cb)
        end
      end
    end
  end
  dbg('raw_fzf 8')

  local co = coroutine.running()
  vim.fn.termopen(cmd, {
    cwd = cwd,
    on_exit = function(_, rc, _)
      dbg('ON_exit 1')
      local f = io.open(outputtmpname)
      dbg('ON_exit 1.2')
      local output = get_lines_from_file(f)
      dbg('ON_exit 1.3')
      f:close()
      dbg('ON_exit 2')
      finish(1)
      vim.fn.delete(fifotmpname)
      vim.fn.delete(outputtmpname)
      dbg('ON_exit 3')
      if #output == 0 then output = nil end
      dbg('ON_exit 4')
      coroutine.resume(co, output, rc)
    end
  })
  vim.cmd[[set ft=fzf]]
  vim.cmd[[startinsert]]
  dbg('raw_fzf 9')

  if not contents or type(contents) == "string" then
    goto wait_for_fzf
  end

  -- have to open this after there is a reader (termopen)
  -- otherwise this will block
  fd = uv.fs_open(fifotmpname, "w", -1)
  output_pipe = uv.new_pipe(false)
  output_pipe:open(fd)
  -- print(uv.pipe_getpeername(output_pipe))
  dbg('raw_fzf 10')

  dbg('raw_fzf 10.1 !')
  for _, item in ipairs(items) do
    write_cb(item .. "\n", function() dbg('waaT') end)
  end
  dbg('raw_fzf 10.2 !')

  -- this part runs in the background, when the user has selected, it will
  -- error out, but that doesn't matter so we just break out of the loop.
  if contents then
    if type(contents) == "table" then
      if not vim.tbl_isempty(contents) then
        write_cb(vim.tbl_map(function(x) return x.."\n" end, contents))
      end
      finish(4)
    else
      contents(usr_write_cb(true), usr_write_cb(false), output_pipe)
    end
  end
  dbg('raw_fzf 11')

  ::wait_for_fzf::
  dbg('raw_fzf 12')

  local xx = coroutine.yield()
  dbg('raw_fzf 13')
  return xx
end

local function fzf(opts, contents)
  dbg('fzf 1')
  -- normalize with globals if not already normalized
  if not opts._normalized then
    opts = config.normalize_opts(opts, {})
  end
  -- setup the fzf window and preview layout
  local fzf_win = win(opts)
  dbg('fzf 2')
  if not fzf_win then return end
  -- instantiate the previewer
  local previewer, preview_opts = nil, nil
  dbg('fzf 3')
  if opts.previewer and type(opts.previewer) == 'string' then
    preview_opts = config.globals.previewers[opts.previewer]
    if not preview_opts then
      utils.warn(("invalid previewer '%s'"):format(opts.previewer))
    end
  elseif opts.previewer and type(opts.previewer) == 'table' then
    preview_opts = opts.previewer
  end
  if preview_opts and type(preview_opts._new) == 'function' then
    previewer = preview_opts._new()(preview_opts, opts, fzf_win)
  elseif preview_opts and type(preview_opts._ctor) == 'function' then
    previewer = preview_opts._ctor()(preview_opts, opts, fzf_win)
  end
  dbg('fzf 4')
  if previewer then
    opts.fzf_opts['--preview'] = previewer:cmdline()
    if type(previewer.preview_window) == 'function' then
      -- do we need to override the preview_window args?
      -- this can happen with the builtin previewer
      -- (1) when using a split we use the previewer as placeholder
      -- (2) we use 'nohidden:right:0' to trigger preview function
      --     calls without displaying the native fzf previewer split
      opts.fzf_opts['--preview-window'] = previewer:preview_window(opts.preview_window)
      opts.fzf_opts["--no-multi"] = ''
      opts.fzf_opts["--delimiter"] = vim.fn.shellescape(':')
      opts.fzf_opts["--tiebreak"] = 'index'
    end
  end
  dbg('fzf 5')

  fzf_win:attach_previewer(previewer)
  dbg('fzf 5.1')
  fzf_win:create()
  dbg('fzf 5.2')
  local xxx = core.build_fzf_cli(opts)
  dbg(xxx)
  dbg('fzf 5.2.1')
  dbg(opts.cwd)
  dbg('fzf 5.2.2')
  dbg(opts.fzf_bin)
  dbg('fzf 5.2.3')


  local items = {}
  local bufnames_with_lines = {}

  -- TODO: bufnames_with_lines: add : ?
  items, bufnames_with_lines = search_in_tabs(items, bufnames_with_lines, opts)
  items, bufnames_with_lines = buffer_lines(items, bufnames_with_lines, opts)

  local selected, exit_code = raw_fzf(contents, items, core.build_fzf_cli(opts),
    { fzf_binary = opts.fzf_bin, fzf_cwd = opts.cwd })
  dbg('fzf 5.3')
  utils.process_kill(opts._pid)
  dbg('fzf 5.4')
  fzf_win:check_exit_status(exit_code)
  dbg('fzf 6')
  if fzf_win:autoclose() == nil or fzf_win:autoclose() then
    fzf_win:close()
  end
  dbg('fzf 7')
  dbg(selected)
  dbg('fzf 8')
  return selected
end

local function open(selected)
  dbg(selected)
  local fields = utils.strsplit(selected[2], ':')
  dbg('fields')
  dbg(fields)
  local bufname = vim.fn.fnameescape(fields[1])
  local line = fields[2]
  local column = tonumber(utils.strsplit(fields[3], ' ')[1])
  local column = column == nil and 1 or column
  dbg('bufname')
  dbg(bufname)
  dbg('line')
  dbg(line)
  dbg('column')
  dbg(column)
  vim.cmd("tab drop " .. bufname)
  vim.cmd('call cursor(' .. line .. ',' .. column .. ')')
end


local function fzf_files(opts)
  if not opts then return end

  -- reset git tracking
  opts.diff_files = nil
  if opts.git_icons and not path.is_git_repo(opts.cwd, true) then opts.git_icons = false end

  coroutine.wrap(function ()
    if opts.cwd_only and not opts.cwd then
      opts.cwd = vim.loop.cwd()
    end

    -- if opts.git_icons then
    --   opts.diff_files = get_diff_files(opts)
    -- end

    local has_prefix = opts.file_icons or opts.git_icons or opts.lsp_icons
    if not opts.filespec then
      opts.filespec = utils._if(has_prefix, "{2}", "{1}")
    end

    local selected = fzf(opts, opts.fzf_fn)

    if opts.post_select_cb then
      opts.post_select_cb()
    end

    if not selected then return end

    if #selected > 1 then
      for i = 2, #selected do
        selected[i] = path.entry_to_file(selected[i], opts.cwd).stripped
        if opts.cb_selected then
          local cb_ret = opts.cb_selected(opts, selected[i])
          if cb_ret then selected[i] = cb_ret end
        end
      end
    end

    open(selected)
  end)()
end

function universal_grep(opts)
  opts = config.normalize_opts(opts, config.globals.grep)
  if not opts then return end

  local no_esc = false
  search = ''
  local command = get_grep_cmd(opts, search, no_esc)

  opts.fzf_fn = function(usr_write_cb, fzf_cb, output_pipe)
    dbg('fzf_fn !')
    local xxx = libuv.spawn_nvim_fzf_cmd(
      { cmd = command, cwd = opts.cwd, pid_cb = opts._pid_cb }, fn_transform)
    dbg('fzf_fn ! 2')
    local zzz = xxx(usr_write_cb, fzf_cb, output_pipe)
    dbg('fzf_fn ! 3')
    return zzz
  end

  opts = core.set_fzf_line_args(opts)
  fzf_files(opts)
end
EOF

" vim:shiftwidth=2 softtabstop=2 tabstop=2
