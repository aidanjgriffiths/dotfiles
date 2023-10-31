# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/agriffit/.zshrc'

autoload -Uz compinit
fpath+=/home/agriffit/.zsh/conda-zsh-completion
compinit
# End of lines added by compinstall

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
