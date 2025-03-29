# Setup users for your system

{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rkiggen = {
     isNormalUser = true;
     initialPassword = "P@ssw0rd";
     extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
  };

}

