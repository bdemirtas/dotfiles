if test (uname) = Darwin
    if test -z "$SSH_AUTH_SOCK"
        set -gx SSH_AUTH_SOCK (launchctl getenv SSH_AUTH_SOCK)
    end

    # Load keys saved in Keychain when the agent is empty (e.g. after reboot)
    if not ssh-add -l >/dev/null 2>&1
        ssh-add --apple-load-keychain >/dev/null 2>&1
    end
else
    # Linux: systemd user socket
    if test -z "$SSH_AUTH_SOCK"
        set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    end
end