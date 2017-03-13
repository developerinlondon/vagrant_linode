#!/bin/bash

echo "begin salt-lint"

if ! which salt-lint
then
    echo "are you sure you have installed salt-lint?"
    exit 1
fi

output=$(salt-lint --no-check-line-length -f "$@")
if  [[ $output =~ "Total errors found: 0" ]]; then
  exit 0
else
  exit 1
fi
