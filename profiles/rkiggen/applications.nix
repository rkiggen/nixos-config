{ nixpkgs, lib, ... }: {

  home.packages = [
    # audio & video
    nixpkgs.from.stable.vlc

    # development
    nixpkgs.for.rider.jetbrains.rider							# jetbrains rider ide 
    nixpkgs.from.stable.vscode							# visual studio code (development ide)

    # documents
    nixpkgs.from.stable.calibre							# ebook reader
    nixpkgs.from.stable.evince
    nixpkgs.from.stable.libreoffice							# office suite (microsoft office alternative)
    nixpkgs.from.stable.masterpdfeditor					# pdf editor
    nixpkgs.from.stable.texlive.combined.scheme-full 			# latex environment
    
    # printing & scanning
    nixpkgs.from.stable.simple-scan

    # security
    nixpkgs.from.stable.keepassxc 						# password manager
    nixpkgs.from.stable.veracrypt							# file encryption

    # tools
    nixpkgs.from.stable.btop								# resource manager (best top alternative)
    nixpkgs.from.stable.pfetch							# lightweight fetch alternative
    nixpkgs.from.stable.tree 
    nixpkgs.from.stable.showmethekey
    nixpkgs.from.stable.unzip
    nixpkgs.from.stable.zip
    nixpkgs.from.stable.xdotool 							# cli x11 automation tool (simulate keyboard and mouse activity)
    nixpkgs.from.stable.xprintidle 							# utility that queries the X server for the user's idle time and prints it to stdout

     # virtualization & emulation
    nixpkgs.from.stable.wineWowPackages.stable				# open source implementation of the Windows API on top of X, OpenGL, and Unix 
    nixpkgs.from.stable.winetricks

  ];

}
