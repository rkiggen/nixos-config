# fzf: command-line fuzzy finder

{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [
            nixpkgs.from.stable.fzf
        ];
    };
}
