"set verbosefile=~/.private/.nvim.log

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
"Plug 'git@github.com:suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'junegunn/vim-easy-align'
Plug 'git@github.com:tpope/vim-fugitive' "for git diff
Plug 'git@github.com:jremmen/vim-ripgrep'
"Plug 'pandysong/ghost-text.vim'
"Plug 'git@github.com:vigoux/LanguageTool.nvim'
"Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
Plug 'git@github.com:chiedojohn/vim-case-convert'
Plug 'git@github.com:vim-crystal/vim-crystal'

" rust
Plug 'git@github.com:rust-lang/rust.vim'
"Plug 'simrat39/rust-tools.nvim'
"Plug 'MunifTanjim/rust-tools.nvim' " https://github.com/simrat39/rust-tools.nvim/issues/349 https://github.com/simrat39/rust-tools.nvim/commit/f3bc644c6adf18719bf4ec88aaa8dba43b9ad144
Plug 'airblade/vim-rooter' " changes current dir to project root (that contains .git)
"Plug 'weilbith/nvim-code-action-menu' " also https://github.com/aznhe21/actions-preview.nvim

" kotlin
Plug 'udalov/kotlin-vim'

Plug 'peterhoeg/vim-qml'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim', { 'commit': 'd6aa21476b2854694e6aa7b0941b8992a906c5ec' }
Plug 'junegunn/fzf.vim'

"Plug '~/git-extra/fzf-lua-old'
Plug 'ibhagwan/fzf-lua', { 'commit': 'fd4e94e7a4c139122dbe11f6caee6241c4ab8c00' }
"Plug 'ibhagwan/fzf-lua'

"Plug 'ibhagwan/fzf-lua' " TODO: update to fix references
Plug 'vijaymarupudi/nvim-fzf', { 'do': 'cargo install skim fd-find' }


" lsp references/etc.
"Plug 'gfanto/fzf-lsp.nvim'
"Plug 'nvim-lua/plenary.nvim'

" quickfix settings, for lsp references
Plug 'kevinhwang91/nvim-bqf'





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

" lsp symbol renaming with highlighting
"Plug 'smjonas/inc-rename.nvim'
"Plug 'filipdutescu/renamer.nvim', { 'branch': 'master' }



Plug 'markonm/traces.vim' " due to https://github.com/vim/vim/issues/8795#issuecomment-905734865

Plug 'alopatindev/cargo-limit', { 'do': 'cargo install cargo-limit' }

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
set relativenumber
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
"set termencoding=utf-8 " NOTE: E519: Option not supported: termencoding=utf-8
set notermguicolors
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkoff100-blinkoff100-TermCursor
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
set shortmess=aAoOtIT
set nowritebackup
set undodir=~/.private/.vimundo
set undofile

" put cursor to real end of line in normal mode
set ve+=onemore
nnoremap $ $l
au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

set fileencodings=utf-8,cp1251,koi8-r,cp866
set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r :e ++enc=koi8-r<Enter>
menu Encoding.windows-1251 :e ++enc=cp1251<Enter>
menu Encoding.cp866 :e ++enc=cp866<Enter>
menu Encoding.utf-8 :e ++enc=utf8 <Enter>
menu Encoding.utf-16 :e ++enc=utf16 <Enter>
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


" got to last edited location
map <C-k> ''
map <C-j> ''
imap <C-k> <esc>''
imap <C-j> <esc>''
vmap <C-k> ''
vmap <C-j> ''


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
imap {<Enter> {<Enter>}<Esc>O




fun! CloseDuplicateTabs() abort
  redraw!

  let l:current_name = bufname('%')
  let l:current_tab = tabpagenr()

  tabfirst
  while v:true
    if tabpagenr() !=# l:current_tab && bufname('%') ==# l:current_name
      tabclose
      break
    endif

    if tabpagenr() ==# tabpagenr('$')
      break
    endif

    tabnext
  endwhile

  if l:current_tab <= tabpagenr('$')
    execute 'tabnext ' . l:current_tab
  endif

  redraw
endf

fun! GoToDefinitionOrReferencesOrImplementation() abort
lua << EOF
  --if not vim.lsp.buf.server_ready()
  if #vim.lsp.get_clients({ bufnr = bufnr }) == 0 then
    vim.cmd('tab split')
    vim.cmd('exec("tag ".expand("<cword>"))')
    vim.cmd('call CloseDuplicateTabs()')
    return
  end

  local initial_file = vim.api.nvim_buf_get_name(0)
  local initial_line, initial_column = unpack(vim.api.nvim_win_get_cursor(0))

  local params = vim.lsp.util.make_position_params(0, "utf-16")

  local goto_single_location = function(result)
    local filtered_result = {}
    local remove_lines = {}
    remove_lines[vim.json.encode({initial_file, initial_line})] = true
    for _, location in ipairs(result) do
      local uri = location.uri or location.targetUri
      local range = location.targetSelectionRange or location.targetRange or location.range
      if uri ~= nil and range ~= nil then
        local key = vim.json.encode({
          vim.fn.fnamemodify(vim.uri_to_fname(uri), ':p'),
          range.start.line + 1})
        if not remove_lines[key] then
          table.insert(filtered_result, location)
          remove_lines[key] = true
        end
      end
    end

    if #filtered_result == 1 then
      local location = filtered_result[1]
      local uri = location.uri or location.targetUri
      local range = location.targetSelectionRange or location.targetRange or location.range
      vim.cmd('silent! tab drop ' .. vim.uri_to_fname(uri))
      vim.cmd(string.format(
        'call cursor(%d, %d)',
        range.start.line + 1,
        range.start.character + 1))
      return true, filtered_result
    end
    return false, filtered_result
  end

  local on_implementation = function(_, result, ctx, config)
    if result ~= nil and #result > 0 then
      local found, filtered_result = goto_single_location(result)
      if found then
        return
      elseif #filtered_result > 1 then
        vim.lsp.buf.implementation()
        return
      end
    end
    vim.notify("Not Found")
  end

  local on_references = function(err, result, ctx, config)
    if result ~= nil and #result > 0 then
      local found, filtered_result = goto_single_location(result)
      if found then
        return
      elseif #filtered_result > 1 then
        vim.lsp.buf.references()
        return
      end
    end
    vim.notify("Finding implementation...")
    vim.lsp.buf_request(0, "textDocument/implementation", params, on_implementation)
  end

  local on_goto_definition = function(_, result, ctx, config)
    if result ~= nil and #result > 0 then
      local found, filtered_result = goto_single_location(result)
      if found then
        return
      elseif #filtered_result > 1 then
        vim.lsp.buf.definition()
        return
      end
    end

    params.context = {
      includeDeclaration = true,
    }
    vim.notify("Finding references...")
    vim.lsp.buf_request(0, "textDocument/references", params, on_references)
  end

  vim.notify("Finding definition...")
  vim.lsp.buf_request(0, "textDocument/definition", params, on_goto_definition)
EOF
endf

nnoremap <C-p> :call GoToDefinitionOrReferencesOrImplementation()<Enter>

"nnoremap <C-p> :lua vim.lsp.buf.definition()<Enter>
vnoremap <C-\> :lua vim.lsp.buf.workspace_symbol(vim.fn.expand('<cword>'))<Enter>
nnoremap <C-]> :lua vim.lsp.buf.references()<Enter>



""map <C-\> :tab split<Enter>:exec("tag ".expand("<cword>"))<Enter>
"""map <A-]> :vsp <Enter>:exec("tag ".expand("<cword>"))<Enter>
"nnoremap <C-\> :tab split<Enter>:lua vim.lsp.buf.definition()<Enter>


function! GenerateTags() abort
  silent! execute "!sudo /usr/local/sbin/run_ctags.sh &"
endfunction

autocmd BufRead,BufNewFile *.{c,h,C,cpp,hpp} if !filereadable("tags") | call GenerateTags() | endif









" Auto close quick fix and open in new tab on select
"autocmd FileType qf nnoremap <buffer> <Enter> <Enter>:cclose<Enter><C-W><Enter><C-W>T


" Autoclose quickfix list after leaving it
autocmd WinEnter * cclose


lua << EOF
local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

require('bqf').setup({
    preview = {
        win_height = 200,
    },
    func_map = {
        tabdrop = '<Enter>', -- Auto close quick fix and open in new or existing tab on select
    },
    filter = {
        fzf = {
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--delimiter', '│'}
        }
    }
})
EOF

hi default link BqfPreviewTitle TabLineSel





lua << EOF
require("dressing").setup({
  input = {
    enabled = false, -- disable for symbol rename, etc.
  },
  select = {
    backend = { "fzf", "fzf_lua", "telescope", "builtin", "nui" },
  },
})

--local au = function(events, ptn, cb, once)
--  vim.api.nvim_create_autocmd(events, { pattern=ptn, callback=cb, once=once })
--end
--au(
--  "DiagnosticChanged",
--  "*",
--  function()
--    vim.notify("LSP is ready")
--  end,
--  true)

local _border = "single"
vim.diagnostic.config{
  float = { border = _border },
  virtual_text = false,
  signs = false,
}
EOF

"let g:fzf_lsp_layout = { 'window': { 'border': 'none', 'fullscreen': true } }


" .viminfo settings: remember certain things when we exit
"  '30  :  marks will be remembered for up to 10 previously edited files
"  "500 :  will save up to 100 lines for each register
"  :30  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set shada='30,\"500,:30,%,n~/.private/.viminfo


" Terminal hacks

" C-h for xterm + tmux + nvim
"if &term == "screen"
noremap <bs> :tabp<Enter>
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
"  noremap <bs> :tabp<Enter>
"endif

" requires https://www.vinc17.net/unix/ctrl-backspace.en.html
inoremap <C-Home> <C-w>


" Keyboard shortcuts

map . /

map U <esc>:redo<Enter>
map Г <esc>:redo<Enter>

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

map <C-t> :tabnew<Enter>
imap <C-t> <esc>:tabnew<Enter>
vmap <C-t> <esc>:tabnew<Enter>

" file browser
map <C-F3> :tabnew<Enter>:Ex<Enter>
imap <C-F3> <esc>:tabnew<Enter>:Ex<Enter>
vmap <C-F3> <esc>:tabnew<Enter>:Ex<Enter>
command! E Explore

noremap <C-l> :tabn<Enter>
noremap <C-h> :tabp<Enter>

noremap <S-H> :-tabmove<Enter>
noremap <S-L> :+tabmove<Enter>

vmap <C-l> <esc>:tabn<Enter>
vmap <C-h> <esc>:tabp<Enter>
vmap <bs> <esc>:tabp<Enter>

" TODO: https://stackoverflow.com/a/24047465/586755


" shift-insert behavior is similar to xterm
"map <S-Insert> <MiddleMouse>

" enter insert mode after the cursor
map <S-i> a

"" swap a and i
" nnoremap i a
" nnoremap a i

" search and replace current word
nmap ; :%s/\<<c-r>=expand("<cword>")<Enter>\>/




let g:CargoLimitVerbosity = 2 " warnings level
"let g:CargoLimitVerbosity = 4 " debug level

fun! SaveAllFilesOrOpenNextLocation() abort
  if exists('*CargoLimitOpenNextLocation')
    call g:CargoLimitOpenNextLocation()
  end
  execute 'silent! wa!'
endf

nmap <F1> :call g:CargoLimitOpenPrevLocation()<Enter>
vmap <F1> <Esc>:call g:CargoLimitOpenPrevLocation()<Enter>v
imap <F1> <Esc>:call g:CargoLimitOpenPrevLocation()<Enter>i

nmap <F2> :call SaveAllFilesOrOpenNextLocation()<Enter>
vmap <F2> <Esc>:call SaveAllFilesOrOpenNextLocation()<Enter>v
imap <F2> <Esc>:call SaveAllFilesOrOpenNextLocation()<Enter>i

map cc <esc>:q<Enter>

imap <C-Del> X<Esc>ce
map <C-Del> dw

" sort lines and remove empty ones
vmap s :sort<Enter>:'<,'>g/^\s*$/d<Enter>

" Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
map <F12> :TagbarToggle<Enter>
imap <F12> <esc>:TagbarToggle<Enter>
vmap <F12> <esc>:TagbarToggle<Enter>


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
hi Special term=bold cterm=bold ctermfg=6
hi Statement term=bold cterm=bold gui=bold
hi Type ctermfg=4 cterm=bold
hi String ctermfg=5 cterm=bold
hi Comment ctermfg=6 cterm=bold
"hi LineNr ctermfg=3 cterm=bold " yellow line numbers
hi LineNr ctermfg=242
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
"set cursorline " underline current line



"colorscheme torte
"colorscheme koehler
"colorscheme vim
"colorscheme murphy
"colorscheme ron
"colorscheme industry
"colorscheme elflord
"colorscheme wildcharm



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

hi Statement cterm=bold ctermfg=11 gui=bold guifg=#ffff60
hi clear Pmenu













"let xterm16_colormap = 'allblue'
"colo xterm16

"if $DISPLAY != ''
"	colorscheme default
"else
"	colorscheme evening
"endif

set spelllang=en,ru
"map <S-s> :set spell!<Enter>
map <F7> :set spell!<Enter>
imap <F7> <esc>:set spell!<Enter>
map <C-n> :set relativenumber!<Enter>:set nu!<Enter>
"vunmap <C-n>
"imap <C-n> <Esc>:set relativenumber!<Enter>:set nu!<Enter>
"vmap <C-n> <Esc>:set relativenumber!<Enter>:set nu!<Enter>

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

"map \w :call Browser ()<Enter><Enter>

"map z <C-o>

"urxvt and others terminals hack
map <End> $


" GIT
map <F10> :GitGutterToggle<Enter>:se nu!<Enter>:set paste!<Enter>
nnoremap <C-d> :Git diff %<Enter>
imap <C-d> <esc>:Git diff %<Enter>
vmap <C-d> <esc>:Git diff %<Enter>

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
nnoremap <C-b> :call <SID>BlameToggle()<Enter>
imap <C-b> <esc>:call <SID>BlameToggle()<Enter>
vmap <C-b> <esc>:call <SID>BlameToggle()<Enter>

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
  nnoremap <silent> <Leader>t :call rainbow_parentheses#toggle()<Enter>

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
autocmd BufNewFile,BufRead *.cr set syntax=ruby

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

nnoremap <C-r> :lua require'rust-tools.expand_macro'.expand_macro()<Enter> " TODO: add formatting

function! g:CargoTomlToggle() abort
  if bufname() =~ 'Cargo.toml'
    " FIXME: doesn't close the file
    "exe winnr() . 'close'
    exe ':q'
  else
    lua require 'rust-tools.open_cargo_toml'.open_cargo_toml()
  endif
endfunction

nnoremap cc :vsplit<Enter>:call g:CargoTomlToggle()<Enter>


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
      ['<S-Up>'] = cmp.mapping.scroll_docs(-4),
      ['<S-Down>'] = cmp.mapping.scroll_docs(4),
      ['<S-k>'] = cmp.mapping.scroll_docs(-4),
      ['<S-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-p>'] = cmp.mapping.complete(),
      ['<Enter>'] = cmp.mapping.confirm({
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


vim.lsp.config('rust_analyzer', {
  on_attach = function(client)
    client.server_capabilities.semanticTokensProvider = nil
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'r', vim.lsp.buf.rename)
    vim.keymap.set('v', '<C-p>', vim.lsp.buf.code_action)
  end,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      },
      inlayHints = {
--        enable = true;
--        closureCaptureHints = { enable = true; };
--        closureReturnTypeHints = { enable = "always"; };
--        discriminantHints = { enable = true; };
--        --expressionAdjustmentHints = { enable = true; };
--        genericParameterHints = { type = { enable = true; }; };
      },
      typeHints = {
        enable = true;
      },
----         imports = {
----           granularity = {
----             group = "module",
----           },
----           prefix = "self",
----         },
----         cargo = {
----           buildScripts = {
----             enable = true,
----           },
----         },
----         procMacro = {
----           enable = true
----         },
--         rustfmt = {
--           overrideCommand = {
----           "cat",
--             "rustfmt",
--             "--edition=2024", -- TODO: rustfmt --help | grep '\s--edition' | awk '{print $2}' | sed 's!.*|!!;s!]!!'
--             "--"
--           },
--         },
    }
  }
})
vim.lsp.enable('rust_analyzer')



local ns = vim.api.nvim_create_namespace("rust_inlay_hints_line")

local function show_rust_inlay_hint_on_current_line()
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1

  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
    range = {
      start = { line = row, character = 0 },
      ["end"] = { line = row + 1, character = 0 },
    },
  }

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  vim.lsp.buf_request(bufnr, "textDocument/inlayHint", params, function(err, result, _, _)
    if err or not result then return end

    for _, hint in ipairs(result) do
      if hint.label then
        local label = type(hint.label) == "string" and hint.label or vim.tbl_map(function(part)
          return part.value
        end, hint.label)
        if type(label) == "table" then
          label = table.concat(label)
        end

        vim.api.nvim_buf_set_extmark(bufnr, ns, hint.position.line, hint.position.character, {
          virt_text = { { "=> " .. label:gsub("^: ", ""), "LineNr" } },
          virt_text_pos = "eol",
        })
      end
    end
  end)
end

-- https://github.com/nvim-lualine/lualine.nvim/issues/1201#issuecomment-2763357226
local function stl_escape(str)
  if type(str) ~= 'string' then
    return str
  end
  return str:gsub('%%', '%%%%')
end

local function show_rust_diagnostic_for_current_line()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.fn.line('.') - 1
  local diag = vim.diagnostic.get(bufnr, { lnum = line })
  vim.opt.statusline = #diag > 0 and stl_escape(diag[1].message:gsub('\n', ' ')) or ''
end

vim.api.nvim_create_autocmd("CursorMoved", { callback = show_rust_inlay_hint_on_current_line })

vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
  pattern = '*.rs',
  callback = show_rust_diagnostic_for_current_line,
})

vim.opt.updatetime = 10

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


let g:crystal_auto_format = 1


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




fun! OnQuit()
  call system('logger exiting nvim')
  for i in getbufinfo()
    if !empty(i.name) && !i.hidden
      "echo i.name
      call system('logger -- ' . fnameescape(i.name))
    endif
  endfor
  echo
endf

autocmd VimLeavePre * call OnQuit()




" Search in filenames and file bodies

if executable('rg') && executable('fd')
  let g:rg_opts = '
    \ --line-number --no-column --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --color always
    \ --glob "*.{c,C,cfg,conf,config,cpp,css,cxx,ebuild,go,h,hpp,hs,html,ini,j2,jade,java,js,lua,md,markdown,nvim,php,pl,py,rb,rs,scala,sh,sql,styl,toml,vim}"
    \ --glob "{Dockerfile,.gitignore,README,INSTALL,Makefile,Gemfile}"
    \ --glob "!{.git,build,node_modules,vendor,target}/*" '
  let g:fd_opts = '--type f --exclude .git --exclude build --exclude node_modules --exclude vendor --exclude target'

  nnoremap <F3> :lua relevant_files()<Enter>
  imap <F3> <esc>:lua relevant_files()<Enter>
  vmap <F3> <esc>:lua relevant_files()<Enter>

  nnoremap <F4> :lua relevant_grep()<Enter>
  imap <F4> <esc>:lua relevant_grep()<Enter>
  vmap <F4> <esc>:lua relevant_grep()<Enter>

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

"echo 'start nvim'

" vim:shiftwidth=2 softtabstop=2 tabstop=2
