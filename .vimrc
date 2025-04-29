" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" open the quickfix window whenever a quickfix command is executed
autocmd QuickFixCmdPost [^l]* cwindow
" quick exit some filetypes
autocmd FileType help,qf,diff,fugitive,fugitiveblame nnoremap <silent> <buffer> q :quit<CR>
" encoding
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8
" set the characters for the invisibles
set list listchars=tab:›\ ,nbsp:␣,trail:· showbreak=¬
set sidescrolloff=10 title
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
" undodir
set undodir=~/.vim/undodir undofile
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
" plugins
call plug#begin()
" make sure you use single quotes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
Plug 'vimwiki/vimwiki'
Plug 'rose-pine/vim', { 'as': 'rose-pine' }
call plug#end()
" basic theme
set background=dark laststatus=2
set termguicolors
silent! colorscheme rosepine_moon
" searching
set incsearch hlsearch ignorecase smartcase matchpairs+=<:>
" run ctags
if executable('ctags')
  function! s:generate_tags() abort
    let l:cmd = ['ctags', '--tag-relative=never', '-G', '-R', '.']
    let l:job = job_start(l:cmd, {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    echo 'generate tags..., status: ' . job_status(l:job)
  endfunction
  nnoremap <leader>tg :call <SID>generate_tags()<CR>
else
  echo 'no ctags installation found'
endif
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
" dismiss highlight -
nnoremap <Esc> :nohlsearch<CR>
" navigate through quickfix list
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
" navigate through buffers
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
" move selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" enable auto completion menu after pressing tab.
set wildmenu wildmode=full wildcharm=<C-z> wildmenu
" wildoptions -
set wildoptions=pum,tagfile
" wildignore -
set wildignore=*.o,*~,*.a,*.so,*.pyc,*.swp,*.class
set wildignore+=*/target/*,*/build/*,*/generated-sources/*
set wildignore+=*/__pycache__/*,*/node_modules/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.vscode/*
if has('mac')
  set wildignore+=*/Library/*
  set wildignore+=*/.DS_Store
endif
" search current marked text
vnoremap // "0y/\V<C-r>=escape(@0,'/\')<CR><CR>
vnoremap <leader>/ "0y/\V<C-r>='<'.escape(@0,'/\').'>'<CR><CR>
" fuzzy find
nnoremap <leader>f :find **/*
nnoremap <leader>F :find **/*<C-r><C-w><CR>
nnoremap <leader>e :e %:h<C-z>
nnoremap <leader>b :b <C-z>
nnoremap <leader>ma :marks<CR>
nnoremap <leader>g :vimgrep //f **<S-Left><S-Left><Right>
vnoremap <leader>g "0y:vimgrep /<C-r>=escape(@0,'/\')<CR>/f **<S-Left><Left><Left><Left>
nnoremap <leader>G :vimgrep /<C-r><C-w>/f **
" ripgrep -
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading\ --column
  set grepformat^=%f:%l:%c:%m
  nnoremap <leader>g :silent grep! '' \| redraw!<S-Left><S-Left><Left><Left>
  vnoremap <leader>g "0y:silent grep! --case-sensitive '<C-r>0' \| redraw!<S-Left><S-Left><Left><Left>
  nnoremap <leader>G :silent grep! --case-sensitive '<C-r><C-w>' \| redraw!<CR>
  nnoremap <leader>/ :silent grep! --hidden --no-ignore '' \| redraw!<S-Left><S-Left><Left><Left>
endif
" copy marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
" find and replace
nnoremap <leader>r :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <leader>r "0y:%s/<C-r>=escape(@0,'/\')<CR>//gI<Left><Left><Left>
" unix command
nnoremap <leader>cp :!cp -r %<C-z> %:h<C-z>
nnoremap <leader>mv :!mv %<C-z> %:h<C-z>
" set mark before gd/#/*
nnoremap <silent> gd mMgd
nnoremap <silent> # mM#
nnoremap <silent> * mM*
" indentation by ft
autocmd FileType python setl sw=4 ts=4 sts=4 et fp=black\ --quiet\ -
autocmd FileType go setl sw=4 ts=4 sts=4 noet fp=gofmt
autocmd FileType javascript,typescript setl sw=2 ts=2 sts=2 et
autocmd FileType json setl sw=4 ts=4 sts=4 et fp=jq
" c, c++
augroup clang_opts
  au!
  au FileType c,cpp setl sw=4 ts=4 sts=4 et
  " c/c++ makeprg, work with :make command
  au FileType c,cpp setl makeprg=cd\ build\ &&\ cmake\ -DCMAKE_BUILD_TYPE=debug\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1\ -G\ Ninja\ ..\ &&\ ninja
  if has('mac') && executable('xcrun')
    let sdk_path = substitute(system('xcrun --show-sdk-path'), '\n', '', '')
    au FileType c,cpp execute 'setl path+=' . sdk_path . '/usr/include'
    au FileType c,cpp execute 'setl path+=' . sdk_path . '/usr/include/c++/v1'
  endif
augroup END
"java
augroup java_opts
  au!
  au FileType java setl sw=4 ts=4 sts=4 et
  au FileType java setl makeprg=mvn\ clean\ install\ -T\ 5
  au FileType java setl includeexpr=substitute(v:fname,'\\.','/','g')
  au FileType java setl errorformat=[ERROR]\ %f:[%l\\,%v]\ %m
  au FileType java setl path+=src/main/java/**
  au FileType java setl path+=src/main/test/**
  au FileType java setl path+=**/src/main/java/**
  au FileType java setl path+=**/src/main/test/**
augroup END
" highlighted yank -
let g:highlightedyank_highlight_duration = 50
" fzf -
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,41%,<70(up,41%)']
let g:fzf_layout = { 'down': '41%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
nnoremap <leader>f :Files<CR>
nnoremap <leader>F :GFiles<CR>
nnoremap <leader>ma :Marks<CR>
" vimwiki -
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {}
" basic highlights
highlight StatusLine cterm=NONE ctermbg=NONE ctermfg=grey
highlight StatusLineNC cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight Normal cterm=NONE ctermbg=NONE guibg=NONE
highlight NormalNC cterm=NONE ctermbg=NONE guibg=NONE
highlight VertSplit cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight! link SignColumn LineNr
