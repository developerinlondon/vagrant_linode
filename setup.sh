#!/usr/bin/env bash
vagrant plugin install vagrant-linode
vagrant plugin install vagrant-salt
brew install git-crypt
brew install pre-commit
brew install shellcheck
git-crypt unlock

# install ruby libraries and salt-lint
gem install bundler
bundle install
