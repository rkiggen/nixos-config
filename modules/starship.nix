
# Starship: a minimal, blazing fast, and extremely customizable prompt for any shell

{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        programs.starship = {
            enable = true;
        };
    };

}