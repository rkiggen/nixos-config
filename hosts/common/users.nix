{ config, pkgs, ... }:

{
  # Define users
  users.users.rkiggen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "libvirtd" "lxd" ]; # Enable ‘sudo’ for the user.
    initialPassword = "password";
    shell = pkgs.zsh;
  };
}
