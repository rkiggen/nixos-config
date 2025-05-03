# Rofi, a Window switcher, run dialog and dmenu replacement

{ inputs, pkgs, nixpkgs, ... }: {

    config = {

        environment.systemPackages = [

            nixpkgs.from.stable.rofi                # window switcher, run dialog and dmenu replacement

        ];

    };
}