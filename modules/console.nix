# Console applications

{ inputs, pkgs, nixpkgs, ... }: {

    config = {

        environment.systemPackages = [
            # tools
            nixpkgs.from.stable.btop
            nixpkgs.from.stable.pfetch
            nixpkgs.from.stable.tree
            nixpkgs.from.stable.unzip
            nixpkgs.from.stable.zip
        ];
    };
}
