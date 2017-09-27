"set viminfo='100,n~/.config/nvim/nviminfo'

set directory=/tmp/.vimswaps//

call plug#begin('~/.config/nvim/plugged')

Plug 'git@github.com:vimwiki/vimwiki.git'
Plug 'git@github.com:vim-scripts/rainbow_parentheses.vim'
Plug 'git@github.com:vim-scripts/taglist.vim'
Plug 'git@github.com:vim-scripts/Indent-Guides.git'
Plug 'git@github.com:vim-scripts/Tagbar.git'
"Plug 'git@github.com:vim-scripts/vim-gitgutter'
Plug 'git@github.com:airblade/vim-gitgutter'
Plug 'git@github.com:gentoo/gentoo-syntax'
Plug 'git@github.com:derekwyatt/vim-scala'
Plug 'git@github.com:zaiste/tmux.vim'
Plug 'git@github.com:rust-lang/rust.vim'
Plug 'git@github.com:editorconfig/editorconfig-vim'
Plug 'git@github.com:cespare/vim-toml'
Plug 'git@github.com:Chiel92/vim-autoformat'
Plug 'git@github.com:kchmck/vim-coffee-script.git'
Plug 'git@github.com:leafgarland/typescript-vim.git'
Plug 'git@github.com:ekalinin/Dockerfile.vim.git'
Plug 'git@github.com:Shougo/deoplete.nvim'
Plug 'git@github.com:carlitux/deoplete-ternjs'
Plug 'git@github.com:alopatindev/vim-scaladoc.git'
"Plug 'git@github.com:kassio/neoterm'
"Plug 'git@github.com:fidian/hexmode.git'
"Plug 'git@github.com:timburgess/extempore.vim.git'
Plug 'git@github.com:jparise/vim-graphql'
Plug 'git@github.com:elubow/cql-vim'
" :PlugInstall

call plug#end()

"set textwidth=80

" цвет статусбара
" highlight StatusLine ctermfg=15 ctermbg=8 gui=none

" увеличиваем статус бар
"resize -1
"source /usr/share/vim/vimfiles/ftplugin/python/python_fn.vim
" игнорировать регистр букв при поиске
set ignorecase

" Включаем несовместимость настроек с Vi (ибо Vi нам и не понадобится).
set nocompatible

" Показывать положение курсора всё время.
set ruler  

" Показывать незавершённые команды в статусбаре
set showcmd  

" Включаем нумерацию строк
set nu

" Фолдинг по отсупам
"set foldmethod=indent
set foldmethod=manual

" Поиск по набору текста (очень полезная функция)
set incsearch

" Отключаем подстветку найденных вариантов, и так всё видно.
set nohlsearch

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы подняться в режиме редактирования
"set scrolljump=7
set scrolljump=4

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы опуститься в режиме редактирования
"set scrolloff=7
set scrolloff=4

" Выключаем надоедливый звонок
set novisualbell
set t_vb=   

" Поддержка мыши
"set mouse=a
set mouse=n
set mousemodel=popup

" Кодировка текста по умолчанию
set termencoding=utf-8

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
"set hidden

" Скрыть панель в gui версии ибо она не нужна
set guioptions-=T

" Сделать строку команд высотой в одну строку
set ch=1

" Скрывать указатель мыши, когда печатаем
set mousehide

" Включить автоотступы
set autoindent

" Влючить подстветку синтаксиса
syntax on

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Преобразование Таба в пробелы
set expandtab

" Размер табулации по умолчанию
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Формат строки состояния
" set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set laststatus=2

" Включаем "умные" отспупы ( например, автоотступ после {)
set smartindent

" Fix <Enter> for comment
set fo+=cr

" Опции сесссий
set sessionoptions=curdir,buffers,tabpages

"-------------------------
" Горячие клавиши
"-------------------------


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

map П G

map в d

" Пробел в нормальном режиме перелистывает страницы
" nmap <Space> <PageDown>

" CTRL-F для omni completion
" imap <C-F> <C-X><C-O>

" C-c and C-v - Copy/Paste в 'глобальный клипборд'
vmap <C-C> "+yi
"imap <C-V> <esc>"+gPi

imap <C-S-v> <esc>"*pi

" в начало файла
"map <C-PageUp> 1<S-G>
"imap <C-PageUp> <esc>1<S-g>
"vmap <C-PageUp> <esc>1<S-g>

" в конец файла
"map <C-PageDown> <S-g>
"imap <C-PageDown> <esc><S-g>
"vmap <C-PageDown> <esc><S-g>

" C-t - новый таб
map <C-t> :tabnew<cr>
imap <C-t> <esc>:tabnew<cr>
vmap <C-t> <esc>:tabnew<cr>

" F3 - открыть файл в табе
map <F3> :tabnew<cr>:Ex<cr>
imap <F3> <esc>:tabnew<cr>:Ex<cr>
vmap <F3> <esc>:tabnew<cr>:Ex<cr>

" хэлп
map <F1> :tabnew<cr>:help<cr><C-W>j<C-W>c
"imap <F1> :tabnew<cr>:help<cr><C-W>j<C-W>c
"vmap <F1> :tabnew<cr>:help<cr><C-W>j<C-W>c

" следущий, предыдущий таб
"map <S-Right> :tabn<cr>
"map <S-Left> :tabp<cr>
"imap <S-Right> <esc>:tabn<cr>
"imap <S-Left> <esc>:tabp<cr>
"vmap <S-Right> <esc>:tabn<cr>
"vmap <S-Left> <esc>:tabp<cr>
map <S-l> :tabn<cr>
map <S-h> :tabp<cr>
map Д :tabn<cr>
map Р :tabp<cr>
"map <S-j> :tabnew<cr>
"imap <S-l> <esc>:tabn<cr>
"imap <S-h> <esc>:tabp<cr>
"imap <S-j> :tabnew<cr>
vmap <S-l> <esc>:tabn<cr>
vmap <S-h> <esc>:tabp<cr>
vmap Д <esc>:tabn<cr>
vmap Р <esc>:tabp<cr>
"vmap <S-j> :tabnew<cr>

" C-n - новый split
""map <C-A-N> <C-W>n

" Заставляем shift-insert работать как в Xterm
map <S-Insert> <MiddleMouse>

" C-y - удаление текущей строки
" nmap <C-y> dd
" imap <C-y> <esc>ddi

" C-d - дублирование текущей строки
imap <C-d> <esc>yypi

" Поиск и замена слова под курсором
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

" F2 - быстрое сохранение
nmap <F2> :wa<cr>
vmap <F2> <esc>:wa<cr>v
imap <F2> <esc>:wa<cr>i

" F8 - список закладок
"map <F8> :MarksBrowser<cr>
"vmap <F8> <esc>:MarksBrowser<cr>
"imap <F8> <esc>:MarksBrowser<cr>

" F9 - "make" команда
map <F9> :make<cr><cr><cr>
vmap <F9> <esc>:make<cr><cr><cr>
imap <F9> <esc>:make<cr><cr><cr>

" F10 -закрыть текущий фрейм/tab
"map <F10> <C-W>c
"map <F10> <esc>:q<cr>

" F11 - Vimcommander
" noremap <silent> <F11> :cal VimCommanderTogglu()<CR>
"map <C-l> :set nonu<cr>:<bs>
"map <S-l> :set nu<cr>:<bs>
 
" F12 - показать окно Taglist
"map <F12> :TlistToggle<cr>
"vmap <F12> <esc>:TlistToggle<cr>
"imap <F12> <esc>:TlistToggle<cr>

" < & > - делаем отступы для блоков
vmap < <gv
vmap > >gv

map r :set wrap!<cr>

" Выключаем ненавистный режим замены
" imap >Ins> <Esc>i

" Редко когда надо [ без пары =)
" imap [ []<LEFT>
" Аналогично и для {
imap {<CR> {<CR>}<Esc>O

" С-q - выход из Vim 
" map <C-Q> <Esc>:qa<cr>


"" Автозавершение слов по tab =)
"function InsertTabWrapper()
"	let col = col('.') - 1
"	if !col || getline('.')[col - 2] !~ '\k'
"		return "\<tab>"
"	else
"		return "\<c-p>"
"	endif
"endfunction
""imap <S-tab> <c-r>=InsertTabWrapper()<cr>
"
""" Слова откуда будем завершать
"set complete=""
""" Из текущего буфера
"set complete+=.
""" Из словаря
"set complete+=k
""" Из других открытых буферов
"set complete+=b
""" из тегов
"set complete+=t
"
" Включаем filetype плугин. Настройки, специфичные для определынных файлов мы разнесём по разным местам
filetype on
filetype plugin on
"au BufRead,BufNewFile *.phps    set filetype=php
"au BufRead,BufNewFile *.thtml    set filetype=php

au BufNewFile,BufRead *.toml set filetype=toml
" Rust uses Cargo.toml and Cargo.lock (both are toml files).
au BufNewFile,BufRead Cargo.lock set filetype=toml

"
"" Настройки для SessionMgr
"let g:SessionMgr_AutoManage = 0
"let g:SessionMgr_DefaultName = "mysession"
"
"" Настройки для Tlist (показвать только текущий файл в окне навигации по коду)
"let g:Tlist_Show_One_File = 1
"
"set completeopt-=preview
"set completeopt+=longest
"set mps-=[:]
"
""-------------------------
"" PHP настройки
""-------------------------
"
"" Используем словарь PHP для автодополнения,
"" который можно скачать отсюда http://lerdorf.com/funclist.txt
""set dictionary=~/.vim/dic/php
"
"" Сделаем удобную навигацию по мануалу PHP
""set keywordprg=~/.vim/bin/php_doc 
"set keywordprg=~/.vim/bin/cpp_doc
""set keywordprg=/usr/bin/man
"
"" Проверка синтаксиса PHP
""set makeprg=php\ -l\ %
"
"" Формат вывода ошибок PHP
""set errorformat=%m\ in\ %f\ on\ line\ %l
"
"" Полезные "быстрые шаблоны"
"" Вывод отладочной информации
"iabbrev dbg echo '<pre>';var_dump( );echo '</pre>';
"iabbrev tm echo 'Test message in file: '.__FILE__.', on line: '.__LINE__;
"
"let g:pdv_cfg_Uses = 1
"
"" Vim постовляется с достаточно мощным плугином подстветки синтаксиса PHP.
"" Помимо прочего он умеет:
"
"" Включаем фолдинг для блоков классов/функций
"" let php_folding = 1
"
"" Не использовать короткие теги PHP для поиска PHP блоков
"let php_noShortTags = 1
"
"" Подстветка SQL внутри PHP строк
"let php_sql_query=1
"
"" Подстветка HTML внутри PHP строк
"let php_htmlInStrings=1 
"
"" Подстветка базовых функций PHP
"let php_baselib = 1
"
"
"
"" Python!
"
"function! PythonCommentSelection()  range
"  let commentString = "#"
"  let cl = a:firstline
"  let ind = 1000    " I hope nobody use so long lines! :)
"
"  " Look for smallest indent
"  while (cl <= a:lastline)
"    if strlen(getline(cl))
"      let cind = indent(cl)
"      let ind = ((ind < cind) ? ind : cind)
"    endif
"    let cl = cl + 1
"  endwhile
"  if (ind == 1000)
"    let ind = 1
"  else
"    let ind = ind + 1
"  endif
"
"  let cl = a:firstline
"  execute ":".cl
"  " Insert commentString in each non-empty line, in column ind
"  while (cl <= a:lastline)
"    if strlen(getline(cl))
"      execute "normal ".ind."|i".commentString
"    endif
"    execute "normal \<Down>"
"    let cl = cl + 1
"  endwhile
"endfunction
"
"
"
"
"vmap H :call PythonCommentSelection()<CR>
"
""let python_highlight_space_errors = 1
"
"
""set cursorline
"
"
"
"" Tab autocompletion
""function InsertTabWrapper()
""let col = col('.') - 1
""if !col || getline('.')[col - 1] !~ '\k'
""return "\<tab>"
""else
""return "\<c-p>"
""endif
""endfunction
"
""imap <S-tab> <C-r>=InsertTabWrapper()<cr>


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

" colors
" colorscheme slate
"colorscheme evening

"hi Normal ctermfg=lightgrey
"hi Normal ctermbg=black

"hi Type ctermfg=blue
"hi Special term=bold cterm=bold

"" hi StatusLine ctermfg=white ctermbg=darkgrey cterm=none
""hi StatusLine ctermfg=black ctermbg=darkgreen cterm=none
"hi Folded ctermfg=white ctermbg=black
"hi Visual ctermbg=darkcyan
"hi StatusLine ctermfg=white ctermbg=darkcyan cterm=none
"hi StatusLine ctermfg=black ctermbg=darkgreen cterm=none
hi StatusLine ctermfg=white ctermbg=darkblue cterm=none

" FIXME
"hi Pmenu ctermfg=black ctermbg=green cterm=none guibg=brown gui=bold
"hi PmenuSel ctermfg=green ctermbg=black cterm=none guibg=red gui=bold
"hi PmenuSbar ctermfg=green ctermbg=black cterm=none guibg=red gui=bold
"hi PmenuThumb ctermfg=green ctermbg=black cterm=none guibg=red gui=bold

" кодировки
set fileencodings=utf-8,cp1251,koi8-r,cp866

"let xterm16_colormap = 'allblue'
"colo xterm16


set spelllang=en,ru
"map <S-s> :set spell!<cr>
map <F7> :set spell!<cr>
imap <F7> <esc>:set spell!<cr>

map <A-n> :set nu!<cr>

"if $DISPLAY != ''
"	colorscheme default
"else
"	colorscheme evening
"endif

""hi TabLineSel term=bold  ctermfg=white ctermbg=darkgreen
hi TabLineSel term=bold  ctermfg=black ctermbg=green
""ctermbg=darkblue
hi TabLine ctermfg=white ctermbg=black
hi TabLineFill term=bold,reverse  cterm=bold ctermfg=lightblue ctermbg=black
"hi Comment cterm=bold
"hi Directory ctermfg=3 cterm=none

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

"function! CompileAndRun ()
"   exec "!OUT=$(echo -n % | sed 's/\.c[cpp]$//') && g++ -ggdb % -o $OUT && gdb --eval-command=r --eval-command=q ./$OUT"
""   exec "!fpc % && ./$(echo % | sed 's/\.pas$//')"
"endfunction
"
"map <F11> :call CompileAndRun()<CR>
"
map <C-o> :!<cr>
imap <C-o> <esc>:!<cr>
vmap <C-o> <esc>:!<cr>



"let g:manpageview_winopen="only"
"
"let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
""set nocompatible


hi Todo ctermfg=gray ctermbg=darkblue


"urxvt and others terminals hack
map <End> $




"" C++
"set tags=~/.vim/stdtags,tags,.tags,../tags
""set tags=~/.vim/stdtags,qt4tags
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

""map <C-u> !ctags -f ~/.vim/stdtags -R --c++-kinds=+p --fields=+iaS --extra=+q .




set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>
menu Encoding.utf-16 :e ++enc=utf16 <CR>
map <F8> :emenu Encoding.<TAB>





map <F10> :set paste!<cr>
map <C-r> :set paste!<cr>

" set term=xterm


" LaTeX
"set grepprg=grep\ -nH\ $*


set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time

"set viminfo='20,\"500   " Keep a .viminfo file.

" Tell vim to remember certain things when we exit
"  '30  :  marks will be remembered for up to 10 previously edited files
"  "500 :  will save up to 100 lines for each register
"  :30  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='30,\"500,:30,%,n~/.viminfo

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

if v:version >= 700
  set numberwidth=3
endif

if &term ==? "xterm"
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2
endif


au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

map <F12> :TagbarOpenAutoClose<cr>
imap <F12> <esc>:TagbarOpenAutoClose<cr>
vmap <F12> <esc>:TagbarOpenAutoClose<cr>

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"" C++ completion {
""let g:clang_user_options='|| exit 0'
""let g:clang_user_options='-I/usr/include/ClanLib-2.3/ClanLib/Display/2D/ 2>> /dev/null || exit 0'
""let g:clang_complete_auto = 0
"
"let g:clang_use_library = 1
"let g:clang_periodic_quickfix = 0
"let g:clang_close_preview = 1
""let g:clang_snippets_engine = 'ultisnips'
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_extra_conf_globlist = ['~/git/*']
"" }

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
        \ ['blue',       'RoyalBlue3'],
        \ ['white',    'SeaGreen3'],
        \ ['darkyellow',       'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['blue',    'RoyalBlue3'],
        \ ['white',     'SeaGreen3'],
        \ ['darkyellow', 'DarkOrchid3'],
        \ ['darkgreen',       'firebrick3'],
        \ ['blue',    'RoyalBlue3'],
        \ ['white',  'SeaGreen3'],
        \ ['darkyellow', 'DarkOrchid3'],
        \ ['darkgreen',    'firebrick3'],
        \ ['blue',   'RoyalBlue3'],
        \ ['white',    'SeaGreen3'],
        \ ['darkyellow',     'DarkOrchid3'],
        \ ['darkgreen',         'firebrick3'],
        \ ]
" }

" indent guides
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=red   ctermbg=darkcyan
hi IndentGuidesEven guibg=green ctermbg=Darkblue
se ts=4 sw=4 et
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
"let g:indent_guides_enable_on_vim_startup = 1


command! E Explore
se nohlsearch
filetype plugin indent on
set completeopt=longest,menuone


" open omni completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'


" Shift tab is autocompletion
"inoremap <S-Tab> <C-x><C-u>


"let g:EclimShowCurrentError = 0
"let g:EclimSignLevel = 'off'
"let g:EclimLogLevel = 'off'
"let g:EclimScalaValidate = 0

let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']
"au BufWrite *.rs :Autoformat

set tags=tags,.tags,rusty-tags.vi

autocmd BufWrite *.rs :silent exec "!rusty-tags vi -q"
let g:rustfmt_autosave = 1

let g:formatdef_jsbeautify_json = '"js-beautify --indent-size 2"' " FIXME
"let g:formatdef_jsbeautify_javascript = '"js-beautify --indent-size 2"' " FIXME
au BufWrite *.ts :Autoformat
au BufWrite *.js :Autoformat
au BufWrite *.json :Autoformat


"let g:formatdef_scalafmt = "'ng scalafmt --stdin'"
let g:formatdef_scalafmt = "'scalafmt-client.sh 8899'"
let g:formatters_scala = ['scalafmt']
au BufWrite *.scala :Autoformat
"noremap <F5> :Autoformat<CR>


autocmd BufEnter,FocusGained * checktime

se number
" se relativenumber

set shortmess=aoOtIT

"" Use deoplete
"let g:deoplete#enable_at_startup = 1
"let g:tern_request_timeout = 1
""let g:tern_show_signature_in_pum = '0'
""let g:deoplete#auto_complete_delay = 2000
"let g:deoplete#disable_auto_complete = 1
"
"" Let <C-/> also do completion
"inoremap <silent><expr> <C-_>
"\ pumvisible() ? "\<C-n>" :
"\ deoplete#mappings#manual_complete()

let g:scaladoc_urls = 'https://www.scala-lang.org/api/current,https://spark.apache.org/docs/latest/api/scala,https://datastax.github.io/spark-cassandra-connector/ApiDocs/2.0.3/spark-cassandra-connector,https://www.playframework.com/documentation/latest/api/scala,http://doc.akka.io/api/akka/current,https://scalaj.github.io/scalaj-http/2.0.0,http://doc.scalatest.org/3.0.0'

nnoremap <F1> :call scaladoc#Search(expand("<cword>"))<CR>
imap <F1> <esc><F1>
