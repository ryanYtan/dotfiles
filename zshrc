##########################################################################
# .zshrc configuration
#
# Replace the exports below for the script to work correctly.
#
# Run the following to install zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
# Other packages to install
# - nvm
# - uv
# - keychain
###########################################################################

### Exports
export GIT_USERNAME="ryanYtan"
export GIT_EMAIL="tanyuryan@gmail.com"

### Initial setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
zstyle ':omz:update' mode auto      # update automatically without asking
plugins=( zsh-syntax-highlighting )
source $ZSH/oh-my-zsh.sh

# Git setup
git config --global core.editor "vim"
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

### Prompt setup
PROMPT='[%n]# %~
%Bλ%b '

### Git setup
git config --global core.editor "vim"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
