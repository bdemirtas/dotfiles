# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
# =============================================================================
# Oh-My-Zsh
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto

fpath+=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions/src

plugins=(
  git
  1password
  brew
  fzf
  pre-commit
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# History
# =============================================================================
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# =============================================================================
# Environment
# =============================================================================
export LANG=en_US.UTF-8
export EDITOR=nvim
export MANPATH="/usr/local/man:$MANPATH"

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS: Use the system-provided agent path
  # Usually macOS sets this automatically; only set if missing.
  export SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-$(launchctl getenv SSH_AUTH_SOCK)}"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux: Use the systemd user socket path
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"
fi

path+=(~/.local/bin ~/.cargo/bin)

# Homebrew
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# =============================================================================
# bat
# =============================================================================
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# =============================================================================
# fzf
# =============================================================================

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
