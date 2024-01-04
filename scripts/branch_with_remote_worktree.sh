#!/usr/bin/env bash
set -e

git fetch && for branch in `git branch -r | sed 's@origin/@ @'`;do `git branch  $branch origin/$branch`;done
