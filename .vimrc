" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" open the quickfix window whenever a quickfix command is executed
autocmd QuickFixCmdPost [^l]* cwindow
" quick exit some filetypes
autocmd FileType help,qf,diff nnoremap <silent> <buffer> q :quit<CR>
" encoding
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8
" set the characters for the invisibles
set list listchars=tab:›\ ,nbsp:␣,eol:¬,trail:·
set signcolumn=no title
" set default regexp engine to nfa
set regexpengine=2
syntax enable
" disable temporary files.
set nobackup noswapfile wrap
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
" re-map leader key
nnoremap <space> <nop>
let g:mapleader = ' '
" basic theme
set background=dark laststatus=2
" searching
set incsearch hlsearch ignorecase smartcase matchpairs+=<:>
" re-size split windows using arrow keys
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
" netrw
nnoremap - :Explore<CR>
autocmd FileType netrw nnoremap <buffer> <C-c> :Rexplore<CR>
" command mode navigation
cnoremap <C-a> <home>
cnoremap <C-e> <end>
" navigate through quickfix list
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
" navigate through buffers
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
" enable auto completion menu after pressing tab.
set wildmenu wildmode=full wildcharm=<C-z> wildmenu
" find files
nnoremap <leader>e :e %:h<C-z><C-z>
nnoremap <leader>b :b <C-z>
nnoremap <leader>g :vimgrep //f **<S-Left><S-Left><Right>
vnoremap <leader>g "0y:vimgrep /<C-r>=escape(@0,'/\')<CR>/f **<S-Left><Left><Left><Left>
nnoremap <leader>/ :vimgrep /<C-r><C-w>/f **
nnoremap <leader>ma :marks<CR>
" search current marked text
vnoremap // "0y/\V<C-r>=escape(@0,'/\')<CR><CR>
" find and replace
nnoremap <leader>rr :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <leader>rr "0y:%s/<C-r>=escape(@0,'/\')<CR>//gI<Left><Left><Left>
" unix commands
nnoremap <leader>cp :!cp -r %<C-z> %:h<C-z>
nnoremap <leader>mv :!mv %<C-z> %:h<C-z>
nnoremap <leader>rm :!rm -rf %<C-z>
" set mark before gd/#/*
nnoremap <silent> gd mMgd
nnoremap <silent> # mM#
nnoremap <silent> * mM*
" basic highlights
highlight StatusLine cterm=NONE ctermbg=NONE ctermfg=grey
highlight StatusLineNC cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight Normal cterm=NONE ctermbg=NONE guibg=NONE
highlight NormalNC cterm=NONE ctermbg=NONE guibg=NONE
highlight VertSplit ctermbg=NONE ctermfg=darkgrey
