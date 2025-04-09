" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" open the quickfix window whenever a quickfix command is executed
autocmd quickfixcmdpost [^l]* cwindow
" quick exit some filetypes
autocmd filetype help,qf,diff nnoremap <silent> <buffer> q :quit<cr>
" encoding
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8
" set the characters for the invisibles
set list listchars=tab:⇀\ ,eol:¬,nbsp:␣,trail:⋅ showbreak=↪
set signcolumn=no sidescrolloff=10 title
" set default regexp engine to nfa
set regexpengine=2
syntax enable
" disable temporary files.
set nobackup noswapfile nowrap
" detect filetype
filetype on
filetype indent on
" set default indentation
set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 shiftround
" auto read file change
set autoread autoindent
" scan to put in completion
set complete=.,w,b,u,t completeopt=menu,preview
" sequence of letters which describes how automatic formatting is to be done
set formatoptions=tcqj
" split behaviour
set splitbelow splitright
" allow backspacing over listed items
set backspace=indent,eol,start
set visualbell
" add numbers to each line on the left-hand side.
set number relativenumber ruler hidden
set nopaste
" this option controls the behavior when switching between buffers
set switchbuf=uselast
" show several useful info
set showcmd showmode showmatch
set mouse=a mousemodel=popup_setpos
" the cursor is kept in the same column
set nostartofline
set ttyfast history=10000
set background=dark laststatus=2
" re-map leader key
nnoremap <space> <nop>
let g:mapleader = ' '
" searching
set incsearch hlsearch ignorecase smartcase matchpairs+=<:>
" re-size split windows using arrow keys
nnoremap <up> :resize +5<cr>
nnoremap <down> :resize -5<cr>
nnoremap <left> :vertical resize -5<cr>
nnoremap <right> :vertical resize +5<cr>
" netrw
nnoremap - :Explore<cr>
autocmd filetype netrw nnoremap <buffer> <c-c> :Rexplore<cr>
" command mode navigation
cnoremap <c-a> <home>
cnoremap <c-e> <end>
" navigate through quickfix list
nnoremap <c-j> :cnext<cr>zz
nnoremap <c-k> :cprev<cr>zz
" navigate through buffers
nnoremap <c-l> :bnext<cr>
nnoremap <c-h> :bprev<cr>
" enable auto completion menu after pressing tab.
set wildmenu wildmode=full wildcharm=<c-z> wildmenu
" fuzzy find
nnoremap <leader>f :find **/*
nnoremap <leader>F :find **/*<c-r><c-w><cr>
nnoremap <leader>e :e %:h<c-z>
nnoremap <leader>b :b <c-z>
nnoremap <leader>ma :marks<cr>
nnoremap <leader>g :vimgrep //f **<s-left><s-left><right>
vnoremap <leader>g "0y:vimgrep /<c-r>0/f **<s-left><left><left><left>
nnoremap <leader>G :vimgrep /<c-r><c-w>/f **
" search current marked text
vnoremap // y/\v<c-r>=escape(@",'/\')<cr><cr>
" copy marked text/paste to/from global register
vnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>P "*P
vnoremap <leader>p "*p
" find and replace
nnoremap <leader>r :%s/<c-r><c-w>//gI<left><left><left>
vnoremap <leader>r "0y:%s/<c-r>0//gI<left><left><left>
" unix command
nnoremap <leader>cp :!cp -r %<c-z> %:h<c-z>
nnoremap <leader>mv :!mv %<c-z> %:h<c-z>
" set mark before gd/#/*
nnoremap <silent> gd mMgd
nnoremap <silent> # mM#
nnoremap <silent> * mM*
" basic highlights
highlight statusline cterm=NONE ctermbg=NONE ctermfg=grey
highlight statuslinenc cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight normal cterm=NONE ctermbg=NONE
highlight normalnc cterm=NONE ctermbg=NONE
highlight vertsplit cterm=NONE ctermbg=NONE ctermfg=darkgrey
