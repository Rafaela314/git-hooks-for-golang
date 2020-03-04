#!/bin/bash

set -e -u -o pipefail

for file in "$@"; do
    go vet $file
done
