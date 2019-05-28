#!/bin/sh
dir="$*"
mkdir -v ~/Programing/python/Venv/"$dir"
virtualenv ~/Programing/python/Venv/"$dir" -p python3
echo "Created virtual envoriment in Venv directory"

