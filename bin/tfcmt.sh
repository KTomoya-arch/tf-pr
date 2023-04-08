#!/bin/bash

set -eu
version=$1
file="tfcmt.tar.gz"

curl -fL -o $file https://github.com/suzuki-shunsuke/tfcmt/releases/download/${version}/tfcmt_linux_amd64.tar.gz
tar -C /usr/bin/ -xzf $file