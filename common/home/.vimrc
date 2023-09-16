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
Plug 'git@github.com:suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'junegunn/vim-easy-align'
Plug 'git@github.com:tpope/vim-fugitive' "for git diff
Plug 'git@github.com:jremmen/vim-ripgrep'
"Plug 'pandysong/ghost-text.vim'
"Plug 'git@github.com:vigoux/LanguageTool.nvim'
"Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
Plug 'git@github.com:chiedojohn/vim-case-convert'

" rust
Plug 'git@github.com:rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'airblade/vim-rooter' " changes current dir to project root (that contains .git)


Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim', { 'commit': 'd6aa21476b2854694e6aa7b0941b8992a906c5ec' }
Plug 'junegunn/fzf.vim'

"Plug '~/git-extra/fzf-lua-old'
Plug 'ibhagwan/fzf-lua', { 'commit': 'fa006b8d9f24b4a58eb4220c871e432c3e5df1da' }
"Plug 'ibhagwan/fzf-lua'

"Plug 'ibhagwan/fzf-lua' " TODO: update to fix references
Plug 'vijaymarupudi/nvim-fzf', { 'do': 'cargo install skim fd-find' }


" lsp references/etc.
"Plug 'gfanto/fzf-lsp.nvim'
"Plug 'nvim-lua/plenary.nvim'


Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" nowadays even Enter button in manual completion needs
" couple of additional dependencies, fucking hilarious
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'


" vim.ui.select => code actions, etc.
Plug 'stevearc/dressing.nvim'


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
set foldlevel=4
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
vmap <tab> >gv
vmap <S-tab> <gv
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_start_level=2
"let g:indent_guides_guide_size=1
""let g:indent_guides_enable_on_vim_startup = 1
"hi IndentGuidesOdd  guibg=red   ctermbg=darkcyan
"hi IndentGuidesEven guibg=green ctermbg=Darkblue

" auto closing character
" imap [ []<LEFT>
imap {<CR> {<CR>}<Esc>O


""map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"""map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"nnoremap <C-\> :tab split<CR>:lua vim.lsp.buf.definition()<cr>
nnoremap <C-\> :lua vim.lsp.buf.definition()<cr>
nnoremap <C-]> :lua vim.lsp.buf.references()<CR>

" auto close quick fix on select
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

lua << EOF
local au = function(events, ptn, cb, once) vim.api.nvim_create_autocmd(events, {pattern=ptn, callback=cb, once=once}) end
au(
  "DiagnosticChanged",
  "*",
  function()
    vim.notify("LSP is ready")
  end,
  true)

local default_definition_handler = vim.lsp.handlers["textDocument/definition"]
vim.lsp.handlers["textDocument/definition"] = function(_, result, ctx, config)
  local initial_file = vim.api.nvim_buf_get_name(0)
  local initial_row, initial_column = unpack(vim.api.nvim_win_get_cursor(0))

  if #result == 1 then
    local location = result[1]
    local uri = location.uri or location.targetUri
    if uri ~= nil then
      vim.cmd('tab drop ' .. vim.uri_to_fname(uri))
    end
  end
  default_definition_handler(_, result, ctx, config)

  local current_file = vim.api.nvim_buf_get_name(0)
  local current_row, current_column = unpack(vim.api.nvim_win_get_cursor(0))
  local same_location = current_file == initial_file and current_row == initial_row and current_column == initial_column
  if same_location then
    vim.lsp.buf.implementation()
  end

  local current_file = vim.api.nvim_buf_get_name(0)
  local current_row, current_column = unpack(vim.api.nvim_win_get_cursor(0))
  local same_location = current_file == initial_file and current_row == initial_row and current_column == initial_column
  if same_location then
    --vim.notify("Finding references...")
    vim.lsp.buf.references()
  end
end


local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.lsp.handlers['textDocument/references'] = require'fzf-lua'.lsp_references

vim.diagnostic.config{
  float = { border = _border }
}
EOF

"let g:fzf_lsp_layout = { 'window': { 'border': 'none', 'fullscreen': true } }


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

" requires https://www.vinc17.net/unix/ctrl-backspace.en.html
inoremap <C-Home> <C-w>


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

" TODO: https://stackoverflow.com/a/24047465/586755


" shift-insert behavior is similar to xterm
"map <S-Insert> <MiddleMouse>

" enter insert mode after the cursor
map <S-i> a

" search and replace current word
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/


function! SaveAllFilesOrOpenNextLocation()
  let l:all_files_are_saved = 1
  for i in getbufinfo({'bufmodified': 1})
    if i.hidden && i.name == ''
      bdelete! i.bufnr " FIXME
    elseif i.name != ''
      let l:all_files_are_saved = 0
      break
    endif
  endfor

  if l:all_files_are_saved
    call g:CargoLimitOpenNextLocation()
  else
    execute 'wa'
  endif
endfunction

nmap <F2> :call SaveAllFilesOrOpenNextLocation()<cr>
vmap <F2> <esc>:call SaveAllFilesOrOpenNextLocation()<cr>v
imap <F2> <esc>:call SaveAllFilesOrOpenNextLocation()<cr>i

map cc <esc>:q<cr>

imap <C-Del> X<Esc>ce
map <C-Del> dw

" sort lines and remove empty ones
vmap s :sort<cr>:'<,'>g/^\s*$/d<cr>

" Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
map <F12> :TagbarToggle<cr>
imap <F12> <esc>:TagbarToggle<cr>
vmap <F12> <esc>:TagbarToggle<cr>


"" Colors
""colorscheme evening
"colorscheme peachpuff
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
hi Special term=bold ctermfg=red
hi Statement term=bold cterm=bold gui=bold
hi Type ctermfg=4 cterm=bold
hi String ctermfg=5 cterm=bold
hi Comment ctermfg=6 cterm=bold
hi LineNr ctermfg=3 cterm=bold
hi Search ctermfg=0
hi Constant cterm=bold
hi StatusLineNC cterm=bold ctermfg=0
"hi StatusLine cterm=bold ctermfg=2
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
"hi Visual ctermbg=darkblue ctermfg=white term=reverse
hi Visual ctermbg=darkblue term=bold
"hi Visual ctermbg=darkgrey term=bold
"hi StatusLine ctermfg=white ctermbg=darkcyan cterm=none
"hi StatusLine ctermfg=black ctermbg=darkgreen cterm=none
hi StatusLine ctermfg=white ctermbg=darkblue cterm=none
"hi Pmenu ctermfg=black ctermbg=green cterm=none guibg=brown gui=bold
"hi PmenuSel ctermfg=green ctermbg=black cterm=none guibg=red gui=bold
hi PmenuSel ctermfg=black ctermbg=yellow cterm=none guibg=red gui=bold
"hi PmenuSbar ctermfg=green ctermbg=black cterm=none guibg=red gui=bold
"hi PmenuThumb ctermfg=green ctermbg=black cterm=none guibg=red gui=bold
"highlight Pmenu ctermbg=blue guibg=blue
"highlight Pmenu ctermbg=darkblue guibg=darkblue
highlight Pmenu ctermfg=NONE ctermbg=NONE

""hi TabLineSel term=bold  ctermfg=white ctermbg=darkgreen
hi TabLineSel term=bold  ctermfg=black ctermbg=green
""ctermbg=darkblue
hi TabLine ctermfg=white ctermbg=black
hi TabLineFill term=bold,reverse  cterm=bold ctermfg=lightblue ctermbg=black
hi TabLineSel ctermfg=black ctermbg=darkgreen cterm=NONE



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

"map \w :call Browser ()<cr><cr>

map z <C-o>

"urxvt and others terminals hack
map <End> $


" GIT
map <F10> :GitGutterToggle<cr>:se nu!<cr>:set paste!<cr>
nnoremap <C-d> :Git diff %<cr>
imap <C-d> <esc>:Git diff %<cr>
vmap <C-d> <esc>:Git diff %<cr>

function! s:BlameToggle() abort
  let found = 0
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), '&filetype') ==# 'fugitiveblame'
      exe winnr . 'close'
      let found = 1
    endif
  endfor
  if !found
    Git blame
  endif
endfunction
nnoremap <C-b> :call <SID>BlameToggle()<cr>
imap <C-b> <esc>:call <SID>BlameToggle()<cr>
vmap <C-b> <esc>:call <SID>BlameToggle()<cr>

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
autocmd BufNewFile,BufRead *.ncl set syntax=haskell
autocmd BufNewFile,BufRead *.ym{a,}l_debug set syntax=yaml

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
autocmd BufWritePre *.rs lua vim.lsp.buf.format({ async = false })

nnoremap <C-r> :lua require'rust-tools.expand_macro'.expand_macro()<CR> " TODO: add formatting

nnoremap cc :vsplit<cr>:lua require 'rust-tools.open_cargo_toml'.open_cargo_toml()<cr> " TODO: toggle

lua << EOF
  local cmp = require'cmp' -- nvim-cmp

  local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
      ['<C-Down>'] = cmp.mapping.scroll_docs(4),
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-p>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace
      }),
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    }),
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp' },
        --{ name = "vsnip" },
        { name = "path" },
      },
      {
        { name = 'buffer' },
      }
    ),
    formatting = {
      format = function(entry, vim_item)
        --vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
        vim_item.kind = kind_icons[vim_item.kind]

--        vim_item.menu = ({
--          buffer = "[Buffer]",
--          nvim_lsp = "[LSP]",
--          luasnip = "[LuaSnip]",
--          nvim_lua = "[Lua]",
--          latex_symbols = "[LaTeX]",
--        })[entry.source.name]
        vim_item.menu = ''

        local window_width = vim.api.nvim_win_get_width(0)
        local _current_row, current_column = unpack(vim.api.nvim_win_get_cursor(0))
        local free_right_area = window_width - current_column
        vim_item.abbr = string.sub(vim_item.abbr, 1, free_right_area / 4) -- limit completion width

        return vim_item
      end
    },
  })

--  -- gray
--  vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
--  -- blue
--  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
--  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
--  -- light blue
--  vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
--  vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
--  vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
--  -- pink
--  vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
--  vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
--  -- front
--  vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
--  vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
--  vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

--  cmp.setup.cmdline({ '/', '?' }, {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = {
--      { name = 'buffer' }
--    }
--  })

--  cmp.setup.cmdline(':', {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = cmp.config.sources({
--      { name = 'path' }
--    }, {
--      { name = 'cmdline' }
--    })
--  })


local nvim_lsp = require'lspconfig'

-- vim.lsp.set_log_level('OFF')


--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local rt = require("rust-tools")
rt.setup({
  server = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    capabilities = capabilities,
    -- capabilities = require'lsp.handlers'.capabilities,
    --capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client)
        client.server_capabilities.semanticTokensProvider = nil
        vim.highlight.priorities.semantic_tokens = 95

        -- TODO: perhaps run before on_attach
        --vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        --vim.keymap.set("n", "<C-e>", rt.code_action_group.code_action_group, { buffer = bufnr })
        --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'r', vim.lsp.buf.rename)
        vim.keymap.set('v', '<C-p>', vim.lsp.buf.code_action)

        --require'completion'.on_attach(client)
    end,
--    settings = {
--        ["rust-analyzer"] = {
--            imports = {
--                granularity = {
--                    group = "module",
--                },
--                prefix = "self",
--            },
--            cargo = {
--                buildScripts = {
--                    enable = true,
--                },
--            },
--            procMacro = {
--                enable = true
--            },
--            diagnostics = {
--                enable = false,
--            },
--            rustfmt = {
--                overrideCommand = {
--                  "rustfmt",
--                  "--edition=2021",
--                  "--"
--                },
--            },
--        }
--    }
  },
  tools = {
    inlay_hints = {
      highlight = "Folded",
      only_current_line = true,
    },
    --hover_with_actions = true,
  }
})

vim.diagnostic.config({
  virtual_text = false,
  signs = false,
})

EOF


"" manual complete
autocmd BufRead * lua require'cmp'.setup.buffer {
\   completion = {
\     autocomplete = false
\   }
\ }

autocmd TabEnter * lua require'cmp'.setup.buffer {
\   completion = {
\     autocomplete = false
\   }
\ }

autocmd BufEnter * lua require'cmp'.setup.buffer {
\   completion = {
\     autocomplete = false
\   }
\ }

autocmd WinEnter * lua require'cmp'.setup.buffer {
\   completion = {
\     autocomplete = false
\   }
\ }

"" JavaScript/ECMAScript
"let g:formatdef_jsbeautify_json = '"js-beautify --indent-size 2"'
"au BufWrite *.ts :Autoformat
"au BufWrite *.js :Autoformat
"au BufWrite *.json :Autoformat

" Ruby
au BufWrite *.rb :Autoformat


au FileType markdown vmap a :EasyAlign*<Bar><Enter>


autocmd BufEnter,FocusGained * checktime

function! s:close_tab_if_empty()
  function! s:on_exit()
    if mode() == 't'
      q
    end
  endfunction
  call jobstart(['sleep', '1'], {'on_exit': function('s:on_exit')})
endfunction

" Search in filenames and file bodies

if executable('rg') && executable('fd')
  let g:rg_opts = '
    \ --line-number --no-column --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --color always
    \ --glob "*.{c,C,cfg,conf,config,cpp,css,cxx,ebuild,go,h,hpp,hs,html,ini,j2,jade,java,js,lua,md,markdown,nvim,php,pl,py,rb,rs,scala,sh,sql,styl,toml,vim}"
    \ --glob "{Dockerfile,.gitignore,README,INSTALL,Makefile,Gemfile}"
    \ --glob "!{.git,build,node_modules,vendor,target}/*" '
  let g:fd_opts = '--type f --exclude .git --exclude build --exclude node_modules --exclude vendor --exclude target'

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
        vertical = 'up:50%',
        --hidden = 'hidden',
        default = 'bat',
      }
    },
    previewers = {
      bat = {
        theme = "zenburn",
        args = "--line-range :50 --style=plain --color=always",
      }
    },
    --fzf_opts = {
    --  ['--layout'] = 'default',
    --},
    fzf_opts = {
      ['--color'] = 'bg:black,bg+:black,fg:blue,fg+:yellow',
    },
    grep = {
      rg_opts = vim.g.rg_opts,
      prompt = '> ',
    },
    files = {
      fd_opts = vim.g.fd_opts,
    },
  }
EOF
endif

"set verbosefile=~/.nvim.log
"echo 'start nvim'

" vim:shiftwidth=2 softtabstop=2 tabstop=2
