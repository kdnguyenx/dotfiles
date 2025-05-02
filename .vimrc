vim9script
# disable compatibility with vi which can cause unexpected issues.
set nocompatible
# open the quickfix window whenever a quickfix command is executed
autocmd QuickFixCmdPost [^l]* cwindow
# quick exit some filetypes
autocmd FileType help,qf,diff,fugitive,fugitiveblame,lspgfm nnoremap <silent> <buffer> q :quit<CR>
# encoding
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8
# set the characters for the invisibles
set list listchars=tab:›\ ,nbsp:␣,trail:· showbreak=¬
set sidescrolloff=10 title
# set default regexp engine to nfa
set regexpengine=2
syntax enable
# disable temporary files.
set nobackup noswapfile nowrap
# detect filetype
filetype on
filetype indent on
# set default indentation
set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 shiftround
# auto read file change
set autoread autoindent
# scan to put in completion
set complete=.,w,b,u,t completeopt=menu,preview
# sequence of letters which describes how automatic formatting is to be done
set formatoptions=tcqj
# split behaviour
set splitbelow splitright
# allow backspacing over listed items
set backspace=indent,eol,start
set visualbell
# add numbers to each line on the left-hand side.
set number relativenumber ruler hidden
set nopaste
# undodir
set undofile undodir=~/.vim/undodir
# this option controls the behavior when switching between buffers
set switchbuf=uselast
# show several useful info
set showcmd showmode showmatch
set mouse=a mousemodel=popup_setpos
# the cursor is kept in the same column
set nostartofline
set ttyfast history=10000
# re-map leader key
nnoremap <space> <nop>
g:mapleader = ' '
# plugins
call plug#begin()
# make sure you use single quotes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'yegappan/lsp'
call plug#end()
# basic theme
set background=dark laststatus=2
set notermguicolors
# searching
set incsearch hlsearch ignorecase smartcase matchpairs+=<:>
# run ctags
if executable('ctags')
  def GenerateTags(): void
    var cmd = ['ctags', '--tag-relative=never', '-G', '-R', '.']
    var job = job_start(cmd, {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    echo 'generate tags..., status: ' .. job_status(job)
  enddef
  nnoremap <leader>tg :call <SID>GenerateTags()<CR>
else
  echo 'no ctags installation found'
endif
# re-size split windows using arrow keys
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
# netrw
nnoremap - :Explore<CR>
autocmd FileType netrw nnoremap <buffer> <C-c> :Rexplore<CR>
# command mode navigation
cnoremap <C-a> <home>
cnoremap <C-e> <end>
# dismiss highlight
nnoremap <silent> <Esc> :nohlsearch<CR>
# navigate through quickfix list
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
# navigate through buffers
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
# move selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
# enable auto completion menu after pressing tab.
set wildmenu wildmode=full wildcharm=<C-z> wildmenu
# wildoptions
set wildoptions=pum,tagfile
# wildignore
set wildignore=*.o,*~,*.a,*.so,*.pyc,*.swp,*.class
set wildignore+=*/target/*,*/build/*,*/generated-sources/*
set wildignore+=*/__pycache__/*,*/node_modules/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.vscode/*
if has('mac')
  set wildignore+=*/Library/*
  set wildignore+=*/.DS_Store
endif
# search current marked text
vnoremap // "0y/\V<C-r>=escape(@0,'/\')<CR><CR>
vnoremap <leader>/ "0y/\V<C-r>='<'.escape(@0,'/\').'>'<CR><CR>
# fuzzy find
nnoremap <leader>f :find **/*
nnoremap <leader>F :find **/*<C-r><C-w><CR>
nnoremap <leader>e :e %:h<C-z>
nnoremap <leader>b :b <C-z>
nnoremap <leader>ma :marks<CR>
nnoremap <leader>g :vimgrep //f **<S-Left><S-Left><Right>
vnoremap <leader>g "0y:vimgrep /<C-r>=escape(@0,'/\')<CR>/f **<S-Left><Left><Left><Left>
nnoremap <leader>G :vimgrep /<C-r><C-w>/f **
# ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading\ --column
  set grepformat^=%f:%l:%c:%m
  nnoremap <leader>g :silent grep! '' \| redraw!<S-Left><S-Left><Left><Left>
  vnoremap <leader>g "0y:silent grep! --case-sensitive '<C-r>0' \| redraw!<S-Left><S-Left><Left><Left>
  nnoremap <leader>G :silent grep! --case-sensitive '<C-r><C-w>' \| redraw!<CR>
  nnoremap <leader>/ :silent grep! --hidden --no-ignore '' \| redraw!<S-Left><S-Left><Left><Left>
endif
# copy marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
# find and replace
nnoremap <leader>r :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <leader>r "0y:%s/<C-r>=escape(@0,'/\')<CR>//gI<Left><Left><Left>
# unix command
nnoremap <leader>cp :!cp -r %<C-z> %:h<C-z>
nnoremap <leader>mv :!mv %<C-z> %:h<C-z>
# set mark before #/*
nnoremap <silent> # mM#
nnoremap <silent> * mM*
# indentation by ft
autocmd FileType python setl sw=4 ts=4 sts=4 et
autocmd FileType go setl sw=4 ts=4 sts=4 noet fp=gofmt
autocmd FileType javascript,typescript setl sw=2 ts=2 sts=2 et
autocmd FileType json setl sw=4 ts=4 sts=4 et fp=jq
# c, c++
augroup clang_opts
  au!
  au FileType c,cpp setl sw=4 ts=4 sts=4 et
  # c/c++ makeprg, work with :make command
  au FileType c,cpp setl makeprg=cd\ build\ &&\ cmake\ -DCMAKE_BUILD_TYPE=debug\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1\ -G\ Ninja\ ..\ &&\ ninja
  if has('mac') && executable('xcrun')
    var sdk_path = substitute(system('xcrun --show-sdk-path'), '\n', '', '')
    au FileType c,cpp execute 'setl path+=' . sdk_path . '/usr/include'
    au FileType c,cpp execute 'setl path+=' . sdk_path . '/usr/include/c++/v1'
  endif
augroup END
# java
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
# fzf
g:fzf_vim = {}
g:fzf_vim.preview_window = ['right,41%,<70(up,41%)']
g:fzf_layout = { 'down': '41%' }
nnoremap <leader>f :Files<CR>
nnoremap <leader>F :GFiles<CR>
nnoremap <leader>ma :Marks<CR>
highlight fzf1 ctermbg=NONE ctermfg=darkgrey
highlight fzf2 ctermbg=NONE ctermfg=darkgrey
highlight fzf3 ctermbg=NONE ctermfg=darkgrey
# lsp
var lsp_opts = {
  autoHighlightDiags: v:true,
  showInlayHints: v:true,
  diagSignErrorText: 'E',
  diagSignHintText: 'H',
  diagSignInfoText: 'I',
  diagSignWarningText: 'W',
  hoverInPreview: v:true,
}
autocmd User LspSetup call LspOptionsSet(lsp_opts)
var lsp_servers = [
  {
    name: 'clangd',
    filetype: ['c', 'cpp'],
    path: 'clangd',
    args: ['--background-index']
  },
  {
    name: 'gopls',
    filetype: ['go', 'gomod'],
    path: 'gopls',
    args: ['serve'],
    syncInit: v:true
  },
  {
    name: 'jdtls',
    filetype: 'java',
    path: $JDK21 .. '/bin/java',
    args: [
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx2g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      '-jar',
      glob($XDG_DATA_HOME .. '/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
      '-configuration',
      $XDG_DATA_HOME .. '/jdtls/config_mac_arm',
      '-data',
      $XDG_CACHE_HOME .. '/jdtls/workspace/' .. fnamemodify(getcwd(), ':p:h:t')
    ],
    settings: {
      java: {
          references: { includeDecompiledSources: v:true },
          eclipse: { downloadSources: v:true },
          maven: { downloadSources: v:true },
          signatureHelp: { enabled: v:true },
          contentProvider: { preferred: 'fernflower' },
          completion: {
            importOrder: [ 'java', 'javax', 'com', 'org' ]
          },
          sources: {
              organizeImports: {
                  starThreshold: 9999,
                  staticStarThreshold: 9999,
              },
          },
          codeGeneration: {
              toString: { template: '${object.className}{${member.name()}=${member.value}, ${otherMembers}}' },
              hashCodeEquals: {
                  useJava7Objects: v:false,
                  useInstanceOf: v:true,
              },
              useBlocks: v:true,
              addFinalForNewDeclaration: 'fields',
          },
          configuration: {
              runtimes: [
                { name: 'JavaSE-11', path: $JDK11, default: v:true },
                { name: 'JavaSE-17', path: $JDK17 },
                { name: 'JavaSE-21', path: $JDK21 }
              ]
          }
      }
    }
  },
  {
    name: 'tsserver',
    filetype: ['javascript', 'typescript'],
    path: 'typescript-language-server',
    args: ['--stdio'],
  }
]
autocmd User LspSetup call LspAddServer(lsp_servers)
augroup lsp_keymaps
  au!
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> gd :LspGotoDefinition<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> gD :LspGotoDeclaration<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> gi :LspGotoImpl<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> gr :LspShowReferences<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> gR :LspRename<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> ga :LspCodeAction<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> K :LspHover<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> <C-w>d :LspDiag current<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> <leader>j :LspDiag next<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> <leader>k :LspDiag prev<CR>
  au FileType c,cpp,java,go,javascript,typescript nnoremap <buffer> gq :LspFormat<CR>
augroup END
# basic highlights
highlight StatusLine cterm=NONE ctermbg=NONE ctermfg=grey
highlight StatusLineNC cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight VertSplit cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight SignColumn ctermbg=NONE guibg=NONE
highlight Normal cterm=NONE ctermbg=NONE guibg=NONE
highlight NormalNC cterm=NONE ctermbg=NONE guibg=NONE
# compile
defcompile
