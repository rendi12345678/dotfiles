# Powerlevel10k Instant Prompt (should stay close to the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Environment Variables
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH="$HOME/.espressif/tools/xtensa-esp32-elf/bin:$PATH"
export PYTHONPATH=/home/rendi/Downloads/pwndbg-2024.08.29/.venv/lib/python3.13/site-packages
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export VISUAL="nvim"
export MAKEFLAGS="-j$(nproc)"
export PATH="$HOME/.config/composer/vendor/bin:$HOME/.cargo/bin:/opt/nvim-linux64/bin:/opt/nvim/:/home/rendi/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export ZAP_PORT=8090
export ZAP_PATH="/usr/share/zaproxy/zap.sh"
export ANDROID_HOME=/opt/android-sdk
export NDK_HOME=/opt/android-ndk

# Perl Local Libraries
export PATH="/home/rendi/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/home/rendi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/rendi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/home/rendi/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/rendi/perl5"

# Initialization
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
eval "$(zoxide init zsh)"

# Load fzf
source ~/.config/zsh/plugins/fzf/shell/key-bindings.zsh

# Load zoxide
# eval "$(~/.config/zsh/plugins/zoxide/install.sh)"

# Aliases
alias compile-esp32="arduino-cli compile --fqbn esp32:esp32:esp32"
alias upload-esp32="arduino-cli upload -p /dev/ttyUSB0 --fqbn esp32:esp32:esp32"
alias monitor-esp32="arduino-cli monitor --port /dev/ttyUSB0"
alias run-esp32="compile-esp32 . && upload-esp32 . && monitor-esp32 . --config 115200"
alias printd='printf "%d\n"'
alias sudoedit='function _sudoedit(){ sudo -e "$1"; };_sudoedit'
alias ls="eza --icons=always"
alias b_status="upower -d | grep percentage | head -n 1"
alias cu="cd /run/media/rendi"
alias mount-usb="udisksctl mount -b"
alias mount-usb-ntfs="sudo mount -t ntfs-3g /dev/sdb1 /mnt"
alias unmount-usb="udisksctl unmount -b"
alias power-off-usb="udisksctl power-off -b"
alias connect-hdmi1="xrandr --output HDMI1 --auto"
alias connect-hdmi-1="xrandr --output HDMI-1 --auto"
alias disconnect-hdmi1="xrandr --output HDMI1 --off"
alias disconnect-hdmi-1="xrandr --output HDMI-1 --off"

# Application Aliases
alias e="exit"
alias run-parrot-server="qemu-system-x86_64 -m 3G -cdrom ~/Downloads/Parrot-home-6.2_amd64.iso -boot d -hda ~/Downloads/parrot-os.qcow2 -enable-kvm -net nic -net user"
alias run-parrot-client="vncviewer localhost:5900"
alias n="nvim"
alias r="ranger"
alias sn="sudoedit"
alias c="clear"
alias t="tmux"
alias trn="tmux rename"
alias ta="tmux attach -t"
alias tn="tmux new -t"
alias tl="tmux ls"
alias nq="n ~/.config/qutebrowser/config.py"
alias nn="n ~/.config/nvim"
alias nt="n ~/.tmux.conf"
alias nz="n ~/.zshrc"
alias nb="n ~/.bashrc"
alias na="n ~/.config/alacritty/alacritty.toml"
alias ni="n ~/.config/i3/config"
alias np="n ~/.config/picom/picom.conf"

# Directory Aliases
alias cd="z"
alias cn="cd ~/.config/nvim"
alias ca="cd ~/.config/alacritty"
alias ci="cd ~/.config/i3"

# npm Scripts
alias nrw="npm run watch"
alias nrd="npm run dev"
alias nrs="npm run start"
alias nrb="npm run build"

# pnpm Scripts
alias pnrw="pnpm run watch"
alias pnrd="pnpm run dev"
alias pnrs="pnpm run start"
alias pnrb="pnpm run build"

# Git Aliases
alias ga="git add"
alias gs="git status"
alias gcm="git commit -m"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gp="git push"
alias gm="git merge"
alias gb="git branch"
alias gbd="git branch -d"
alias gr="git remote"
alias gra="git remote add"
alias grr="git remote remove"
alias grv="git remote -v"
alias gpl="git pull"
alias gl="git log --graph --oneline --decorate --all"

# Docker Aliases
alias dcu="docker compose up"
alias dcw="docker compose watch"

# Cargo Aliases
alias cw='cargo watch -q -c -w src/ -x "run -q"'

# tmux Reload
alias sot="tmux source ~/.tmux.conf"
alias soz="source ~/.zshrc"
alias sob="source ~/.bashrc"

# Utilities
alias tree="tree -L 3 -a -I '.git' --charset X"
alias dtree="tree -L 3 -a -d -I '.git' --charset X"

# Recon-ng
alias recon-ng='cd ~/recon-ng && sudo docker run --rm -it -p 5000:5000 -v $(pwd):/recon-ng -v ~/.recon-ng:/root/.recon-ng --entrypoint "./recon-ng" recon-ng'

# OWASP ZAP
alias start-zap="zap-cli --log-path . start"
alias shutdown-zap="zap-cli shutdown"

# Hacking 
alias aslr-off="echo 0 | sudo tee /proc/sys/kernel/randomize_va_space"

edit_and_execute_command() {
  # Create a temporary file for editing
  local temp_file=$(mktemp /tmp/zsh_command.XXXXXX)
  [[ -z "$temp_file" ]] && { echo -e "\033[38;5;196m[ERROR]\033[0m Failed to create a temporary file."; return; }

  # Open the file in Neovim
  nvim "$temp_file"

  # Check if Neovim exited successfully
  if [[ $? -eq 0 ]]; then
    # Read the last command from the temporary file
    local last_command=$(cat "$temp_file")
    
    # Display the last command executed with a cool and bold header
    echo -e "\033[38;5;226m\033[1m[COMMAND]\033[0m"
    echo -e "\033[38;5;33m\033[4m$last_command\033[0m"

    # Copy the command to the clipboard using xclip
    echo -n "$last_command" | xclip -selection clipboard

    # Add the command to history using fc or appending manually
    echo "$last_command" >> ~/.zsh_history
    fc -A  # Append the history list

    # Execute the command and capture the output
    local response=$(eval "$last_command" 2>&1)
    
    # Check if the command was successful or failed and display output in color
    if [[ $? -eq 0 ]]; then
      if [[ -n "$response" ]]; then  # Only print output if there is something to display
        echo -e "\n\033[38;5;44m[OUTPUT]\033[0m"
        echo -e "\033[38;5;44m$response\033[0m"
      fi
    else
      if [[ -n "$response" ]]; then  # Only print error if there is something to display
        echo -e "\n\033[38;5;196m[ERROR]\033[0m Command failed with output:"
        echo -e "\033[38;5;196m$response\033[0m"
      fi
    fi
    
    # Remove the temporary file
    rm "$temp_file"
  else
    echo -e "\033[38;5;196m[ERROR]\033[0m Failed to edit the file in Neovim."
    rm "$temp_file"
  fi
}

bindkey -s '^e' "edit_and_execute_command^M"

# Load fzf-tab
autoload -U compinit; compinit
source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# ZSH History
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

# ZSH Editor Features
bindkey -v
bindkey -M vicmd 'p' paste
bindkey -M vicmd 'y' copy
zle -N paste
zle -N copy

# Enable fzf
source <(fzf --zsh)

# Activate Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Syntax Highlighting and Autosuggestions
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH="/home/rendi/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/rendi/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
source /usr/share/nvm/init-nvm.sh
