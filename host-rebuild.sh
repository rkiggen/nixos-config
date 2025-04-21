# host-rebuild.sh
#!/bin/sh
sudo nixos-rebuild switch --flake .
#sudo nixos-rebuild switch --flake . --impure
#sudo nixos-rebuild switch --flake . --impure --option eval-cache false
