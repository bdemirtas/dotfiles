# editors
alias vim='nvim'
alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'

# lsd
alias ls='lsd'
alias l='lsd -l'
alias ll='lsd -la'
alias lt='lsd --tree'

# bat
alias cat='bat --paging=never'
alias catp='bat'

# disk / monitoring
alias du='dust'
alias df='duf'
alias top='btop'
alias htop='btop'

# zoxide
alias cd='z'
eval "$(zoxide init zsh)"

