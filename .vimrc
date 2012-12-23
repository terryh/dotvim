set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
Bundle 'gmarik/vundle'

Bundle 'ervandew/supertab.git'
Bundle 'tpope/vim-surround.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'scrooloose/nerdtree.git'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"

Bundle 'tpope/vim-fugitive.git'
Bundle 'mattn/zencoding-vim.git'
Bundle 'majutsushi/tagbar.git'
"Bundle 'Raimondi/delimitMate.git'
Bundle 'Lokaltog/vim-easymotion.git'
Bundle 'hallettj/jslint.vim.git'
Bundle 'godlygeek/tabular.git'
Bundle 'Lokaltog/vim-powerline.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'edsono/vim-matchit.git'
Bundle 'tpope/vim-ragtag.git'
Bundle 'spf13/vim-autoclose'

Bundle 'spf13/PIV.git'
Bundle 'vim-scripts/javacomplete.git'
Bundle 'rosstimson/scala-vim-support.git'
Bundle 'jnwhiteh/vim-golang.git'
" exact to pyflakes-vim/ftplugin/python
" https://github.com/kevinw/pyflakes/zipball/master
Bundle 'kevinw/pyflakes-vim.git'

Bundle 'scrooloose/syntastic.git'
" vim-scripts repos

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
set completeopt=longest,menuone

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

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 
autocmd FileType python set ft=python.django
autocmd Filetype java setlocal omnifunc=javacomplete#Complete
autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo

"-------------------------------------------------------------------------------
" Keyboard ShortCuts
"-------------------------------------------------------------------------------
" helper style for team member
autocmd FileType python inoremap <buffer> $f ######################################################<cr># <esc>a
autocmd FileType python inoremap <buffer> $c #--- PH ----------------------------------------------<esc>FP2xi


" clean up all html tags
nmap <F7> <ESC>:%s/<[^>]*>//g

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

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

" bind tab like  next buffer, C+tab don't work
nmap <C-X> <ESC>:bn<CR>


" Tabular
"let mapleader=','
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction



" buftabs.vim
map <C-LEFT> <ESC>:bp<CR>
map <C-RIGHT> <ESC>:bn<CR>

" jslint
nmap <leader>j   :JSLintUpdate<CR>

" close tag, cause  
" iabbrev </ </<C-X><C-O>
