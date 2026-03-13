
# Starship: a minimal, blazing fast, and extremely customizable prompt for any shell

{ inputs, pkgs, nixpkgs, ... }: {

    config = {

        # does not add the binary to the path
        # programs.starship = {
        #     enable = true;
        #};

        environment.systemPackages = [
            nixpkgs.from.stable.starship
        ];
    };

}