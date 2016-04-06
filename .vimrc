"*****************************************************************************
"" NeoBundle core
"*****************************************************************************
set nocompatible               " be iMproved 
filetype off


if has('vim_starting')
    " neobundle をインストールしていない場合は自動インストール
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install neobundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'


"============ NeoBundle プラグイン設定 ================================================

" originalrepos on github
" VIM Color
" solarized
NeoBundle 'altercation/vim-colors-solarized'
" molokai
NeoBundle 'tomasr/molokai'




"カッコを自動的に閉じる
NeoBundle 'Townk/vim-autoclose'

"if等の終了宣言を自動挿入
NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}


"ファイルオープン/ ランチャー、ファイラー
"https://github.com/Shougo/unite.vim
NeoBundle 'Shougo/unite.vim'
"NeoBundle 'ujihisa/unite-colorscheme'
" ファイル履歴を記録
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }

""""""""""""""""""""""""""""""""""""""""""""""
" Unit.vim setting 
""""""""""""""""""""""""""""""""""""""""""""""
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
"""""""""""""""""""""""""""""""""""""""""""""""



"vimからシェルを使えるようになる
NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}

" vimshell {{{
nmap <silent> vs :<C-u>VimShell<CR>
nmap <silent> vp :<C-u>VimShellPop<CR>
" }}}


"Vim に非同期処理
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }


" Neocomplete 補完機能 luaが無いと動かない
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif

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


""""""""""""""""""""""""""""""""""""""""""""""
" Quickrun setting 
" 以下のサイト良い：
" quickrunで部分コンパイル:  http://auewe.hatenablog.com/entry/2013/12/25/033416
" quickrunの詳細： http://d.hatena.ne.jp/osyo-manga/20130311/1363012363
""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'thinca/vim-quickrun'
"quickrun default config
"https://github.com/thinca/vim-quickrun/blob/637aa0f9eab485874eb3606be35586735855d880/autoload/quickrun.vim#L16

" runner/vimproc/updatetime で出力バッファの更新間隔をミリ秒で設定可能
" vimproc をかませていることで非同期処理を実現
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc", 
\       "runner/vimproc/updatetime" : 60
\   }
\}

" <C-c> で実行を強制終了させる
" quickrun.vim が実行していない場合には <C-c> を呼び出す
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"ヤンク履歴を保持
NeoBundle 'LeafCage/yankround.vim'
" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 35
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
"}}}


"vim画面下のステータスライン表示
"詳細設定--> https://github.com/itchyny/lightline.vim
NeoBundle 'itchyny/lightline.vim'

"編集中のファイルを一覧表示
NeoBundle 'scrooloose/nerdtree'
"スニペット
"NeoBundle 'Shougo/neosnippet'

" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" ログファイルを色づけしてくれる
NeoBundle 'vim-scripts/AnsiEsc.vim'


"==================シンタックスチェック======================
"syntaxチェックを行ってくれる、複数言語対応
NeoBundle 'scrooloose/syntastic'
let g:syntastic_check_on_open=0 "ファイルを開いたときはチェックしない
let g:syntastic_check_on_save=1 "保存時にはチェック
let g:syntastic_check_on_wq = 0 " wqではチェックしない
let g:syntastic_auto_loc_list=1 "エラーがあったら自動でロケーションリストを開く
let g:syntastic_loc_list_height=6 "エラー表示ウィンドウの高さ
set statusline+=%#warningmsg# "エラーメッセージの書式
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:syntastic_mode_map = {
"      \ 'mode': 'active',
"      \ 'active_filetypes': ['javascript'],
"      \ 'passive_filetypes': []
"      \ }


" コメントアウトを切り替えるマッピング
NeoBundle "tyru/caw.vim"
" \c でカーソル行をコメントアウト
" 再度 \c でコメントアウトを解除
" 選択してから複数行の \c も可能
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
" \C でコメントアウトの解除
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)


" latex setting
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"NeoBundle "Valloric/YouCompleteMe"
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" javascript IDE-like 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" " https://gist.github.com/Layzie/4587591
" "gf でrequire()のモジュールにジャンプ
" NeoBundle 'moll/vim-node'
"
" "JSの補完
" NeoBundle 'mattn/jscomplete-vim'
"
" "javascriptの補完
" "NeoBundle 'marijnh/tern_for_vim', {
" "  \ 'build': {
" "  \   'others': 'npm install'
" "  \}}
"
" " DOMとMozilla関連とES6のメソッドを補完
" let g:jscomplete_use = ['dom', 'moz', 'es6th']
" :setl omnifunc=jscomplete#CompleteJS
"
" " jQueryのためのシンタックス
" au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
"
" "node.jsの補完
" NeoBundle 'myhere/vim-nodejs-complete'
"
"
"
" "jsのインデント・シンタックスカラー
" NeoBundle 'pangloss/vim-javascript'
" :setl omnifunc=jscomplete#CompleteJS
" if !exists('g:neocomplcache_omni_functions')
"   let g:neocomplcache_omni_functions = {}
" endif
" let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
" let g:node_usejscomplete = 1
" 
" autocmd FileType javascript :setl omnifunc=jscomplete#CompleteJS
"
" 
" NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
" 
" let g:syntastic_enable_signs=1
" let g:syntastic_auto_loc_list=2
" "let g:syntastic_javascript_checker = 'jshint'
" let g:syntastic_javascript_checkers = ['eslint'] "ESLintを使う
" 
" " ドキュメントジェネレータ
" NeoBundle 'heavenshell/vim-jsdoc'
"
" "node 用の辞書を追加。C-x C-k で補完。
" NeoBundle 'guileen/vim-node-dict'
" au FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node-dict/dict/node.dict
"
"
" "plugin for TypeScript autocompletion/syntax
" "NeoBundle 'Quramy/tsuquyomi'  (url: https://github.com/Quramy/tsuquyomi)
" NeoBundle 'https://github.com/leafgarland/typescript-vim.git'
" NeoBundle 'https://github.com/clausreinke/typescript-tools.vim'
" au BufRead,BufNewFile *.ts        setlocal filetype=typescript
" set rtp+=$HOME/.vim/bundle/typescript-tools.vim/
" let g:TSS = ['nodejs','$HOME/.anyenv/envs/ndenv/versions/v4.2.4/bin/tss']
"
"
" "Syntax file for JavaScript libraries
" NeoBundle 'https://github.com/othree/javascript-libraries-syntax.vim.git'
" let g:used_javascript_libs='jquery,backbone,angularjs,react,requirejs,jasmine'
" "Support libs
" "id:jquery,underscore,backbone,prelude,angularjs,angularui,angularuirouter,react,flux,requirejs,sugar,jasmine,chai,handlebars
"
"
" "AngularJS で htmlに書いた時のエラーチェック回避
""let g:syntastic_html_tidy_ignore_errors=['proprietary attribute "ng-']
"
"
""JSX syntax "https://github.com/mxw/vim-jsx
" NeoBundle 'https://github.com/mxw/vim-jsx.git'
" let g:jsx_ext_required = 0
"
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other Language
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Rails basic
" NeoBundle 'tpope/vim-rails'
" Rails auto-insert - end - 
" NeoBundle 'tpope/vim-endwise'


" rsense
"NeoBundle 'NigoroJr/rsense'
"NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', {
"    \ 'autoload' : { 'insert' : 1, 'filetype' : 'ruby', } }

" 補完の設定 neocomplete.vimで.や::を入力したときにオムニ補完が有効に
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

"let g:rsenseUseOmniFunc = 1

"================== /neobundle設定 ==================================================
filetype plugin on
filetype plugin indent on     " required!

" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck

call neobundle#end()




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
