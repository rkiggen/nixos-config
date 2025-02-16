# Nix package manager settings

{ config, lib, pkgs, ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;              # Optimise syslinks
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    
  };

  nixpkgs.config.allowUnfree = true;
 }

