if &compatible
  set nocompatible
endif


set runtimepath^=~/.vim/repos/github.com/Shougo/dein.vim

call dein#begin(expand('/home/hiroki/.vim/'))

"these are good: https://github.com/Shougo/shougo-s-github/blob/master/vim/rc/dein.toml
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim') "acync-proceccing

call dein#add('Shougo/neocomplete.vim') "completion
call dein#add('Shougo/neomru.vim') "save file history
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/unite.vim') "file opener, manager
call dein#add('tomasr/molokai')
call dein#add('LeafCage/yankround.vim') " save yank history
call dein#add('Townk/vim-autoclose') "カッコを自動的に閉じる
call dein#add('itchyny/lightline.vim') "vim画面下のステータスライン表示
call dein#add('scrooloose/nerdtree') "編集中のファイルを一覧表示
call dein#add('tomtom/tcomment_vim') " comment ON/OFF
call dein#add('vim-scripts/AnsiEsc.vim') "coloring log files
call dein#add('tyru/caw.vim') "comment out
call dein#add('KabbAmine/zeavim.vim') 
call dein#add('vim-latex/vim-latex')
call dein#add('lervag/vimtex')

call dein#end()

filetype plugin indent on

" if there are not-installed plugs, install them
if dein#check_install()
  call dein#install()
endif


"*************************************************************
"" Setup Plugin's detail
"*************************************************************

" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 35
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
"}}}

" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}


" Unit.vim {{{
let g:unite_enable_start_insert=1
nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" split window (horizontal)
au FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" split window (vertical)
au FileType unite nmap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
au FileType unite imap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
"ESC key 2 times --> quit
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q
" }}}


" caw.vim {{{
" \c でカーソル行をコメントアウト, \C でコメントアウトを解除
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)
" }}}



" latex setting
"if filereadable(expand('~/.vimrc.local'))
"    source ~/.vimrc.local
"endif
"=========== vim Latex ==============================
" http://adragoona.hatenablog.com/entry/2014/11/26/203044

filetype plugin on
let tex_flavor = 'latex'
set grepprg=grep\ -nH\ $*
set shellslash
let g:Tex_DefaultTargetFormat = 'pdf' 
let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'


"*************************************************************
"" Basic Setup
"*************************************************************
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8


"Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

"----- Indentation options ----
" Indentation settings for using 2 spaces instead of tabs.
" This will be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2

" Map leader to ,
let mapleader=''

"Buffer
set hidden 

"Better command-line completion
set wildmenu 

"Show partial commands in the last line of the screen
set showcmd 

" Highlight searches (use <C-L> to temporarily turn off highlighting)
set hlsearch
set incsearch
set ignorecase
set smartcase

" Directories for swp files
set nobackup
set noswapfile

" 最後のカーソル位置を復元する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


" Zeal
"<leader>z (NORMAL mode): Search for word under cursor with the docset defined automatically+.
"gz{motion} Visual mode): Search for a motion with the docset defined automatically+.
"<leader><leader>z :Narrow search with a docset+ and a query (A default docset is provided).
"nmap gzz <Plug>Zeavim
"vmap gzz <Plug>ZVVisSelection 
"nmap gz <Plug>ZVMotion         " gz{motion} (NORMAL mode)
"nmap gZ <Plug>ZVKeyDocset      " <leader><leader>z

"*************************************************************
"" Visual Settings
"*************************************************************
set t_Co=256
set cursorline
set mousemodel=popup

"Syntax highlight ON
syntax on 
"color scheme
colorscheme molokai

"solarized
"syntax enable
"set background=dark
"colorscheme solarized
"let g:solarized_termcolors=256

"Display the cursor position on the last line of the screen or in the status line of a window
set ruler
"Display line numbers on the left
set number

set autoindent

"Stop certain movements from always going to the first character of a line.
set nostartofline

"status bar
set laststatus=2

" Disable visualbell
set visualbell t_vb=
set noerrorbells "error message

"Enable use of the mouse for all modes
set mouse=a

" Copy/Paste/Cut
"set clipboard=unnamed,autoselect
set clipboard=unnamedplus

"Set the command window height to 2 lines, to avoid many cases of having to
"press <Enter> to continue
set cmdheight=2
