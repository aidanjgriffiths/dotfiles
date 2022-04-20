if [ ! -f ~/.git-prompt.sh ]; then
  version=$(git --version | awk '{print $3}')
  curl https://raw.githubusercontent.com/git/git/v${version}/contrib/completion/git-completion.bash -o ~/.git-completion.bash
  curl https://raw.githubusercontent.com/git/git/v${version}/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi


if [ -f ~/.git-prompt.sh ]; then
  # some eariler versions of git/completion do not have this file and will return a 404
  # manually remove this command if thats the case.
  source ~/.git-prompt.sh
  source ~/.git-completion.bash
  PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
fi
