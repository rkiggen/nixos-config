# System configuration for my main laptop

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common/virtualization.nix
      ../common/scanners.nix
      ../common/users.nix
      ../common/systempackages.nix
    ];


  # Nix Package Manager settings
  nix = {
    settings = {
      auto-optimise-store = true;              # Optimise syslinks
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    package = pkgs.nixFlakes;                  # Make ready for nix flakes
    extraOptions =  ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;           # Allow unfree packages
  # enable thermal daemon on Intel laptops
  services.thermald.enable = true;

  # enable periodic TRIMming for SSD's
  services.fstrim.enable = true;

  # enable (Thunder)Bolt daemon
  services.hardware.bolt.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Define your hostname.
  networking.hostName = "l211008a";  

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hosts = {
    "10.0.2.100" = [ "Canona9afc7.ad.essential-it.be" "Canona9afc7" ];
  };
  networking.enableIPv6 = false;

  # Fix systemd predictable naming issue when randomly plugging in extra devices (like Thunderbolt dock with a nic)
  services.udev.extraRules =  ''
     # PCI device: 000:33:00.0 - thunderbolt dock nic
     SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="84:3a:5b:9d:70:3e", NAME="enp53s0"
     # PCI device: 000:35:00.0 - internal ethernet nic
     SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="80:fa:5b:9b:2d:cc", NAME="enp55s0"
     # PCI device: 000:36:00.0 - internal wireless
     SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="f0:77:c3:b6:db:2c", NAME="wlp56s0"
  '';


  # if you use ipv4, this is all you need
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = true; # enable ip forwarding
  # boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";
  # networking.timeServers = options.networking.timeServers.default ++ [ "ntp.example.com" ]
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "nl_BE.UTF-8";
    LC_MONETARY = "nl_BE.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      #defaultSession = "xfce";
      defaultSession = "none+i3";
    };
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        i3status # gives you the default i3 status bar
        i3blocks-gaps #if you are planning on using i3blocks over i3status
        i3lock #default i3 screen locker
      ];
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  # xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };
  };

  # Enable CUPS to print documents.
  services.printing = {
      enable = true;
      browsing = true;
      drivers = [ pkgs.canon-cups-ufr2 ];
  };

  # Enable avahi for (wireless) printer discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
    publish = {                               # Needed for detecting the scanner
        enable = true;
        addresses = true;
        userServices = true;
    };
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  fonts.fonts = with pkgs; [
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # font awesome v6 (icons)
    font-awesome_4			    # font awesome v4 (icons)
    corefonts                               # MS
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "DroidSansMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
