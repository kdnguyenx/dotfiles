set nocompatible  " disable compatibility with vi which can cause unexpected issues
set regexpengine=2  " set default regexp engine to nfa
set noswapfile  " do not use swapfile for buffer
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab shiftround  " set default indentation
set showmatch  " show matching brackets
set splitbelow splitright  " preferred split behaviour
set updatetime=100  " reduce update time for faster response
set cursorline  " highlight the text line of the cursor
set inccommand=split  " shows effects of substitute and other commands
set undofile  " enable undo history
set title  " set the window title
set visualbell  " use visual bell instead of beeping
set smartcase  " override the 'ignorecase' option if the search pattern contains upper case characters
set matchpairs+=<:>  " additional character that form pairs
set background=dark  " dark bg
set autoread  " auto read file change and indentation
set autoindent  " auto copy indent
set incsearch  " show matches when typing
set hlsearch  " highlight all matches
set wildmenu  " enable auto completion menu after pressing tab.
set history=10000  " max history
set list  " enable list mode that set the characters for the invisibles
set lcs=tab:>\ ,trail:-,nbsp:+  " set the characters for the invisibles
let &showbreak='+++ '  " string to put at the start of lines that have been wrapped
" re-map leader key
nnoremap <Space> <Nop>
let g:mapleader = ' '
" resize window using arrow keys
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
" command mode navigation
cnoremap <C-a> <home>
cnoremap <C-e> <end>
" navigate through quickfix list or buffers
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
" basic find files and grep
nnoremap <leader>e :e %:h<C-z><C-z>
nnoremap <leader>b :b <C-z>
nnoremap <leader>gg :vimgrep //f **<S-Left><S-Left><Right>
vnoremap <leader>gg "0y:vimgrep /<C-r>=escape(@0,'/\')<CR>/f **<S-Left><Left><Left><Left>
nnoremap <leader>gw :vimgrep /<C-r><C-w>/f **
vnoremap // "0y/\V<C-r>=escape(@0,'/\')<CR><CR>
" find and replace
nnoremap <leader>rr :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <leader>rr "0y:%s/<C-r>=escape(@0,'/\')<CR>//gI<Left><Left><Left>
" yank marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
