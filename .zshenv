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
export TERM=screen-256color
export CLICOLOR=1
# fzf
export FZF_DEFAULT_COMMAND='fd --hidden --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS='
  --color=fg:#908caa,bg:-1,hl:#ebbcba
  --color=fg+:#e0def4,bg+:-1,hl+:#ebbcba
  --color=border:#403d52,header:#31748f,gutter:-1
  --color=spinner:#f6c177,info:#9ccfd8
  --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa'
# golang
export GOPATH=$HOME/go
# jdk
export JDK11=$HOME/.sdkman/candidates/java/11.0.24-amzn
export JDK17=$HOME/.sdkman/candidates/java/17.0.12-amzn
export JDK21=$HOME/.sdkman/candidates/java/21.0.4-amzn
