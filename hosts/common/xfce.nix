# XFCE desktop environment configuration

{ config, lib, pkgs, ... }:

{

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties
  i18n = { 
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
          LC_TIME = "nl_BE.UTF-8";
          LC_MONETARY = "nl_BE.UTF-8";
      };
  };

  console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
  };


  # Configure credential management
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Configure your desktop environment (desktopmanager, displaymanager & windowmanager)
  services.xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
      desktopManager = {
	xterm.enable = false;
        xfce.enable = true;
      };
      displayManager = {
	lightdm = {
	    enable = true;
	    greeters.slick = {
	        enable = true;
	    };
	};
      };

      # Configure keymap in X11
      xkb = {
          layout = "us";
          variant = "altgr-intl";
     };
  };

  services.displayManager.defaultSession = "xfce";
  programs = {
    firefox.enable = true;
    zsh.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # Flakes clones it dependencies through the git command, 
     # so it must be installed first
     git	

     # General packages
     alacritty
     tmux       
     neovim 	# neovim editor
     wget
     pciutils	# collection of programs for inspecting and manipulating configuration of pci devices
     ntfs3g 	# ntfs support
     usbutils 	# tools for working with USB devices
     dmidecode  # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard

     # Desktop specific packages
     blueman 		# GTK based bluetooth manager
     pavucontrol	# Pulse Audio Volume Control

     evince		# GNOME's document viewer
     libqalculate	# Adavanced calculator library
     qalculate-gtk	# Ultimate desktop calculator
     wmctrl		# CLI tool to interact with EWMH/NetWM compatible X Window Managers
     xclip		
     xcolor
     xdo
     xdotool
     xfce.catfish
     xfce.gigolo
     xfce.orage
     xfce.xfburn
     xfce.xfce4-appfinder
     xfce.xfce4-clipman-plugin
     xfce.xfce4-cpugraph-plugin
     xfce.xfce4-dict
     xfce.xfce4-fsguard-plugin
     xfce.xfce4-genmon-plugin
     xfce.xfce4-netload-plugin
     xfce.xfce4-panel
     xfce.xfce4-pulseaudio-plugin
     xfce.xfce4-systemload-plugin
     xfce.xfce4-weather-plugin
     xfce.xfce4-whiskermenu-plugin
     xfce.xfce4-xkb-plugin
     xfce.xfdashboard
     xorg.xev
     xsel
     xtitle
     xwinmosaic    
  ];

  # Set the default editor to neovim
  environment.variables.EDITOR = "nvim";

 }

