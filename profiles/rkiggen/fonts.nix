{ nixpkgs, ... }: {

  home.packages = [
    # Fonts
    nixpkgs.from.stable.corefonts
    nixpkgs.from.stable.fira
    nixpkgs.from.stable.fira-code
    nixpkgs.from.stable.fira-mono
    nixpkgs.from.stable.lato
    nixpkgs.from.stable.merriweather
    nixpkgs.from.stable.monoid
    (nixpkgs.from.stable.google-fonts.override { fonts = [ "BioRhyme" ]; })
    (nixpkgs.from.stable.google-fonts.override { fonts = [ "Bitter" ]; })
    nixpkgs.from.stable.hasklig
    nixpkgs.from.stable.helvetica-neue-lt-std
    nixpkgs.from.stable.inconsolata
    nixpkgs.from.stable.luculent
    nixpkgs.from.stable.profont
    nixpkgs.from.stable.source-sans-pro
    nixpkgs.from.stable.source-serif-pro
    nixpkgs.from.stable.symbola
    nixpkgs.from.stable.ubuntu_font_family
    nixpkgs.from.stable.unifont
    nixpkgs.from.stable.vistafonts

  ];
}

