#!/usr/bin/env bash

set -e

for filename in cloudformation/**/*.yaml; do
    cfn-lint -t ${filename}
    # Disabling this check until I figure out the IAM privs for this
    # aws cloudformation validate-template --template-body file://${filename};
done
