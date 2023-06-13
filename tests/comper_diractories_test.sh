#!/bin/bash
dir1="tests"
dir2="modules"

dir1_dirs=$(find "$dir1" -type d -maxdepth 1 -mindepth 1 -exec basename {} \;)
dir2_dirs=$(find "$dir2" -type d -maxdepth 1 -mindepth 1 -exec basename {} \;)

output=$(echo "${dir2_dirs[@]} ${dir1_dirs[@]}" | tr ' ' '\n' | sort | uniq -u)

echo $output
