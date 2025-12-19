# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, userName, ... }: {

    imports = [ 
        ../../modules/xfce.nix
        ../../modules/i3.nix
        ../../modules/printing.nix
        ../../modules/scanning.nix
        ../../modules/xorg.nix
        ../../modules/graphical.nix
        ../../modules/console.nix
        ../../modules/fonts.nix
        ../../modules/firefox.nix
        ../../modules/rofi.nix
        ../../modules/zsh.nix
        ../../modules/starship.nix
        ../../modules/yazi.nix
        ../../modules/emacs.nix
        ../../modules/virtualization.nix
        ../../modules/wireguard.nix
        ../../modules/kdeconnect.nix
        ./hardware-configuration.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Setup hostname & networking
    networking.hostName = "l241214a"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    networking.enableIPv6 = false;

    # Enable periodic TRIMming for SSD's
    services.fstrim.enable = true;

    # Enable bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # Enable (Thunder)Bolt support
    services.hardware.bolt.enable = true;

    # Enable touchpad support
    services.libinput.enable = true;

    # Enable sound
    services.pipewire = {
        enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
        pulse.enable = true;
    };
  
    services.power-profiles-daemon.enable = true; 

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "24.11"; # Did you read the comment?

}

