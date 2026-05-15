#!/bin/bash

# If no argument provided, show a picker
if [ -z "$1" ]; then
    echo "Select a template:"
    options=("oxford-maths-slides")

    select opt in "${options[@]}"; do
        if [ -n "$opt" ]; then
            name="$opt"
            break
        else
            echo "Invalid selection"
        fi
    done
else
    name="$1"
fi

mkdir -p templates/

cd templates/

rm -rf "$name"

git clone "git@gitlab.com:tobi-resources/templates/$name.git"

rm -rf "$name/.git"
