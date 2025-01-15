autoload -U zmv

# Set up the prompt
autoload -U promptinit
autoload -Uz vcs_info
precmd() { vcs_info }
promptinit

# basic git prompt
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{white}%*%f %(?.%F{green}%?%f.%F{red}%?%f) %F{blue}%1~%f %F{cyan}${vcs_info_msg_0_}%f > '

setopt histignorealldups sharehistory
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# add docker autocomplete
fpath+=(~/.docker/completions)

# add homebrew autocomplete
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Use modern completion system
autoload -Uz compinit
compinit

# Add local bin folder
path+=("$HOME/.local/bin")

# Setup GO
path+=("/usr/local/go/bin")
path+=("$HOME/go/bin")

# finally export path
export PATH

# Setup arrow keys to search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search # Up
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search # Down

# keybinds
bindkey "^[[3~" delete-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^H" backward-delete-word
bindkey "^[[3;5~" delete-word

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Fish like syntax highlighting for commands
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Setup Java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# My aliases
alias ll='ls -lah --color'
# dotfiles alias, allows interaction with my dotfiles repo located at $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

function install_dotfiles() {
  git config --global include.path ~/.config/git/sharedconfig
}

# Setup NVM for Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Fixes issue with GPG signing on windows
export GPG_TTY=$(tty)

# Setup cargo for rust
. "$HOME/.cargo/env"

