#!/bin/bash

# If tag provided as argument, use it
if [ -n "$1" ]; then
    tag="$1"
else
    # Extract and clean tags from papis
    mapfile -t tags < <(
        papis list --all --format '{doc[tags]}' \
        | sed -e "s/\[//g" \
              -e "s/\]//g" \
              -e "s/'//g" \
        | tr ',' '\n' \
        | sed 's/^ *//;s/ *$//' \
        | sed '/^$/d' \
        | sort -u
    )

    echo "Select a tag:"

    select opt in "${tags[@]}"; do
        if [ -n "$opt" ]; then
            tag="$opt"
            break
        else
            echo "Invalid selection"
        fi
    done
fi

echo "Exporting references for tag: $tag"

papis export -a --format bibtex -o references.bib "tags : $tag"
