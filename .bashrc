#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export PYTHONPATH=/home/rendi/Downloads/pwndbg-2024.08.29/.venv/lib/python3.13/site-packages
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:$PKG_CONFIG_PATH
export ANDROID_HOME=/opt/android-sdk
export NDK_HOME=/opt/android-ndk
export PATH="$HOME/.espressif/tools/xtensa-esp32-elf/bin:$PATH"

