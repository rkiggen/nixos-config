# Emacs: extensible, customizable GNU text editor

{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [
            nixpkgs.from.stable.emacs
            nixpkgs.from.stable.texlive.combined.scheme-full        # latex environment
            nixpkgs.from.stable.asciidoctor-with-extensions         # asciidoc processor written in Ruby, with many extensions enabled
        ];

        services.emacs = {
            enable = true;
            package = nixpkgs.from.stable.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
        };
    };

}