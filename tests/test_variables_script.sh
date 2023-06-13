#!/bin/bash  
cp $1 ./module_test.tf
file="./module_test.tf"
echo '' >> ./module_test.tf
declare -i default_counter=0
variable_name=""
declare -i brackets_counter=0
missing_variables=""
while read line; do  
    #Reading each line 
    if [[ "$line" == *"variable"* ]] ; then
            variable_name=$(echo "$line" | awk -F'"' '{print $2}')   
    fi
    if [[ "$line" == *"{"* ]] ; then
            let brackets_counter++
    fi
    if [[ "$line" == *"}"* ]] ; then
            let brackets_counter--
            if [[ $brackets_counter -eq 0 ]] && [[ $default_counter -eq 0 ]] ; then
                if ! cat $2 | grep -q "$variable_name"; then
                   missing_variables+="$variable_name, "
                fi
            fi
            if [[ $brackets_counter -eq 0 ]] && [[ $default_counter -eq 1 ]] ; then
               let default_counter=0
            fi
    fi
    if [[ "$line" == *"default"* ]]; then
        default_counter=1  
    fi

done < $file

echo $missing_variables
rm ./module_test.tf
