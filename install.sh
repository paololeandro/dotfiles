#!/bin/bash

# List the folder names you want to exclude, separated by |
exclude="previews|folder2|secrets"

for dir in */
do
    # Remove trailing slash for comparison
    dirname=${dir%/}

    if [[ "$dirname" =~ ^($exclude)$ ]]; then
        echo "Skipping $dirname..."
        continue
    fi

    stow "$dirname"
done
