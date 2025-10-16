# Xorg/X11 cli applications
{ lib, pkgs, nixpkgs, ... }: {

    config = {

        environment.systemPackages = [
            # XOrg/X11 cli applications
            nixpkgs.from.stable.wmctrl		    # CLI tool to interact with EWMH/NetWM compatible X Window Managers
            nixpkgs.from.stable.xclip	        # tool to access the X clipboard from a console application 	
            nixpkgs.from.stable.xcolor          # lightweight color picker for X11
            nixpkgs.from.stable.xdo             # small X utility to perform elementary actions on windows
            nixpkgs.from.stable.xdotool         # fake keyboard/mouse inout, window management, and more
            nixpkgs.from.stable.xorg.xev        # print contents of xevents
            nixpkgs.from.stable.xprintidle
            nixpkgs.from.stable.xsel            # command line program for getting and setting the contents of the X selection
            nixpkgs.from.stable.xtitle          # outputs X window titles
            nixpkgs.from.stable.xwinmosaic      # X window switcher drawing a colourful grid
        ];

    };
}

