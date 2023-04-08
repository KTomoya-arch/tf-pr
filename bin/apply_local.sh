#!/bin/bash

set -eu
env=$1
script_dir=$(cd $(dirname $0);pwd)

cd ${script_dir}/../src/github-oidc/
terraform init -reconfigure -backend-config="./config/${env}.tfbackend"
terraform apply -auto-approve -var-file="./tfvars/${env}.tfvars"
rm -rf .terraform