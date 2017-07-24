#!/bin/bash
set -e -x -u
d=$(mktemp -d /var/tmp/imgaXXXXX)
trap "rm -rf ${d}" EXIT
7z x -y -o${d} "$@"
cd "${d}"
/home/tolich/.bin/sxivcorrect.py
