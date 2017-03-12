Setup
-----

Install vagrant plugins:

For Linode -
`vagrant plugin install vagrant-linode`

For Saltstack -
`vagrant plugin install vagrant-salt`

Install git-crypt:
`brew install git-crypt`

Unlock:
`git-crypt unlock`

To add a new user's gpg:
1. make sure the user's gpg key is alreaady imported in the machine
2. run `git-crypt add-gpg-user --trusted <email>`