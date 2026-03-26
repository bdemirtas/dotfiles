# Set XDG basedirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
set -q DOTFILES || set -gx DOTFILES ~/dotfiles
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

# Set editor variables.
set -gx PAGER less
set -gx EDITOR nvim

set -gx DOTFILES $HOME/dotfiles
set -gx MY_PROJECTS $HOME/Projects

set -U fish_greeting
set -U pure_enable_single_line_prompt true
set -U pure_shorten_prompt_current_directory_length 1
set -U nvm_default_version v20.14.0

# bat as man pager
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT -c

# fzf + ripgrep
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git"'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_DEFAULT_OPTS "
  --height=50%
  --layout=reverse
  --border=rounded
  --info=inline"

# fzf previews with bat/lsd
set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range :100 {}'"
set -gx FZF_ALT_C_OPTS "--preview 'lsd --tree --depth 2 --color=always {}'"

# dust — reverse sort by default (largest at bottom, easier to read)
set -gx DUST_REVERSE true
