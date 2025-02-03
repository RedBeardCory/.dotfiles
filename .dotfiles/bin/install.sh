#!/bin/sh

# this should be run like this: 
# `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/RedBeardCory/.dotfiles/HEAD/install.sh)"`

# Global vars for install
CLONE_DIR="$HOME/.dotfiles"
WORKING_DIR="$HOME"
BIN_DIR="$CLONE_DIR/bin"
LOCAL_BIN="$HOME/.local/bin"
GIT_REPO="git@github.com:RedBeardCory/.dotfiles.git"

# clone repo
setup_repo() {
  if [ -d $CLONE_DIR ]; then
    printf "Repo already exists, skipping this step...\n"
  else
    printf "Cloning the repo...\n"
    git clone --bare $GIT_REPO $CLONE_DIR
  fi
}

# symlink commands into local bin
# takes any number of paths to link
install_cmds() {
  for CMD_PATH in $@; do
    printf "Linking %s -> %s\n" "$CMD_PATH" "$LOCAL_BIN"
    ln -s $CMD_PATH $LOCAL_BIN
  done
}

# add gitconfig include
install_gitconfig() {
  printf "Installing gitconfig shared preferences...\n"
  git config --global include.path $HOME/.config/git/sharedconfig
}

# run everything
main() {
  setup_repo

  install_cmds "$BIN_DIR/dotfiles" "$BIN_DIR/docker_stop_all"

  install_gitconfig
}

main
