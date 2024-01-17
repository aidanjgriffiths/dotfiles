HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(
  git
  ssh-agent
  bundler
  dotenv
  macos
  tmuxinator
  conda-zsh-completion
  zsh-autosuggestions
  zsh-syntax-highlighting
)

zstyle :omz:plugins:ssh-agent agent-forwarding yes

export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_NOCOWS=true

export EDITOR=nvim
# git shortcuts
alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias wt="git worktree"
# properly set refs/heads to remote origin for --bare repositories.
alias bw="git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'"

alias vi=nvim
# get number of commits since branching off main
alias gr="git rev-list --count HEAD ^main"
# pretty print commits since last main node
alias gp="git rev-list --pretty='format:%C(auto)%h | %ad | %s' --date=short HEAD ^main | awk 'NR%2==0'"
alias cl="conda env list"

alias tm=tmuxinator

export TERM=xterm-256color
source $ZSH/oh-my-zsh.sh

fix_bare_repo() {
    # To be run in new or existing --bare git repos that don't point towards remote origins,
    # any other remote will will also need to be set up in a similar way.
    git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
    git for-each-ref --format='%(refname:short)' refs/heads | xargs -n1 -I{} git branch --set-upstream-to=origin/{} {}
}
