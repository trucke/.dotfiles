# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# Don't check mail when opening terminal.
unset MAILCHECK

# --------------------------------------------------------------------
# export env variables
# --------------------------------------------------------------------
export TERM="xterm-256color"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

export SHELL_SESSIONS_DISABLE=1		# disable `.zsh_sessions` to be created
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export EDITOR='nvim'
export VISUAL='nvim'
export GIT_EDITOR="nvim"

export DOTFILES=$HOME/.dotfiles

export GOPATH=$HOME/.local/go
export GOBIN=$HOME/.local/bin
export PYENV_ROOT="$HOME/.local/pyenv"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/.ripgreprc"
export EZA_TREE_IGNORE=".git|node_modules"
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"

# --------------------------------------------------------------------
# setup cli tools
# --------------------------------------------------------------------
eval "$(zoxide init --cmd cd zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(fnm env)"

# --------------------------------------------------------------------
# setup aliases
# --------------------------------------------------------------------
alias reload="source ${HOME}/.zshrc"
alias localip="ipconfig getifaddr en0"
alias t="tmux"
alias n="nvim"
# replace 'cat' with 'bat'
# https://github.com/sharkdp/bat
alias cat="bat"
# replace 'ls' with 'eza' (maintained fork of 'exa')
# https://github.com/eza-community/eza (https://github.com/ogham/exa)
unalias "ls" &> /dev/null
unalias "la" &> /dev/null
alias ls="eza -s name --color auto --group-directories-first --time-style=long-iso"
alias la="ls -ahl"
# replace 'tree' with 'eza'
alias tree='eza --tree'

if [[ ${OSTYPE} == darwin* ]]; then
  # Reset DNS cache
  alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
  alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
fi

# --------------------------------------------------------------------
# setup PATH
# --------------------------------------------------------------------
function prepend-path() {
  [[ -d "$1" ]] && PATH="$1:${PATH}"
}

type getconf > /dev/null 2>&1 && PATH=$($(command -v getconf) PATH)
brew_prefix=$(/usr/local/bin/brew --prefix)
# prepend new items to path (if directory exists)
prepend-path "/bin"
prepend-path "/usr/bin"
prepend-path "/usr/local/bin"
prepend-path "${brew_prefix}/bin"
prepend-path "${brew_prefix}/sbin"
prepend-path "${HOME}/.local/share/fnm"
prepend-path "${PYENV_ROOT}/bin"
prepend-path "/sbin"
prepend-path "/usr/sbin"
# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n "${PATH}" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')
# Wrap up
unset brew_prefix
export PATH
