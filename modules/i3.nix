# i3 window manager with xfce desktop environment configuration
# links: https://wiki.nixos.org/wiki/I3
{ config, lib, pkgs, nixpkgs, ... }: {

    config = {

        # I'm using i3 in combination with xfce
        # the defaultsession is defined in the xfce.nix config
        services.xserver.windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
                i3status        # gives you the default i3 status bar
                i3blocks        # if you are planning on using i3blocks over i3status
                i3lock          # default i3 screen locker
            ];
        };

        environment.systemPackages = [
            nixpkgs.from.stable.autorandr       # automatically select a display configuration based on connected devices
            nixpkgs.from.stable.bc              # GNU software calculator
            nixpkgs.from.stable.conky           # advanced, highly configurable system monitor based on torsmo
            nixpkgs.from.stable.dunst           # lightweight and customizable notification daemon
            nixpkgs.from.stable.feh             # light-weight image viewer
            nixpkgs.from.stable.lm_sensors      # tools for reading hardware sensors
            nixpkgs.from.stable.lxappearance    # lightweight program for configuring the theme and fonts of gtk applications
            nixpkgs.from.stable.picom           # sample compositing manager for X servers
        ];       
    };
}