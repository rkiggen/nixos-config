# Virtualization configuration
# enable QEMU virtualization & podman containerization

{ inputs, pkgs, nixpkgs, userName, ... }: {
    config = {

        #########################################################
        # Virtualization: KVM / QEMU
        # in order to use virtualization you need to make 
        # sure that the appropriate kernel modules are loaded
        # boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

        virtualisation = {
            libvirtd = {

                # enable libvirtd
                enable = true;

                # Enable TPM emulation (for Windows 11)
                qemu {
                    swtpm.enable = true;
                    ovmf.packages = [ pkgs.OVMFFull.fd ];
                };
            };
            
            #  Enable USB redirection
            spiceUSBRedirection.enable = true;
        };

        # install virt-manager
        programs.virt-manager.enable = true;

        # add your user to the libvirtd group 
        users.groups.libvirtd.members = [ "rkiggen" ];
        virtualisation.spiceUSBRedirection.enable = true; 

        # Containerization: PODMAN

        virtualisation.containers.enable = true;
        virtualisation = {
            podman = {
                enable = true;

                # Create a `docker` alias for podman, to use it as a drop-in replacement
                dockerCompat = false;

                # Required for containers under podman-compose to be able to talk to each other.
                defaultNetwork.settings.dns_enabled = true;
            };
        };

        # Useful other development tools 
        environment.systemPackages = [
            nixpkgs.from.stable.dive                # look into docker image layers
            nixpkgs.from.stable.podman-tui          # status of containers in the terminal
            # nixpkgs.from.stable.docker-compose    # start group of containers for dev
            nixpkgs.from.stable.podman-compose      # start group of containers for dev    
            nixpkgs.from.stable.podlet              # generate Podman Quadlet files from a Podman command, compose file, or existing object
        ];
   };
}