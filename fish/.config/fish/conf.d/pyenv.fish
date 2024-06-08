if not command -s pyenv > /dev/null
    echo "Install <https://pyenv.run> to use 'pyenv'."
    exit 1
end

if status is-interactive
  set -Ux PYENV_ROOT $HOME/.pyenv
  fish_add_path $PYENV_ROOT/bin
end

if command -v pyenv 1>/dev/null 2>&1
    pyenv init - | source
end
