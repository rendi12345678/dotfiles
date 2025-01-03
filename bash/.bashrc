#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export JAVA_HOME=/usr/lib/jvm/java-23-openjdk/bin/java
export PATH=$JAVA_HOME/bin:$PATH
