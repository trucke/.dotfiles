
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

export HOMEBREW_NO_ANALYTICS=1
export SHELL_SESSIONS_DISABLE=1

export LESSHISTFILE="-" # disable less history file
export LESS="FIRSX"
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/.ripgreprc"
export FNM_DIR="${XDG_DATA_HOME}/fnm"
export TMS_CONFIG_FILE="${XDG_CONFIG_HOME}/tms/config.toml"

export GOBIN="${XDG_DATA_HOME}/bin"
export CARGO_INSTALL_ROOT="${XDG_DATA_HOME}"

export GOPATH="${XDG_DATA_HOME}/go"
export RUSTUP_HOME="${XDG_DATA_HOME}/rust/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/rust/cargo"
export MIX_HOME="$XDG_DATA_HOME/mix"
export HEX_HOME="$XDG_DATA_HOME/hex"
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"

export BAT_THEME="gruvbox-dark"

export EZA_TREE_IGNORE=".git|node_modules"
export EZA_ICONS_AUTO=1

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--height ~35% --tmux 80%,50% --cycle --tac --no-unicode --info=right --highlight-line"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_COMPLETION_TRIGGER='::'

export DOTFILES=${HOME}/.dotfiles

unset MAILCHECK
# --------------------------------------------------------------------
# Download Zinit, if it's not there yet
# --------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# --------------------------------------------------------------------
# Add in zsh plugins
# --------------------------------------------------------------------
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# --------------------------------------------------------------------
# Add in snippets
# --------------------------------------------------------------------
zinit snippet OMZP::aliases
zinit snippet OMZP::brew
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

zstyle ":omz:plugins:eza" "dirs-first" yes
zstyle ":omz:plugins:eza" "header" yes
zstyle ":omz:plugins:eza" "size-prefix" binary
zstyle ":omz:plugins:eza" "time-style" long-iso
zinit snippet OMZP::eza

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# --------------------------------------------------------------------
# History
# --------------------------------------------------------------------
HISTSIZE=5000
HISTFILE="${XDG_DATA_HOME}/zsh/zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
if [[ ! -f "${HISTFILE}" ]]; then
    mkdir -p $(dirname "${HISTFILE}") && touch "${HISTFILE}"
    chmod 644 "${HISTFILE}"
fi

# --------------------------------------------------------------------
# Completion styling
# --------------------------------------------------------------------
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# --------------------------------------------------------------------
# Shell integrations
# --------------------------------------------------------------------
eval "$(starship init zsh)"
eval "$(fnm env)"
eval "$(conda "shell.$(basename "${SHELL}")" hook)"
eval "$(fzf --zsh)"
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --------------------------------------------------------------------
# Custom keybindings
# --------------------------------------------------------------------
bindkey -s ^f "tmux-sessionizer\n"

# --------------------------------------------------------------------
# Setup aliases
# --------------------------------------------------------------------
alias dot="cd ${HOME}/.dotfiles"
alias dev="cd ${HOME}/development"
alias docs="cd ${HOME}/Documents"

alias t="tmux"
alias c="conda"
alias f="fzf"
alias tw="tailwindcss"
alias aiders="conda activate aider && aider --sonnet --env-file ${HOME}/development/_tools/aider/env"
alias localip="ip address | grep -o \"inet 192.*/\" | awk '{ print \$2 }' | tr / ' ' | xargs"
alias dev="cd ${HOME}/development/"
alias gll='git log --graph --all --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad)" --date=relative -n 20'
alias glr='git lr'

alias lt="eza --tree --level=2 --icons --git"
alias llt="eza --tree --level=2 --long --icons --git"
alias lat="eza --tree --icons"

alias src="exec zsh"
alias edithosts="sudo nvim /etc/hosts"
alias editssh="nvim ${HOME}/.ssh/config"

alias cat="bat -pp"
alias grep="rg"
alias vim="nvim"

if [[ $(uname) == "Darwin" ]]; then
    alias localip="ipconfig getifaddr en0"
    alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
fi

# --------------------------------------------------------------------
# Setup PATH
# --------------------------------------------------------------------
function prepend-path() {
  [[ -d "$1" ]] && PATH="$1:${PATH}"
}

type getconf > /dev/null 2>&1 && PATH=$($(command -v getconf) PATH)
if [[ -f "/opt/homebrew/bin/brew" ]] then
    brew_prefix=$(/opt/homebrew/bin/brew --prefix)
else
    brew_prefix=$(/usr/local/bin/brew --prefix)
fi
# prepend new items to path (if directory exists)
prepend-path "/bin"
prepend-path "/usr/bin"
prepend-path "/usr/local/bin"
prepend-path "${brew_prefix}/bin"
prepend-path "${brew_prefix}/sbin"
prepend-path "${HOME}/.local/share/fnm"
prepend-path "${FNM_MULTISHELL_PATH}/bin"
prepend-path "${CARGO_HOME}/bin"
prepend-path "${XDG_DATA_HOME}/bin"
prepend-path "/sbin"
prepend-path "/usr/sbin"
prepend-path "${HOME}/.local/scripts"
prepend-path "/usr/local/opt/postgresql@15/bin"
prepend-path "${GHOSTTY_BIN_DIR}"
# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n "${PATH}" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')
# Wrap up
unset brew_prefix
export PATH

# --------------------------------------------------------------------
# Source additional files
# --------------------------------------------------------------------
if [[ -f "${HOME}/.keys" ]]; then
    source "${HOME}/.keys"
fi
