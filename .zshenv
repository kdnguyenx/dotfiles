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
# default editor
export EDITOR='nvim'
export VISUAL='nvim'
# zsh history
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
# use 256 color term
export TERM=tmux-256color
export COLORTERM=truecolor
# fzf options
export FZF_DEFAULT_OPTS="--no-color"
# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
