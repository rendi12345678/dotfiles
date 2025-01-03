# Powerlevel10k Instant Prompt (keep this near the top for better performance)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Environment Variables
export JAVA_HOME=/usr/lib/jvm/java-23-openjdk
export PATH="$JAVA_HOME/bin:$PATH"
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export VISUAL="nvim"
export MAKEFLAGS="-j$(nproc)"
export PATH="$HOME/.config/composer/vendor/bin:$HOME/.cargo/bin:/opt/nvim-linux64/bin:/opt/nvim:$HOME/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export ZAP_PORT=8090
export ZAP_PATH="/usr/share/zaproxy/zap.sh"
export PATH="/home/rendi/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/rendi/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

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

# Load Plugins and Themes
source ~/dotfiles/zsh/plugins/fzf/shell/key-bindings.zsh
source ~/dotfiles/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U compinit && compinit
source ~/dotfiles/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

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

# Aliases
alias sudoedit='function _sudoedit(){ sudo -e "$1"; };_sudoedit'
alias ls="eza --icons=always"
alias cu="cd /run/media/rendi"
alias mount-usb="udisksctl mount -b"
alias unmount-usb="udisksctl unmount -b"
alias power-off-usb="udisksctl power-off -b"
alias connect-hdmi1="xrandr --output HDMI1 --auto"
alias connect-hdmi-1="xrandr --output HDMI-1 --auto"
alias disconnect-hdmi1="xrandr --output HDMI1 --off"
alias disconnect-hdmi-1="xrandr --output HDMI-1 --off"

# Application Aliases
alias e="exit"
alias n="nvim"
alias r="ranger"
alias sn="sudoedit"
alias c="clear"
alias t="tmux"
alias trn="tmux rename"
alias ta="tmux attach -t"
alias tn="tmux new -t"
alias tl="tmux ls"

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

# Edit Command Function
edit_zsh_command() {
  local temp_file=$(mktemp /tmp/zsh_command.XXXXXX)
  [[ -z "$temp_file" ]] && { echo "Failed to create a temporary file."; return; }

  nvim "$temp_file"
  if [[ $? -eq 0 ]]; then
    local last_command=$(cat "$temp_file")
    echo -n "Last command executed: $last_command"
    local response=$(eval "$last_command")
    echo -e "\nResponse:\n$response"
    rm "$temp_file"
  else
    echo "Failed to edit the file in Neovim."
    rm "$temp_file"
  fi
}

# Package Manager Auto-Complete
package_manager_auto_complete() {
  local packages
  packages=$(pacman -Ss | awk '{print $1}' | fzf --height=40% --border --preview="pacman -Si {1}" --preview-window=right:70%:wrap)
  [[ -n "$packages" ]] && LBUFFER="$LBUFFER$packages"
}

# Bind Keys
zle -N package_manager_auto_complete
bindkey '^I' package_manager_auto_complete
bindkey -s '^e' "edit_zsh_command^M"
