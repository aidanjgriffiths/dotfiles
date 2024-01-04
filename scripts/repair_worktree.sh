#!/usr/bin/env bash
set -e

git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
# If there are any existing local branches set the remote upstrems
git for-each-ref --format='%(refname:short)' refs/heads | xargs -n1 -I{} git branch --set-upstream-to=origin/{} {}
