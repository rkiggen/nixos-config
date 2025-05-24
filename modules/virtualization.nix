# Common configuration applied to all hosts

{ inputs, pkgs, nixpkgs, userName, hostName, ... }: {
    config = {

        #########################################################
        # Virtualization: KVM / QEMU
        # in order to use virtualization you need to make 
        # sure that the appropriate kernel modules are loaded
        # boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

        # enable libvirtd
        virtualization.libvirtd.enable = true;

        # install virt-manager
        programs.virt-manager.enable = true;

        # add your user to the libvirtd group 
        users.groups.libvirtd.members = [users.users.${userName}];
        virtualisation.spiceUSBRedirection.enable = true; 

        # Containerization: PODMAN

        virtualization.containers.enable = true;
        virtualization = {
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
            nixpkgs.from.stable.dive  # look into docker image layers
            nixpkgs.from.stable.podman-tui # status of containers in the terminal
            # nixpkgs.from.stable.docker-compose # start group of containers for dev
            nixpkgs.from.stable.podman-compose # start group of containers for dev    
        ];
   };
}