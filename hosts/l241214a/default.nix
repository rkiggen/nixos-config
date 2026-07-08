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
        ../../modules/terminal.nix
        ../../modules/fonts.nix
        ../../modules/browser.nix
        ../../modules/rofi.nix
        ../../modules/zsh.nix
        ../../modules/starship.nix
        ../../modules/yazi.nix
        ../../modules/emacs.nix
        ../../modules/development.nix
        ../../modules/virtualization.nix
        ../../modules/wireguard.nix
        ../../modules/kdeconnect.nix
        ../../modules/security.nix
        ./hardware-configuration.nix
    ];
    
    # Allow updates device firmware/BIOS
    services.fwupd.enable = true;
    
    # Enable all firmware, 
    hardware.enableAllFirmware = true; # or hardware.firmwareLinuxNonfree

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

    # Configure how the system sleeps when the lid is closed;
    # specifically, it should sleep or suspend in all cases
    # --> when running on battery power
    # --> when connected to external power
    # --> when connected to a dock that has external power 
    services.logind.settings.Login.HandleLidSwitch = "suspend";
    services.logind.settings.Login.HandleLidSwitchExternalPower = "suspend";
    services.logind.settings.Login.HandleLidSwitchDocked = "suspend";
 
    services.power-profiles-daemon.enable = true; 

    services.udev.extraRules = ''
        # Disable fingerprint sensor
        SUBSYSTEM=="usb", ATTR{idVendor}=="27c6", ATTR{idProduct}=="609c", ATTR{authorized}="0"
    '';

    # Service for NVMe ASPM fix
    systemd.services.disable-nvme-aspm = {
        description = "Disable ASPM on NVMe PCIe link (WD SN770 idle/CSTS bug workaround)";
        wantedBy = [ "multi-user.target" ];
        after = [ "local-fs.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.pciutils}/bin/setpci -s 0000:02:00.0 CAP_EXP+0x10.w=00c0";
            RemainAfterExit = true;
        };
    }; 

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

