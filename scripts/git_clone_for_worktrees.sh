#!/usr/bin/env bash
set -e

url=$1
basename=${url##*/}
name=${2:-${basename%.*}}

git clone --bare "$url" "$name"

# To be run in new or existing --bare git repos that don't point towards remote origins,
# any other remote will will also need to be set up in a similar way.
pushd "$name"
git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
popd
