umask 0007

export _UNAME=`uname`
# terminal settings
export TERM='xterm-256color'
export CLICOLOR=yes
#export DYLD_LIBRARY_PATH=/Applications/YourKit_Java_Profiler_9.5.5.app/bin/mac
export t_Co=256
export EDITOR=vim

# java settings
export JVMSTAT_JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home

# golang settings
export GOROOT=$HOME/workspace/go
export GOARCH=amd64
export GOBIN=$GOROOT/bin
export GOPATH=$HOME/workspace/go

export PATH=$GOPATH/bin:~/bin:/opt/local/bin:/usr/local/mysql/bin:$PATH

# dealing with git and hg, mostly set good PS1
source ~/.git-completion.bash

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

hg_ps1() {
  hg prompt "{branch}" 2> /dev/null
}

git_or_hg() {
  ghg=$(__git_ps1)
  if [ "$(hg_ps1)" != "" ]
    then
      ghg="($(hg_ps1))"
  fi
  echo $ghg
}
export PS1="\[$txtblu\]\$PWD \[$txtred\]\$(git_or_hg)\[$txtrst\]\[$txtrst\][\A]\n[\u@\[$bldylw\]\h\[$txtrst\]] \$ "

# tunnel to a machine.
# usage:
#   tunnel host:port
#   tunnel host:port bridge
#   tunnel host:port lport
#   tunnel host:port lport bridge
tunnel() {
  host=${1%%:*}
  port=${1#*:}
  lport=$2
  via=$3
  if [ "x$host" = "x" ]; then
    echo "Create ssh tunnel to a machine."
    echo "Usage:"
    echo "  tunnel host:port"
    echo "  tunnel host:port bridge"
    echo "  tunnel host:port lport"
    echo "  tunnel host:port lport bridge"
    return
  # if lport is not set
  elif [ "x$lport" = "x" ]; then
    lport=$port
    via=$host
  elif ! [[ "$lport" =~ ^[0-9]+$ ]]; then
    via=$lport
    lport=$port
  elif [ "x$via" = "x" ]; then
    via=$host
  fi

  echo ssh -L $lport:$host:$port $via
  ssh -L $lport:$host:$port $via
}
function vv() {
  e=${@/:/ +}
  if [ "${_UNAME}" = "Linux" ]; then
    vim -R -c "set number" "$e"
  else
    /Applications/MacVim.app/Contents/MacOS/Vim -R -c "set number" "$e"
  fi
}

function v() {
  e=${@/:/ +}
  if [ "${_UNAME}" = "Linux" ]; then
    vim -c "set number" "$e"
  else
    /Applications/MacVim.app/Contents/MacOS/Vim -c "set number" "$e"
  fi
}

alias http='python -m SimpleHTTPServer'
alias l='ls -lrt'
alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim'

export LANG=en_US.UTF-8
set meta-flag on
set input-meta on
set output-meta on
set convert-meta off
export LC_CTYPE=en_US.UTF-8

# make it safer
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias srm='srm -i'
alias dir='ls -al'
alias less='less -MX'

t() {
  if [ "${_UNAME}" = "Linux" ]; then
    top
  else
    top -ocpu
  fi
}
alias irb='irb --simple-prompt -r irb/completion'
alias mkpasswd='openssl rand 6 -base64'

alias pjson='python -mjson.tool'

# source search
ffd() {
  ff "(module|class|trait|object|def|val|var|type|def self\.)[ \t]+$1"
}

ff() {
  e=${@//--/[a-zA-Z0-9_]*}
  if [ "${_UNAME}" = "Linux" ]; then
    find -regextype posix-extended -L . -regex ".*$e.*\.(java|scala|rb|py)" > .foundfiles
    ack --follow --pager="less -R" -r "$e"
  else
    find -E -L . -regex ".*$e.*\.(java|scala|rb|py)" > .foundfiles
    ack --follow --pager=less -r "$e"
  fi

  rm -f .foundfiles
}

f() {
  git grep --color=always -n -E "$*"
}

g() {
  GREP_COLOR='1;32' grep --color=always "$*" | less -R
}

h() {
  GREP_COLOR='1;33' grep --color=always "$*" | less -R
}

i() {
  GREP_COLOR='1;34' grep --color=always "$*" | less -R
}

j() {
  GREP_COLOR='1;35' grep --color=always "$*" | less -R
}

g-() {
  GREP_COLOR='1;32' grep --color=always -v "$*" | less -R
}

F() {
  git grep --color=always -n -E -i "$*"
}

G() {
  GREP_COLOR='1;32' grep --color=always -i "$*" | less -R
}

H() {
  GREP_COLOR='1;33' grep --color=always -i "$*" | less -R
}

I() {
  GREP_COLOR='1;34' grep --color=always -i "$*" | less -R
}

J() {
  GREP_COLOR='1;35' grep --color=always -i "$*" | less -R
}

G-() {
  GREP_COLOR='1;32' grep --color=always -v -i "$*" | less -R
}

fd() {
  git grep --color=always -n -E "(public|private|protected|module|class|trait|object|def|val|var|type|def self\.)[ \t]+$*"
}

# ramdisk
ramdisk_unmount() {
  diskutil eject "ramdisk"
}

ramdisk() {
  a=$1
  a=$((a * 1024 * 2))
  cmd="hdiutil attach -nomount ram://$a"
  diskutil eject "ramdisk"
  diskutil erasevolume HFS+ "ramdisk" `$cmd`
  open /Volumes/ramdisk
}

# history search
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'
# make ctrl-s work for forward search
stty stop ^J

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

sum() {
  gawk '{ sum += $1 }; END { print sum }'
}

w() {
  e=${@//\"/\\\"}
  watch -n1 "$e"
}

c() {
  color=$1
  e=${2//--/[a-zA-Z0-9_]*}
  ack --flush --passthru --color --color-match=$color $e
}

# make ctrl-s work in incremental search.
stty -ixoff
stty stop undef
stty start undef

# bash readline vi mode
set -o vi

# create ctags file for scala
scalatags() {
  ctags -R --languages=scala --exclude=test *
}

# Check to see if SSH Agent is already running
agent_pid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($2)}')"

# If the agent is not running (pid is zero length string)
if [[ -z "$agent_pid" ]]; then
  # Start up SSH Agent

  # this seems to be the proper method as opposed to `exec ssh-agent bash`
  eval "$(ssh-agent)"

  # if you have a passphrase on your key file you may or may
  # not want to add it when logging in, so comment this out
  # if asking for the passphrase annoys you
  ssh-add

# If the agent is running (pid is non zero)
else
  # Connect to the currently running ssh-agent

  # this doesn't work because for some reason the ppid is 1 both when
  # starting from ~/.profile and when executing as `ssh-agent bash`
  #agent_ppid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($3)}')"
  agent_ppid="$(($agent_pid - 1))"

  # and the actual auth socket file name is simply numerically one less than
  # the actual process id, regardless of what `ps -ef` reports as the ppid
  agent_sock="$(find /tmp -path "*ssh*" -type s -iname "agent.$agent_ppid")"

  echo "Agent pid $agent_pid"
  export SSH_AGENT_PID="$agent_pid"

  echo "Agent sock $agent_sock"
  export SSH_AUTH_SOCK="$agent_sock"
fi
