#!/usr/bin/env bash

git crypt unlock
rm -rf .git-crypt
rm -rf .git/git-crypt
git commit -a -m "Remove git-crypt"

git crypt init

while read p; do
  git crypt add-gpg-user --trusted $p
done <.gpgusers

git crypt lock
git crypt unlock