#!/usr/bin/env bash
#
# Script to re-encrypt all the git encrypted files.
#
# It will re-initialize git-crypt for the repository and re-add all keys
# specified in .gpgusers file.
#
# Note: You still need to change all your secrets to fully protect yourself.
# Removing a user will prevent them from reading future changes but they will
# still have a copy of the data up to the point of their removal.
#
# Use:
#  ./re-crypt.sh
#
# The script will create multiple commits to your repo. Feel free to squash them
# all down to one.
#
# Based on https://github.com/AGWA/git-crypt/issues/47#issuecomment-212734882
#
set -e

TMPDIR=$(mktemp -d)
echo "Using TMPDIR $TMPDIR"
CURRENT_DIR=$(git rev-parse --show-toplevel)
PWD=$(pwd)
BASENAME=$(basename "$PWD")

# Unlock the directory, we need to copy encrypted versions of the files
git crypt unlock

# Work on copy.
cp -rp "$PWD" "$TMPDIR"


pushd "$TMPDIR/$BASENAME"

# Remove encrypted files and git-crypt
git crypt status | grep -v "not encrypted" > encrypted-files
awk '{print $2}' encrypted-files | xargs rm
git commit -a -m "Remove encrypted files"
rm -rf .git-crypt
git commit -a -m "Remove git-crypt"
rm -rf .git/git-crypt

# Re-initialize git crypt
git crypt init

# add the keys in
while read -r p; do
  git crypt add-gpg-user --trusted "$p"
done <.gpgusers


cd "$CURRENT_DIR"
while read -r i; do
    rsync -R "$i" "$TMPDIR/$BASENAME";
done < <(awk '{print $2}' "${TMPDIR}/${BASENAME}/encrypted-files")

cd "$TMPDIR/$BASENAME"
while read -r i; do
    git add "$i"
done < <(awk '{print $2}' encrypted-files)
git commit -a -m "New encrypted files"
popd

git crypt lock
git pull "$TMPDIR/$BASENAME"

rm -rf "$TMPDIR"
