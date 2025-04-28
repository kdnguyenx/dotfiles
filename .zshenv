# should only contain user's environment variables
# -----
# set xdg base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
# set language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
# ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
# default editor
export EDITOR='vim'
export VISUAL='vim'
# zsh history
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
# use 256 color term
export TERM=screen-256color
export CLICOLOR=1
export TERMINAL=alacritty
# golang
export GOPATH=$HOME/go
# fzf
export FZF_DEFAULT_OPTS='
  --color=fg:#d8d8d8,bg:-1,hl:#a1b56c
  --color=fg+:#d8d8d8,bg+:-1,hl+:#a1b56c
  --color=info:#7cafc2,prompt:#ba8baf,pointer:#ab4642,gutter:-1
  --color=marker:#f7ca88,spinner:#86c1b9,header:#a1b56c'
# jdk
export JDK11=$HOME/.sdkman/candidates/java/11.0.24-amzn
export JDK17=$HOME/.sdkman/candidates/java/17.0.12-amzn
export JDK21=$HOME/.sdkman/candidates/java/21.0.4-amzn
