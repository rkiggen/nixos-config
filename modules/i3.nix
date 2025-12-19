# i3 window manager with xfce desktop environment configuration
# links: https://wiki.nixos.org/wiki/I3
{ config, lib, pkgs, nixpkgs, ... }: {

    config = {

        # I'm using i3 in combination with xfce
        # the defaultsession is defined in the xfce.nix config
        services.xserver.windowManager.i3 = {
            enable = true;
            package = pkgs.i3-gaps;
            extraPackages = with pkgs; [
                i3status        # gives you the default i3 status bar
                i3blocks-gaps   #if you are planning on using i3blocks over i3status
                i3lock          #default i3 screen locker
            ];
        };

        environment.systemPackages = [
            nixpkgs.from.stable.lxappearance    # lightweight program for configuring the theme and fonts of gtk applications
            nixpkgs.from.stable.dunst           # lightweight and customizable notification daemon
        ];       
    };
}