#!/bin/bash

set -e

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

template_dir="templates/$name"

if [ ! -d "$template_dir" ]; then
    echo "Template not found: $template_dir"
    exit 1
fi

echo "Copying *.main files from $template_dir ..."

find "$template_dir" -type f -name "*.main" | while read -r file; do
    base="$(basename "$file" .main)"

    echo "  -> $base"

    cp "$file" "./$base"
    rm "$file"
done

echo "Done."
