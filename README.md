Setup
-----

Install vagrant plugins:

For Linode -
`vagrant plugin install vagrant-linode`

For Saltstack -
`vagrant plugin install vagrant-salt`


Encryption
----------

The secrets and sensitive information such as ssh keys are
gpg-encrypted using git-crypt.

Install git-crypt:
`brew install git-crypt`

Lock:
`git crypt lock`

Unlock:
`git crypt unlock`

To add a new user's gpg:
1. make sure the user's gpg key is alreaady imported in the machine
2. run `git-crypt add-gpg-user --trusted <email>`

ReCrypting:
when someone leaves, we need to
1. edit the .gpgusers file
2. run ./scripts/re-crypt.sh
This will re-encrypt all the secrets files as currently git-crypt
doesnt support removing a key cleanly.

Removing a specific user:
This is a bit difficult as we need to know their fingerprint,
so the recommended way is to use the 'ReCrypting' way mentioned above.

PreCommits
----------

Pre-commit hooks are used to run just before any commits. The details
of the precommit hooks can be found in `.pre-commit-config.yaml`

To install pre-commit run:
`brew install pre-commit`

To enable pre-commits run:
`pre-commit install`

Details of pre-commits can be found here:
http://pre-commit.com
https://github.com/pre-commit/pre-commit-hooks

Salt Lint
---------

Run 'bundle' and it will install a tool called 'salt-lint', this can check
the current state of sls files on each commit.
To check all sls files run:
`salt-lint --no-check-line-length  --scan=.`
