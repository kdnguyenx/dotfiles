set regexpengine=2  " set default regexp engine to nfa
set noswapfile  " do not use swapfile for buffer
set showmatch  " show matching brackets
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab shiftround  " set default indentation
set splitbelow splitright  " preferred split behaviour
set updatetime=100  " reduce update time for faster response
set cursorline  " highlight the text line of the cursor
set undofile  " enable undo history
set title  " set the window title
set visualbell  " use visual bell instead of beeping
set ignorecase  " ignore case in search patterns
set smartcase  " override the 'ignorecase' option if the search pattern contains upper case characters
set matchpairs+=<:>  " additional character that form pairs
set list  " enable list mode that set the characters for the invisibles
let &showbreak='+++ '  " string to put at the start of lines that have been wrapped

" re-map leader key
nnoremap <Space> <Nop>
let g:mapleader = ' '

" plugins, make sure you use single quotes
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
call plug#end()

" re-size split windows using arrow keys
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

" find files
nnoremap <Leader>e :e %:h<C-z>
nnoremap <Leader>b :b <C-z>
vnoremap // "0y/\V<C-r>=escape(@0,'/\')<CR><CR>

" program to use for the :grep command
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading\ --column
  set grepformat^=%f:%l:%c:%m
  nn <Leader>g :silent grep! ''<Left>
  vn <Leader>g "0y:silent grep! --case-sensitive '<C-r>0'<Left>
  nn <Leader>G :silent grep! --case-sensitive '<C-r><C-w>'<CR>
  nn <Leader>/ :silent grep! --hidden --no-ignore ''<Left>
endif

" find and replace
nn <Leader>r :%s/<C-r><C-w>//gI<Left><Left><Left>
vn <Leader>r "0y:%s/<C-r>=escape(@0,'/\')<CR>//gI<Left><Left><Left>

" yank marked text/paste to/from global register
nnoremap <Leader>Y "+Y
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p

" quick exit some filetypes
au FileType help,qf,checkhealth,fugitive,fugitiveblame nn <silent> <buffer> q :quit<CR>
au QuickFixCmdPost [^l]* cwindow  " open the quickfix window whenever a quickfix command is executed
au TextYankPost * silent! lua vim.hl.on_yank { higroup="IncSearch", timeout=100 }

" clear highlights on search when pressing <esc> in normal mode
nnoremap <silent> <Esc> <Cmd>nohlsearch<CR>
nnoremap - <Cmd>Explore<CR>
autocmd FileType netrw nnoremap <buffer> <C-c> <Cmd>Rexplore<CR>

" indent by filetype
au FileType c,cpp,java,lua,python setl sw=4 ts=4 sts=4 et
au FileType go setl sw=4 ts=4 sts=4 noet
au FileType json setl sw=4 ts=4 sts=4 formatprg=jq et
au FileType javascript,typescript setl sw=2 ts=2 sts=2 et

" custom fzf
let g:fzf_layout = { 'down': '41%' }
let g:fzf_vim = { 'preview_window': [ 'right,41%,<70(up,41%)' ] }
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
nnoremap <Leader>f <Cmd>Files<CR>
nnoremap <Leader>F :let @+=expand('<cword>') \| Files<CR>

" enable experimental tui
lua require"vim._extui".enable { enable = true, msg = { target = "cmd" } }

set termguicolors  " enable 24-bit RGB color
lua require"rose-pine".setup { dark_variant = 'moon', styles = { italic = false } }
silent! colorscheme rose-pine
hi Normal ctermbg=NONE guibg=NONE
hi NormalNC ctermbg=NONE guibg=NONE

" load lua modules
lua require"lsp"
lua require"utils"
