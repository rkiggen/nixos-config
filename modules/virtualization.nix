# Virtualization configuration
# enable QEMU virtualization & podman containerization

{ inputs, pkgs, nixpkgs, userName, ... }: {
    config = {

        #########################################################
        # Virtualization: KVM / QEMU
        # in order to use virtualization you need to make 
        # sure that the appropriate kernel modules are loaded
        # boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

        # Emulate arm64 & riscv64 on a native x86_64 (amd64) host 
        #boot.binfmt.emulatedSystems = [
        #    "aarch64-linux"
        #    "riscv64-linux"
        #];
        
        #boot.binfmt.registrations."aarch64-linux".fixBinary = true;

        virtualisation = {
            libvirtd = {

                # enable libvirtd
                enable = true;

                # Enable TPM emulation (for Windows 11)
                qemu = {
                    swtpm.enable = true;
                    vhostUserPackages = with pkgs; [ virtiofsd ];
                };
            };

            #  Enable USB redirection
            spiceUSBRedirection.enable = true;
        };

        # install virt-manager
        programs.virt-manager.enable = true;

        # add your user to the libvirtd group 
        users.groups.libvirtd.members = [ "rkiggen" ];

        # Containerization

        virtualisation.containers.enable = true;

        # Docker - development / VS Code Dev Containers
        virtualisation.docker.enable = true;
        
        # Podman - production / rootless containers
        virtualisation = {
            podman = {
                enable = true;

                # Required for containers under podman-compose to be able to talk to each other.
                defaultNetwork.settings.dns_enabled = true;
            };
        };

        # Useful other development tools 
        environment.systemPackages = [
            nixpkgs.from.stable.dive                # look into docker image layers
            nixpkgs.from.stable.dockmate            # terminal-based Docker container manager that actually works (supports docker, docker-compose and podman)
            nixpkgs.from.stable.docker-compose      # start group of containers for dev
            nixpkgs.from.stable.podman-compose      # start group of containers for dev    
            nixpkgs.from.stable.podlet              # generate Podman Quadlet files from a Podman command, compose file, or existing object
            nixpkgs.from.stable.virtiofsd           # vhost-user virtio-fs device backend written in Rust
        ];
   };
}