#!/bin/bash
# this code will check if there is a new module that dont have a test diractory, in that case it will bring back
# the missing test file that the user will need to add to the repo.

dir1="tests"
dir2="modules"

dir1_dirs=$(find "$dir1" -type d -maxdepth 1 -mindepth 1 -exec basename {} \;)
dir2_dirs=$(find "$dir2" -type d -maxdepth 1 -mindepth 1 -exec basename {} \;)

output=$(echo "${dir2_dirs[@]} ${dir1_dirs[@]}" | tr ' ' '\n' | sort | uniq -u)

missing_directoies=""

output_array=()
while IFS= read -r line; do
  output_array+=("$line")
done < <(echo "${dir2_dirs[@]}" "${dir1_dirs[@]}" | tr ' ' '\n' | sort | uniq -u)

# Print the elements of the output array
for dir in "${output_array[@]}"; do
  if ! echo $dir1_dirs | grep -q "$dir" ; then
    missing_directoies+="$dir  "
  fi
done

echo $missing_directoies