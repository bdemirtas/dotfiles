if status is-interactive
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
end

if command -q pyenv
    pyenv init - | source
else
    echo "pyenv not found — install it from https://pyenv.run"
end
