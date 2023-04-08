#!/bin/bash

set -eu
env=$1
target=$2
grep_str=$3
script_dir=$(cd $(dirname $0);pwd)

cd ${script_dir}/../src/${target}/${env}/
terraform init

for var in $(terraform state list | grep ${grep_str}) ; do
  cmd_option+=" -target=${var}"
done

terraform plan$cmd_option
rm -rf .terraform