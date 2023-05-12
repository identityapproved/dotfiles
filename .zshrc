# If you come from bash you might have to change your $PATH. export 
# PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Battify
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias cat=$(which bat)

# one was loaded, run: echo $RANDOM_THEME See 
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# https://github.com/romkatv/powerlevel10k
ZSH_THEME="random"


zstyle ':omz:update' mode auto # disable automatic updates zstyle 

# Custom plugins
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
# https://github.com/redxtech/zsh-aur-install
# https://github.com/zshzoo/cd-ls
# https://github.com/alexiszamanidis/zsh-git-fzf
# https://github.com/jeffreytse/zsh-vi-mode
plugins=(git gitignore archlinux web-search pip python zsh-syntax-highlighting zsh-autosuggestions docker docker-compose zsh-vi-mode yarn tmux zsh-aur-install cd-ls zsh-git-fzf wakatime)

# https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# https://github.com/ohmyzsh/ohmyzsh
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/alias-tips/alias-tips.plugin.zsh

# https://github.com/junegunn/fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh

# NVM
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://github.com/Findarato/pokemon-colorscripts
pokemon-colorscripts -r
