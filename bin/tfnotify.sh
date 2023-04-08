#!/bin/bash

set -eu
version=$1
file="tfnotify.tar.gz"

curl -fL -o $file https://github.com/suzuki-shunsuke/tfnotify/releases/download/${version}/tfnotify_linux_amd64.tar.gz
tar -C /usr/bin/ -xzf $file