# Graphical (Desktop) applications
{ pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [

            # audio & video
            nixpkgs.from.stable.vlc

            # development
            nixpkgs.for.rider.jetbrains.rider                       # jetbrains rider ide 
            nixpkgs.from.stable.vscode                              # visual studio code (development ide)

            # documents
            nixpkgs.from.stable.calibre							    # ebook reader
            nixpkgs.from.stable.evince
            nixpkgs.from.stable.libreoffice							# office suite (microsoft office alternative)
            nixpkgs.from.stable.masterpdfeditor					    # pdf editor
            nixpkgs.from.stable.texlive.combined.scheme-full        # latex environment
            nixpkgs.from.stable.zathura                             # pdf viewer

            # printing & scanning
            nixpkgs.from.stable.simple-scan

            # security
            nixpkgs.from.stable.keepassxc                           # password manager
            nixpkgs.from.stable.veracrypt                           # file encryption
            
            # terminals
            nixpkgs.from.stable.wezterm                             # gpu accelerated cross-platform terminal emulator and multiplexer  

            # virtualization & emulation
            nixpkgs.from.stable.wineWowPackages.stable              # open source implementation of the Windows API on top of X, OpenGL, and Unix 
            nixpkgs.from.stable.winetricks 

        ];
    };
}
