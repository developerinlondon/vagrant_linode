#!/usr/bin/env bash

git commit -a -m "Remove encrypted files"
rm -rf .git-crypt
git commit -a -m "Remove git-crypt"
rm -rf .git/git-crypt

git crypt init

while read p; do
  git crypt add-gpg-user --trusted $p
done <.gpgusers

git crypt lock
