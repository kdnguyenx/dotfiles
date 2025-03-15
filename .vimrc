" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" open the quickfix window whenever a quickfix command is executed
autocmd QuickFixCmdPost [^l]* cwindow
" quick exit some filetypes
autocmd FileType help,qf,diff nnoremap <silent> <buffer> q :q<cr>
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
" limit command height to 1 line
set cmdheight=1
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
" dismiss highlights
nnoremap <silent> <esc> :nohlsearch<cr>
tnoremap <silent> <esc> <C-\><C-n>
" re-size split windows using arrow keys
nnoremap <up> :resize +2<cr>
nnoremap <left> :vertical resize +2<cr>
nnoremap <down> :resize -2<cr>
nnoremap <right> :vertical resize -2<cr>
" netrw
nmap - :Explore<cr>
autocmd FileType netrw nnoremap <buffer> <C-c> :Rexplore<cr>
" command mode navigation
cnoremap <C-a> <home>
cnoremap <C-e> <end>
cnoremap <C-p> <up>
cnoremap <C-n> <down>
cnoremap <C-b> <left>
cnoremap <C-f> <right>
" navigate through quickfix list
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
" navigate through loclist
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
" navigate through buffers
nnoremap ]b :bnext<cr>zz
nnoremap [b :bprev<cr>zz
" enable auto completion menu after pressing tab.
set wildmenu wildmode=full wildcharm=<C-z> wildmenu
" fuzzy find
nnoremap <leader>ff :find **/*
nnoremap <leader>fw :find **/*<C-r><C-w>
nnoremap <leader>e :e %:h<C-z>
nnoremap <leader>b :b <C-z>
nnoremap <leader>ju :jumps<cr>
nnoremap <leader>mm :marks<cr>
nnoremap <leader>gg :vimgrep //f **
vnoremap <leader>gg "0y:vimgrep /<C-r>0/f **
nnoremap <leader>gw :vimgrep /<C-r><C-w>/f **
" search current marked text
vnoremap // y/\v<C-r>=escape(@",'/\')<cr><cr>
" copy marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
" find and replace
nnoremap <leader>rr :%s/<C-r><C-w>//g<left><left>
vnoremap <leader>rr "0y:%s/<C-r>0//g<left><left>
" copy, move and remove file
nnoremap <leader>cp :!cp -r %:.<C-z> %:h<C-z>
nnoremap <leader>mv :!mv %:.<C-z> %:h<C-z>
nnoremap <leader>rm :!rm -rf %:.<C-z>
" vsplit on gf
nnoremap <silent> gf :vertical wincmd f<cr>
" set mark before gd/#/*
nnoremap <silent> gd mmgd
nnoremap <silent> # mm#
nnoremap <silent> * mm*
" use ctrl+<hjkl> to move between windows
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" basic highlights
highlight Normal cterm=NONE ctermbg=NONE
highlight NormalNC cterm=NONE ctermbg=NONE
highlight StatusLine cterm=NONE ctermbg=NONE ctermfg=grey
highlight StatusLineNC cterm=NONE ctermbg=NONE ctermfg=darkgrey
