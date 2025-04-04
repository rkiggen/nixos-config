{ nixpkgs, lib, ... }: {

imports = [
    ./cheat-sheets.nix
    ./direnv.nix
    ./fonts.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./yazi.nix
    ./starship.nix
  ];

  home.packages = [
    nixpkgs.from.stable.btop
    nixpkgs.from.stable.pfetch			# lightweight fetch alternative
    nixpkgs.from.stable.tree 
    nixpkgs.from.stable.showmethekey
    nixpkgs.from.stable.unzip
    nixpkgs.from.stable.zip
    nixpkgs.from.stable.xdotool 			# cli x11 automation tool (simulate keyboard and mouse activity)
    nixpkgs.from.stable.xprintidle 			# utility that queries the X server for the user's idle time and prints it to stdout
  ];

  services.poweralertd.enable = true;

}
