" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" open the quickfix window whenever a quickfix command is executed
autocmd quickfixcmdpost [^l]* cwindow
" quick exit some filetypes
autocmd filetype help,qf,diff nnoremap <silent> <buffer> q :q<cr>
" encoding
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8
" set the characters for the invisibles
set list listchars=tab:⇀\ ,eol:¬,nbsp:␣,trail:⋅ showbreak=↪
set signcolumn=no colorcolumn=80 sidescrolloff=10 title
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
set nostartofline cursorline
set ttyfast history=10000
set background=dark laststatus=2
" re-map leader key
nnoremap <space> <nop>
let g:mapleader = ' '
" searching
set incsearch hlsearch ignorecase smartcase matchpairs+=<:>
" dismiss highlights
nnoremap <silent> <esc> :nohlsearch<cr>
tnoremap <silent> <esc> <c-\><c-n>
" re-size split windows using arrow keys
nnoremap <up> :resize +2<cr>
nnoremap <left> :vertical resize +2<cr>
nnoremap <down> :resize -2<cr>
nnoremap <right> :vertical resize -2<cr>
" command mode navigation
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
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
set wildmenu wildmode=full wildcharm=<c-z> wildmenu
" fuzzy find
nnoremap <leader>ff :find **/*
nnoremap <leader>fw :find **/*<c-r><c-w>
nnoremap <leader>e :e %:h<c-z>
nnoremap <leader>b :b <c-z>
nnoremap <leader>ju :jumps<cr>
nnoremap <leader>mm :marks<cr>
nnoremap <leader>gg :vimgrep //f **
vnoremap <leader>gg "0y:vimgrep /<c-r>0/f **
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
" run ctags in the background
if executable('ctags')
  function! s:generate_tags() abort
    let l:cmd = ['ctags', '--tag-relative=never', '-G', '-R', '.']
    let l:job = job_start(l:cmd, {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    echo 'generate tags..., status: ' . job_status(l:job)
  endfunction
  nnoremap <leader>tg :call <sid>generate_tags()<cr>
else
  echo 'no ctags installation found'
endif
" vsplit on gf
nnoremap <silent> gf :vertical wincmd f<cr>
" set mark before gd/#/*
nnoremap <silent> gd mmgd
nnoremap <silent> # mm#
nnoremap <silent> * mm*
" use ctrl+<hjkl> to move between windows
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l
" basic highlights
highlight normal cterm=NONE ctermbg=NONE
highlight normalnc cterm=NONE ctermbg=NONE
highlight statusline cterm=NONE ctermbg=NONE ctermfg=grey
highlight statuslinenc cterm=NONE ctermbg=NONE ctermfg=darkgrey
" netrw search text hl
highlight link netrwmarkfile search
nmap - :Explore<cr>
autocmd filetype netrw nnoremap <buffer> <c-c> :Rexplore<cr>
