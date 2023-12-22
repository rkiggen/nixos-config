{ config, pkgs, ...}:

{
  # enable virtualization (KVM/QEMU & LXD)
  boot.kernelModules = ["kvm-intel" "kvm-amd"];

  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;

  # Add user to libvirtd & lxd group
  # users.users.rkiggen.extraGroups = [ "libvirtd" "lxd" ];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice spice-gtk
      spice-protocol
      virtiofsd
      win-virtio
      win-spice
      gnome.adwaita-icon-theme
  ];
  
  # Manage the virtualization services
  virtualisation = {
    libvirtd = {
    	enable = true;                         # enable KVM/QEMU
	qemu = {
	    swtpm.enable = true;	       # enable TPM (necessary for Windows 11 guests)
	    ovmf.enable = true;		       # enable Secure Boot
	    ovmf.packages = [ pkgs.OVMFFull.fd ];
	};
    };
    spiceUSBRedirection.enable = true;
    lxd.enable = true;                         # enable LXD
    # virtualbox.host.enable = true;           # enable VirtualBox
    # docker.enable = true;                    # enable Docker
    vswitch.enable = true;                     # enable OpenVSwitch
    vswitch.resetOnStart = true;
  };

  services.spice-vdagentd.enable = true;

}
