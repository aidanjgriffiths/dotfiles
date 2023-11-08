HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(
  git
  bundler
  dotenv
  macos
  conda-zsh-completion
  zsh-autosuggestions
  zsh-syntax-highlighting
)

export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_NOCOWS=true

export EDITOR=nvim
# git shortcuts
alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias vi=nvim
# get number of commits since branching off main
alias gr="git rev-list --count HEAD ^main"
# pretty print commits since last main node
alias gp="git rev-list --pretty='format:%C(auto)%h | %ad | %s' --date=short HEAD ^main | awk 'NR%2==0'"
alias cl="conda env list"

source $ZSH/oh-my-zsh.sh
