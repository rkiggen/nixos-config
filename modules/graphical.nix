# Graphical (Desktop) applications
{ pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [

            # audio & video
            nixpkgs.from.stable.vlc

            # development
            nixpkgs.for.rider.jetbrains.rider                       # jetbrains rider ide 
            nixpkgs.from.stable.vscode                              # visual studio code (development ide)
            nixpkgs.from.stable.direnv                              # shell extension for managing your environment 

            # documents
            nixpkgs.from.stable.calibre							    # ebook reader
            nixpkgs.from.stable.foliate							    # ebook reader
            nixpkgs.from.stable.evince
            nixpkgs.from.stable.libreoffice							# office suite (microsoft office alternative)
            nixpkgs.from.stable.masterpdfeditor					    # pdf editor
            nixpkgs.from.stable.zathura                             # pdf viewer
            
            # drawing / image manipulation
            nixpkgs.from.stable.pinta                               # drawing/editing program modeled after Paint.NET

            # internet & email
            nixpkgs.from.stable.brave                               # privacy-oriented browser for desktop and laptop computers
            nixpkgs.from.stable.tor-browser                         # privacy-focused browser routing traffic through the Tor network

            # security
            nixpkgs.from.stable.keepassxc                           # password manager
            nixpkgs.from.stable.veracrypt                           # file encryption

            # synchronization
            nixpkgs.from.stable.nextcloud-client                    # Desktop sync client for Nextcloud

            # terminals
            nixpkgs.from.stable.wezterm                             # gpu accelerated cross-platform terminal emulator and multiplexer  

            # virtualization & emulation
            nixpkgs.from.stable.wineWowPackages.stable              # open source implementation of the Windows API on top of X, OpenGL, and Unix 
            nixpkgs.from.stable.winetricks 

        ];
    };
}
