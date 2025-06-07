# Fonts: https://nixos.wiki/wiki/Fonts

{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [
            # Fonts
            nixpkgs.from.stable.corefonts
            nixpkgs.from.stable.liberation_ttf
            nixpkgs.from.stable.noto-fonts
            nixpkgs.from.stable.noto-fonts-cjk-sans
            nixpkgs.from.stable.noto-fonts-emoji
            nixpkgs.from.stable.fira
            nixpkgs.from.stable.fira-code
            nixpkgs.from.stable.fira-code-symbols
            nixpkgs.from.stable.fira-mono
            nixpkgs.from.stable.inconsolata
            nixpkgs.from.stable.profont
            nixpkgs.from.stable.source-sans-pro
            nixpkgs.from.stable.source-serif-pro
            nixpkgs.from.stable.symbola
            nixpkgs.from.stable.ubuntu_font_family
            nixpkgs.from.stable.unifont
            nixpkgs.from.stable.vistafonts           
        ];

        fonts.packages = [
            nixpkgs.from.stable.corefonts
            nixpkgs.from.stable.liberation_ttf
            nixpkgs.from.stable.nerd-fonts.jetbrains-mono
            nixpkgs.from.stable.nerd-fonts.fira-code
            nixpkgs.from.stable.nerd-fonts.droid-sans-mono
            nixpkgs.from.stable.nerd-fonts.symbols-only
            nixpkgs.from.stable.noto-fonts
            nixpkgs.from.stable.noto-fonts-cjk-sans
            nixpkgs.from.stable.noto-fonts-emoji
            nixpkgs.from.stable.fira
            nixpkgs.from.stable.fira-code
            nixpkgs.from.stable.fira-code-symbols
            nixpkgs.from.stable.fira-mono
            nixpkgs.from.stable.inconsolata
            nixpkgs.from.stable.profont
            nixpkgs.from.stable.source-sans-pro
            nixpkgs.from.stable.source-serif-pro
            nixpkgs.from.stable.symbola
            nixpkgs.from.stable.ubuntu_font_family
            nixpkgs.from.stable.unifont
            nixpkgs.from.stable.vistafonts  
        ];


    };

}