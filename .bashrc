export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin
export PATH=$PATH:~/dotfiles/bin
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib

source ~/.profile  #when RVM is installed, sources rvm paths

#save all history from all terminal windows
#see http://linuxcommando.blogspot.com/2007/11/keeping-command-history-across-multiple.html
shopt -s histappend
PROMPT_COMMAND='history -a'

#increase bash history size
HISTFILESIZE=10000

# enable color support of ls if it seems available
export GREP_COLOR=33
USE_COLOR_CMDS=""

# for a mac
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

if [ ! -z "$USE_COLOR_CMDS" ]; then
  # Highlight search term in grep
  alias grep='grep --color=auto --line-number'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
