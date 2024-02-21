# --------------------------------------------------------------------
# export env variables
# --------------------------------------------------------------------
export TERM="xterm-256color"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

export HISTFILE="${XDG_DATA_HOME}/zsh/zsh_history" 
export HISTTIMEFORMAT="[%F %T] "
export SHELL_SESSIONS_DISABLE=1
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export ZSH="${XDG_DATA_HOME}/zsh/oh-my-zsh"
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"

export EDITOR='nvim'
export VISUAL='nvim'
export GIT_EDITOR="nvim"

export DOTFILES=${HOME}/.dotfiles

export GOPATH=${XDG_DATA_HOME}/go
export GOBIN=${XDG_DATA_HOME}/bin
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/.ripgreprc"
export EZA_TREE_IGNORE=".git|node_modules"
export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"
 
unset MAILCHECK
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
# --------------------------------------------------------------------
# setup oh-my-zsh
# --------------------------------------------------------------------
ZSH_THEME="robbyrussell"
source ${ZSH}/oh-my-zsh.sh
# --------------------------------------------------------------------
# setup cli tools
# --------------------------------------------------------------------
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env)"
eval "$(conda "shell.$(basename "${SHELL}")" hook)"
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
prepand-path ${GOBIN}
prepend-path "/sbin"
prepend-path "/usr/sbin"
# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n "${PATH}" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')
# Wrap up
unset brew_prefix
export PATH