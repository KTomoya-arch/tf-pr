#!/bin/bash

set -eu
env=$1
target=$2
script_dir=$(cd $(dirname $0);pwd)

cd ${script_dir}/../src/${target}/${env}/
terraform init
terraform apply -auto-approve -no-color 2>&1 | \
grep -v -e ' Reading\.\.\.' | \
grep -v -e ' Read complete ' | \
grep -v -e ' Refreshing state\.\.\. '
rm -rf .terraform