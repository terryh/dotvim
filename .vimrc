set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
Bundle 'gmarik/vundle'

Bundle 'rvandew/supertab.git'
Bundle 'tpope/vim-surround.git'
Bundle 'msanders/snipmate.vim.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'sukima/xmledit.git'
Bundle 'sjl/gundo.vim.git'

" exact to pyflakes-vim/ftplugin/python
" https://github.com/kevinw/pyflakes/zipball/master
Bundle 'kevinw/pyflakes-vim.git'

Bundle 'tpope/vim-fugitive.git'
Bundle 'mattn/zencoding-vim.git'
Bundle 'vim-scripts/javacomplete.git'
Bundle 'majutsushi/tagbar.git'
Bundle 'rosstimson/scala-vim-support.git'
Bundle 'Raimondi/delimitMate.git'
Bundle 'xolox/vim-easytags.git'
Bundle 'Lokaltog/vim-easymotion.git'
Bundle 'hallettj/jslint.vim.git'
Bundle 'godlygeek/tabular.git'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'

"-------------------------------------------------------------------------------
" VimTip382: Search for <cword> and replace with input() in all open buffers 
"-------------------------------------------------------------------------------
fun! Replace() 
    let s:word = input("Replace " . expand('<cword>') . " with:") 
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
    :unlet! s:word 
endfun
"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

"-------------------------------------------------------------------------------
" VimTip1008 
"-------------------------------------------------------------------------------
fun! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfun
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
nnoremap <leader>q :QFix<CR>

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

set autoindent
set copyindent      " copy the previous indentation on autoindenting
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab        " insert tabs on the start of a line according to context
set smartindent
set number
set noswapfile
set hlsearch        " search highlighting
set incsearch       " highlight after each input
set autoread        " auto read when file is changed from outside
set hid             " change buffer
set ruler
set nofoldenable    " disable folding

"-------------------------------------------------------------------------------
" Tab
set expandtab       " replace <TAB> with spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4 
autocmd BufRead,BufNewFile ?akefile* set noexpandtab
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Color & Font
"-------------------------------------------------------------------------------
"colors ron
set t_Co=256
set background=dark
hi CursorLine   guifg=NONE guibg=#121212 gui=NONE ctermfg=NONE ctermbg=234  cterm=BOLD
hi CursorColumn guifg=NONE guibg=#121212 gui=NONE ctermfg=NONE ctermbg=NONE cterm=BOLD

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&fileformat}]\ [ENCODE=%{&encoding}]
set statusline+=\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set cursorline

if has('gui_running')
    set guioptions-=T  " no toolbar
    set guifont=DejaVu\ Sans\ Mono\ 10
    colors ron
endif

set list "show tab and end of line
set listchars=tab:>-
set ffs=unix
set ff=unix
set mouse=a
syntax on
filetype on
filetype plugin on

"-------------------------------------------------------------------------------
" Encoding
"-------------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

func! ViewUTF8()
    set encoding=utf-8
    set termencoding=big5
endfunc

func! UTF8()
    set encoding=utf-8
    set termencoding=big5
    set fileencoding=utf-8
    set fileencodings=ucs-bom,big5,utf-8,latin1
endfunc

func! Big5()
    set encoding=big5
    set fileencoding=big5
endfunc

" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

"-------------------------------------------------------------------------------
" Keyboard ShortCuts
"-------------------------------------------------------------------------------
" helper style for team member
autocmd FileType python inoremap <buffer> $f ######################################################<cr># <esc>a
autocmd FileType python inoremap <buffer> $c #--- PH ----------------------------------------------<esc>FP2xi

" Django http://code.djangoproject.com/wiki/UsingVimWithDjango
let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"

" clean up all html tags
nmap <F7> <ESC>:%s/<[^>]*>//g

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Writing Restructured Text (Sphinx Documentation) {
   " Ctrl-u 1:    underline Parts w/ #'s
   noremap  <C-u>1 yyPVr#yyjp
   inoremap <C-u>1 <esc>yyPVr#yyjpA
   " Ctrl-u 2:    underline Chapters w/ *'s
   noremap  <C-u>2 yyPVr*yyjp
   inoremap <C-u>2 <esc>yyPVr*yyjpA
   " Ctrl-u 3:    underline Section Level 1 w/ ='s
   noremap  <C-u>3 yypVr=
   inoremap <C-u>3 <esc>yypVr=A
   " Ctrl-u 4:    underline Section Level 2 w/ -'s
   noremap  <C-u>4 yypVr-
   inoremap <C-u>4 <esc>yypVr-A
   " Ctrl-u 5:    underline Section Level 3 w/ ^'s
   noremap  <C-u>5 yypVr^
   inoremap <C-u>5 <esc>yypVr^A
"}

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

" Tagbar
nmap <F12> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" --- SuperTab
let g:SuperTabDefaultCompletionType = "context"

" NERDTree
nmap <F9> :NERDTreeToggle<CR>
"let NERDTreeWinPos = "left"

"Fuzzyfinder
nmap ff :FufFile<CR>
" bind tab like  next buffer, C+tab don't work
nmap <C-X> <ESC>:bn<CR>

" buftabs.vim
map <C-LEFT> <ESC>:bp<CR>
map <C-RIGHT> <ESC>:bn<CR>

" avoid easytags complain  miniBufexpl set this to 300
" let g:easytags_updatetime_min=300
let g:easytags_updatetime_autodisable=1

" Gundo
nnoremap <F5> :GundoToggle<CR>

" jslint
nmap <leader>j   :JSLintUpdate<CR>
