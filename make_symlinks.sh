#!/bin/bash

function make_symlink() {
  local target=$1
  local link_name=$2
  local use_sudo=$3

  if [ -e $link_name ] && [ ! -L $link_name ]; then
      echo "Deleting (backing up) $link_name"
      mv $link_name $link_name.bak
  fi

  mkdir -p ${link_name%/*}
  ln -sf $target $link_name
  echo "Symlink created: $link_name -> $target"
}

dotfiles_path="$(readlink -f "$(dirname "$0")")"
src_config_path=$dotfiles_path/config
dest_config_path=$HOME/.config

make_symlink "$src_config_path/regolith3/common.conf" "$dest_config_path/regolith3/common-wm/config.d/10-common.conf"
make_symlink "$src_config_path/regolith3/i3.conf" "$dest_config_path/regolith3/i3/config.d/10-i3.conf"
make_symlink "$src_config_path/regolith3/sway.conf" "$dest_config_path/regolith3/sway/config.d/10-sway.conf"
make_symlink "$src_config_path/lazygit/config.yml" "$dest_config_path/lazygit/config.yml"
make_symlink "$src_config_path/wezterm/wezterm.lua" "$dest_config_path/wezterm/wezterm.lua"
make_symlink "$src_config_path/helix/config.toml" "$dest_config_path/helix/config.toml"
make_symlink "$src_config_path/starship.toml" "$dest_config_path/starship.toml"
make_symlink "$src_config_path/bashrc/bashrc.common" "$HOME/.bashrc"
if command -v solaar &>/dev/null; then
  make_symlink "$src_config_path/solaar/rules.yaml" "$dest_config_path/solaar/rules.yaml"
fi
