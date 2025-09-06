source /usr/share/cachyos-fish-config/cachyos-config.fish
source ~/.config/fish/conf.d/aliases.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

zoxide init --cmd cd fish | source

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/identityapproved/.lmstudio/bin
