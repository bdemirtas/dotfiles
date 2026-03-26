function rgi --description "Fuzzy search file contents, open result in nvim"
    set result (
        rg --color=always --line-number --no-heading --smart-case $argv |
        fzf --ansi \
            --delimiter=: \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'right:50%:+{2}+3/3:wrap'
    )
    if test -n "$result"
        nvim (echo $result | cut -d: -f1) +(echo $result | cut -d: -f2)
    end
end
