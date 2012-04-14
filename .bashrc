umask 0007

# terminal settings
export TERM='xterm-256color'
export CLICOLOR=yes
#export DYLD_LIBRARY_PATH=/Applications/YourKit_Java_Profiler_9.5.5.app/bin/mac
export t_Co=256

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
export PS1="\[$txtblu\][\[$undblu\]\w\[$txtred\] \$(git_or_hg)\[$txtblu\]] \[$txtrst\][\A]\n[\u@\h] \$ "

# tunnel to a machine. 
# usage: tunnel bridge host:port
tunnel() {
  via=$1
  host=${2%%:*}
  port=${2#*:}
  delta=${3:-0}
  let "lport=$port+$delta"
  echo ssh -L $lport:$host:$port $via
  ssh -L $lport:$host:$port $via
}

function vv() {
  e=${@/:/ +}
  /Applications/MacVim.app/Contents/MacOS/Vim -R -c "set number" "$e"
}

function v() {
  e=${@/:/ +}
  /Applications/MacVim.app/Contents/MacOS/Vim -c "set number" "$e"
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

alias top='top -ocpu'
alias irb='irb --simple-prompt -r irb/completion'
alias mkpasswd='openssl rand 6 -base64'

alias pjson='python -mjson.tool'

# source search
ffd() {
  ff "(public|private|protected|module|class|trait|object|def|val|var|type|def self\.)[ \t]+$1"
}

ff() {
  e=${@//--/[a-zA-Z0-9_]*}
  find -E . -regex ".*$e.*\.(java|scala|rb)" > .foundfiles
  find . -name \*.go -o -name \*.py -o -name \*.h -o -name \*.c -o -name \*.cpp -o -name \*.cc -o -name \*.rhtml -o -name \*.xml -o -name \*.yml -o -name \*.erb -o -name \*.proto -o -name \*.pig -o -name \*.piglet -o -name \*.php -o -name \*.thrift -o -name \*.foundfiles -o -name \*.java -o -name \*.scala -o -name \*.rb -o -name \*.sh| xargs -J % grep --color=always -n -E "$e" % | less -X -R
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
