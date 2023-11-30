{ nixpkgs, ... }: {

  home.packages = [

    # Applications
    nixpkgs.from.stable.btop						# resource manager (best top alternative)
    nixpkgs.from.stable.brave				   	     	# privacy oriented browser based on chrome
    nixpkgs.from.stable.calibre					     	# ebook reader
    nixpkgs.from.stable.direnv					     	# shell extension that manages your environment
    nixpkgs.from.stable.doublecmd					# dual pane file manager (totalcmd clone)
    nixpkgs.from.stable.firefox 					# browser
    nixpkgs.from.stable.gimp						# graphics editor
    nixpkgs.from.stable.git						# source control
    #nixpkgs.from.stable.htop 						# resource manager (better top alternative)
    nixpkgs.from.stable.inetutils					# collection of common network progranms (telnet)
    nixpkgs.for.rider.jetbrains.rider 					# development ide
    nixpkgs.from.stable.keepassxc 					# password manager
    nixpkgs.from.stable.killall
    nixpkgs.from.stable.libreoffice 					# office suite (microsoft office alternative)
    nixpkgs.from.stable.losslesscut-bin 				# swiss army knife of lossless video/audio editing
    nixpkgs.from.stable.masterpdfeditor					# pdf editor
    nixpkgs.from.stable.nmap  						# utility for network discovery and security auditing
    #nixpkgs.from.stable.nitch 						# Minimal fetch alternative
    nixpkgs.from.stable.nss.tools 					# certutil
    nixpkgs.from.stable.nvme-cli 					# nvme command line tools (smartmon for ssd nvme drives)
    nixpkgs.from.stable.openssl 					# certificate generation utilities
    nixpkgs.from.stable.pfetch						# lightweight fetch alternative
    nixpkgs.from.stable.qbittorrent					# free bittorrent client
    nixpkgs.from.stable.qelectrotech 					# drawing electrical diagrams
    nixpkgs.from.stable.ranger 						# cli file manager
    nixpkgs.from.stable.seafile-client
    nixpkgs.from.stable.simple-scan
    nixpkgs.from.stable.simplescreenrecorder
    nixpkgs.from.stable.smartmontools 					# monitoring health hard drives
    nixpkgs.from.stable.syncthing					# open source continuous file synchronization
    nixpkgs.from.stable.syncthingtray-minimal				# tray application for syncthing
    nixpkgs.from.stable.texlive.combined.scheme-full 			# latex environment
    nixpkgs.from.stable.thunderbird 					# email client
    nixpkgs.from.stable.tmux 						# multiplexer
    nixpkgs.from.stable.tree 						# command to produce a depth indented directory listing 
    nixpkgs.from.stable.tor-browser-bundle-bin 				# tor browser
    nixpkgs.from.stable.veracrypt					# file encryption
    nixpkgs.from.stable.vlc
    nixpkgs.from.stable.vscode						# visual studio code (development ide)
    nixpkgs.from.stable.wineWowPackages.staging				# open source implementation of the Windows API on top of X, OpenGL, and Unix 
    nixpkgs.from.stable.winetricks
    nixpkgs.from.stable.xdotool 					# cli x11 automation tool (simulate keyboard and mouse activity)
    nixpkgs.from.stable.xprintidle 					# utility that queries the X server for the user's idle time and prints it to stdout
  ];
}  
