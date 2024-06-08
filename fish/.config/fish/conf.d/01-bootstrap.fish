if status is-interactive && ! functions --query fisher
  curl --silent --location https://git.io/fisher | source && fisher install jorgebucaran/fisher 
end


fzf --fish | FZF_ALT_C_COMMAND= source

fish_add_path /usr/go/bin
fish_add_path $HOME/.cargo/bin
