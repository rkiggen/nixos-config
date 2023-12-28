{ config, pkgs, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim      # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    ntfs3g 	# support ntfs file systems
    samba	# support samba shares
    pciutils	# collection of programs for inspecting and manipulating configuration of PCI devices
    cifs-utils  # tools for managing Linux CIFS client filesystems
    usbutils 	# tools for working with USB devices
    dmidecode   # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard 
    # i3
    xorg.xrandr
    lxappearance
    # xfce
    xfce.xfce4-whiskermenu-plugin
  ];

}
