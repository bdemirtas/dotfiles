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

