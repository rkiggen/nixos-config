{ nixpkgs, ... }: {

  home.packages = [
      nixpkgs.from.stable.tor-browser-bundle-bin 
  ];

}