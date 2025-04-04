{ nixpkgs, ...}: {
  home.packages = [
    nixpkgs.from.stable.cht-sh
  ];
}
