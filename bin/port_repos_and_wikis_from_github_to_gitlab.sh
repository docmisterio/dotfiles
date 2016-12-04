#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 githubTeam gitlabTeam repoNameToPortA [repoNameToPortB] ... [repoNameToPortZ]"
    exit 1
fi
ORIG_TEAM=$1
DEST_TEAM=$2
shift
shift
repo_names_array=( "$@" )

echo
echo "This script ports the following repos and their wikis from:"
echo
for repo_name in "${repo_names_array[@]}"
do
  echo -e https://github.com/${ORIG_TEAM}/${repo_name}.git
done
for repo_name in "${repo_names_array[@]}"
do
  echo -e https://github.com/${ORIG_TEAM}/${repo_name}.wiki.git
done

echo
echo to these repos:
echo
for repo_name in "${repo_names_array[@]}"
do
  echo -e https://gitlab.com/${DEST_TEAM}/${repo_name}.git
done
for repo_name in "${repo_names_array[@]}"
do
  echo -e https://gitlab.com/${DEST_TEAM}/${repo_name}.wiki.git
done

echo
echo "The destination repos must already exist, but their wikis don't need to."
echo "This may take some time..."
read -p "Press [Enter] key to continue"
echo

# and now loop through the repo names:
for repo_name in "${repo_names_array[@]}"
do
  # Gitlab needs lowercase repo names, and dots turn into dashes
  gitlab_repo_name=`echo "print '$repo_name'.downcase.gsub('.', '-')" | ruby`

  git clone https://github.com/${ORIG_TEAM}/${repo_name}.git

  if cd ${repo_name}; then
#    git submodule update --init --recursive
    git remote add gitlab https://gitlab.com/${DEST_TEAM}/${gitlab_repo_name}.git
    git push gitlab refs/remotes/origin/*:refs/heads/*
    git push gitlab --tags
    cd ..
  else
    echo "Repo ${repo_name} could not be cloned. Aborting!"
    exit 1
  fi

  git clone https://github.com/${ORIG_TEAM}/${repo_name}.wiki.git
  if cd ${repo_name}.wiki; then
    git tag -a gitlab_wiki_conversion_before -m "Tag before conversion of github wiki links to gitlab format."
    convert_github_md_to_gitlab_format.sh
    git add . -A
    git commit -m "Automatically converted github wiki links to gitlab format."
    git tag -a gitlab_wiki_conversion_after -m "Tag after conversion of github wiki links to gitlab format."
    git remote add gitlab https://gitlab.com/${DEST_TEAM}/${gitlab_repo_name}.wiki.git
    git push gitlab master
    git push gitlab refs/remotes/origin/*:refs/heads/*
    git push gitlab --tags
    cd ..
  else
    echo "No wiki could be cloned. Continuing..."
  fi
done

echo Done!
