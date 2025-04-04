{ nixpkgs, ...}: {
  home.packages = [
    nixpkgs.from.stable.wezterm
  ];
}