#!/bin/bash
#Usage ./duplicatefiles.sh <globular>
#Eg. ./duplicatefiles.sh *.gif

shalist=()
duplicates=""

remove_file () {
    rm "$file"
    echo "$file removed"
}

for file in $1
do
#    echo "$file"
    sha256out=$(sha256sum "$file")
    sha=$(echo "$sha256out" | cut -f1 -d " ")
    if echo "${shalist[*]}" | grep -qw "$sha"; then
        duplicates+="$sha256out"$'\n' 
        echo "Duplicate: $sha256out"
        if [[ $deleteall ]]
        then
            remove_file
        else
            read -p "Would you like to remove \"$file\"? [y/n/a]: " yn
            case $yn in
              [Yy]*) remove_file ;; 
              [Aa]*) deleteall=1
                     remove_file  ;;
            esac
        fi
    else
        #echo "Non Duplicate: $sha256out"
        shalist+=("'$sha'")
    fi  
done


