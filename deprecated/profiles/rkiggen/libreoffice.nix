{ nixpkgs, ...}: {
  home.packages = [
    nixpkgs.from.stable.libreoffice
  ];
}
