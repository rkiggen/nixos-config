# Synchronization
{ pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [

            # synchronization
            nixpkgs.from.stable.nextcloud-client                    # Desktop sync client for Nextcloud

        ];
    };
}
