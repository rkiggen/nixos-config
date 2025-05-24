# Emacs: extensible, customizable GNU text editor

{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [
            nixpkgs.from.stable.emacs
            nixpkgs.from.stable.texlive.combined.scheme-full        # latex environment
        ];

        services.emacs = {
            enable = true;
            package = nixpkgs.from.stable.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
        };
    };

}