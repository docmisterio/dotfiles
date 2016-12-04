dotfiles
========

Joe Hainline's dotfiles for OS X - Ruby and iOS development with git.
Gives you a multi-line bash prompt with color coding for commit status,
branch name, stash status, etc.


Usage 
-----

    cd ~

clone this repo to a directory called dotfiles (the default)

replace the contents of your .bash_profile file with the following:

```
if [ -f ~/dotfiles/.bashrc ]; then
  . ~/dotfiles/.bashrc
fi

if [ -f ~/dotfiles/.git_aliases ]; then
  . ~/dotfiles/.git_aliases
fi

if [ -f ~/dotfiles/.git_bash_prompt ]; then
  . ~/dotfiles/.git_bash_prompt
fi

if [ -f ~/dotfiles/.git_completion ]; then
  . ~/dotfiles/.git_completion
fi
```
