" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" open the quickfix window whenever a quickfix command is executed
autocmd quickfixcmdpost [^l]* cwindow
" quick exit some filetypes
autocmd filetype help,qf,diff nnoremap <silent> <buffer> q :quit<cr>
" encoding
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8
" set the characters for the invisibles
set list listchars=tab:⇀\ ,eol:¬,nbsp:␣,trail:⋅
set showbreak=↪
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
set complete=.,w,b,u,t
" sequence of letters which describes how automatic formatting is to be done
set formatoptions=tcqj
" split behaviour
set splitbelow splitright
" allow backspacing over listed items
set backspace=indent,eol,start
set visualbell
" add numbers to each line on the left-hand side.
set number relativenumber ruler hidden
set nopaste completeopt=menu,preview
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
nnoremap <up> :resize +2<cr>
nnoremap <left> :vertical resize +2<cr>
nnoremap <down> :resize -2<cr>
nnoremap <right> :vertical resize -2<cr>
" netrw
nmap - :Explore<cr>
autocmd filetype netrw nnoremap <buffer> <c-c> :Rexplore<cr>
" command mode navigation
cnoremap <c-a> <home>
cnoremap <c-e> <end>
" navigate through quickfix list
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
" navigate through loclist
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>
" navigate through buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
" enable auto completion menu after pressing tab.
set wildmenu wildmode=full wildcharm=<c-z> wildmenu
" fuzzy find
nnoremap <leader>f :find **/*
nnoremap <leader>e :e %:h<c-z>
nnoremap <leader>b :b <c-z>
nnoremap <leader>ju :jumps<cr>
nnoremap <leader>mm :marks<cr>
nnoremap <leader>gg :vimgrep //f **<s-left><s-left><right>
vnoremap <leader>gg "0y:vimgrep /<c-r>0/f **<s-left><left><left><left>
nnoremap <leader>gw :vimgrep /<c-r><c-w>/f **
" search current marked text
vnoremap // y/\v<c-r>=escape(@",'/\')<cr><cr>
" copy marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
" find and replace
nnoremap <leader>rr :%s/<c-r><c-w>//g<left><left>
vnoremap <leader>rr "0y:%s/<c-r>0//g<left><left>
" copy, move and remove file
nnoremap <leader>cp :!cp -r %:.<c-z> %:h<c-z>
nnoremap <leader>mv :!mv %:.<c-z> %:h<c-z>
nnoremap <leader>rm :!rm -rf %:.<c-z>
" vsplit on gf
nnoremap <silent> gf :vertical wincmd f<cr>
" set mark before gd/#/*
nnoremap <silent> gd mMgd
nnoremap <silent> # mM#
nnoremap <silent> * mM*
" use ctrl+<hjkl> to move between windows
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l
" basic highlights
highlight StatusLine cterm=NONE ctermbg=NONE ctermfg=grey
highlight StatusLineNC cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight Normal cterm=NONE ctermbg=NONE
highlight NormalNC cterm=NONE ctermbg=NONE
highlight VertSplit cterm=NONE ctermbg=NONE ctermfg=darkgrey
