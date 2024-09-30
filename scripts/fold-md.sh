#!/bin/bash
#
# Adds line wrapping to all Markdown files in the current directory.
#

WIDTH=120

# Recursively find all Markdown files in the current directory
find . -type f -name "*.md" | while read -r file; do
  # Use fold to wrap lines at 80 characters and overwrite the original file
  fold -w $WIDTH -s "$file" > temp && mv temp "$file"
done
