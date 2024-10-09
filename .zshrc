###########################################################################
# .zshrc configuration
#
# Further Setup
#
# Run the following to install zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
# Install pyenv
# curl https://pyenv.run | bash
#
# Install nvm
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
###########################################################################

### Useful exports
export GIT_USERNAME=""
export GIT_EMAIL=""
export WINHOME="" #for WSL
export WINDESKTOP="" #for WSL
export WINONEDRIVE="" #for WSl
export MACHOME="~"
export MACDESKTOP="~/Desktop"
export MACONEDRIVE=""

### Initial setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
zstyle ':omz:update' mode auto      # update automatically without asking
plugins=( zsh-syntax-highlighting )
source $ZSH/oh-my-zsh.sh

### Configure prompt
__PROMPT_CONFIG_BOLD_GREEN="%{$fg_bold[green]%}"
__PROMPT_CONFIG_BOLD_RED="%{$fg_bold[red]%}"
__PROMPT_CONFIG_BOLD_CYAN="%{$fg_bold[cyan]%}"
__PROMPT_CONFIG_RESET="%{$reset_color%}"
__PROMPT_CONFIG_CYAN="%{$fg[cyan]%}"
__PROMPT_STAT="#"
__PROMPT_LEADER="$"
NEWLINE=$'\n'
PROMPT="%(?:${__PROMPT_STAT}:#)"
PROMPT+=' %~${NEWLINE}${__PROMPT_CONFIG_BOLD_GREEN}${__PROMPT_LEADER}${__PROMPT_CONFIG_RESET} '

### Aliases and Functions
alias k=kubectl
alias t=kubetail
alias kbash="kubectl exec -it pod/ubuntu -- /bin/bash"
alias python="python3"
alias sizeof="du -sh $1"
alias gp="git pull"
alias gss="git status"
alias gadd="git add ."
alias gcm="git commit"
alias fff="egrep -v \"(enqueueing|health/live|health/ready|Redis Health|Liveness Health|Readiness|fluentd)\""
function to_mp3() {
    ffmpeg -i "$1" -ab 320k -map_metadata 0 -id3v2_version 3 "${1%%.*}.mp3"
}
function vscode() {
    if [[ $(uname) == "Darwin" ]]; then
        VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;
    elif [[ $(uname) == "Linux" ]]; then
        code $*
    else
        echo "error: vscode function could not detect OS"
    fi
}
function hardsub() {
    subfile="${1%.*}.ass"
    filter="pad=ih*16/9:ih:(iw-ow)/2:0,ass=$subfile"
    ffmpeg -i "$1" -vf "$filter" -c:a copy -c:v libx264 -preset slow -crf 23 -aspect 16/9 "${1%.*}_out.mp4"
}
function cdw() {
    line=$(sed -e 's~\\~/~g' -e "s/\([CD]\):/\L\1/" -e "s/^/\/mnt\//g" <<< "$1")
    cd "$line"
}

git config --global core.editor "vim"
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

### Other commands
# Add ssh keys to ssh-agent
eval $(keychain --eval --agents ssh INSERT_KEY_HERE)
# Required for pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# Required for nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
