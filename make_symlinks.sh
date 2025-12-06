#!/bin/bash

function make_symlink() {
  local target=$1
  local link_name=$2

  if [ -e $link_name ] || [ -L $link_name ]; then
      echo "Deleting $link_name"
      rm -rf $link_name
  fi

  ln -s $target $link_name
  echo "Symlink created: $link_name -> $target"
}

dotfiles_path="$(readlink -f "$(dirname "$0")")"
src_config_path=$dotfiles_path/config
dest_config_path=$HOME/.config

make_symlink $dotfiles_path/bashrc $HOME/.bashrc
make_symlink $dotfiles_path/blerc $HOME/.blesrc

for src_path in $src_config_path/*; do
    name="$(basename "$src_path")"
    link_path=$dest_config_path/$name

    replace_with_symlink $src_path $link_path
done
