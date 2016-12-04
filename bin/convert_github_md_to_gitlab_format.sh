#!/bin/bash

echo
echo "Processing all *.md files in current directory..."
echo

# Loop through all .md files in directory and rename spaces to dashes
for file in *" "*; do
  echo "Renaming $file"
  mv -- "$file" "${file// /-}"
done

for file in *"("*; do
  echo "Renaming $file"
  mv -- "$file" "${file//(/}"
done

for file in *")"*; do
  echo "Renaming $file"
  mv -- "$file" "${file//)/}"
done

# Loop through all .md files in directory and convert them
for file in `find . -name '*.md'` ;
do
  echo "Converting ${file}";
  ruby ~/dotfiles/bin/github_wiki_to_gitlab_format.rb -i $file -o $file
done

echo "Complete."
