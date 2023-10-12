# host-install.sh
#!/bin/sh
pushd ~/.dotfiles/nix
sudo nixos-rebuild switch --flake .#l211008a 
popd
