# --------------------------------------------------------------------
# export env variables
# --------------------------------------------------------------------
if [ "$TERM_PROGRAM" != "tmux" ]; then
    export TERM="xterm-256color"
fi

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

export HISTFILE="${XDG_DATA_HOME}/zsh/zsh_history" 
export HISTTIMEFORMAT="[%F %T] "
export SHELL_SESSIONS_DISABLE=1
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"
export LESS="FIRSX"
export LESSHISTFILE="-" # disable less history file

export EDITOR='nvim'
export VISUAL='nvim'
export GIT_EDITOR="nvim"

export DOTFILES=${HOME}/.dotfiles

export GOPATH=${XDG_DATA_HOME}/go
export GOBIN=${XDG_DATA_HOME}/bin
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/.ripgreprc"
export EZA_TREE_IGNORE=".git|node_modules"
export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"
export FNM_DIR="${XDG_DATA_HOME}/fnm"
export RUSTUP_HOME="${XDG_DATA_HOME}/rust/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/rust/cargo"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export FZF_DEFAULT_OPTS='--height 50% --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

unset MAILCHECK
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
# --------------------------------------------------------------------
# setup starship
# --------------------------------------------------------------------
eval "$(starship init zsh)"
# --------------------------------------------------------------------
# setup cli tools
# --------------------------------------------------------------------
eval "$(fnm env)"
eval "$(conda "shell.$(basename "${SHELL}")" hook)"

source "/usr/local/opt/fzf/shell/completion.zsh"
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
# --------------------------------------------------------------------
# setup aliases
# --------------------------------------------------------------------
alias reload="exec zsh"
alias localip="ipconfig getifaddr en0"
alias t="tmux"
alias n="nvim"
alias vim="nvim"
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
# replace 'grep' with 'ripgrep'
alias grep='rg'

if [[ ${OSTYPE} == darwin* ]]; then
  # Reset DNS cache
  alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
  alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
fi

alias dot="cd ~/.dotfiles"
alias projects="cd ~/Development/projects"

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
prepend-path "${FNM_MULTISHELL_PATH}/bin"
prepend-path "${CARGO_HOME}/bin"
prepend-path "${GOBIN}"
prepend-path "/sbin"
prepend-path "/usr/sbin"
# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n "${PATH}" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')
# Wrap up
unset brew_prefix
export PATH
