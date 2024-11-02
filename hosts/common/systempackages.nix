{ config, pkgs, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.variables.EDITOR = "nvim";
  environment.systemPackages = [
    pkgs.neovim      		# Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    pkgs.wget
    pkgs.ntfs3g 		# support ntfs file systems
    pkgs.samba			# support samba shares
    pkgs.pciutils		# collection of programs for inspecting and manipulating configuration of PCI devices
    pkgs.cifs-utils		# tools for managing Linux CIFS client filesystems
    pkgs.usbutils 		# tools for working with USB devices
    pkgs.dmidecode      	# a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard 
    pkgs.wireguard-tools    
    # i3
    pkgs.xorg.xrandr
    pkgs.lxappearance
    
    # xfce
    pkgs.xfce.xfce4-whiskermenu-plugin

    (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
       qemu-system-x86_64 \
         -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
         "$@"
     '')
  ];

}
