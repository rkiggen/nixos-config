{ nixpkgs, config, ... }: {

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "22.11";

  imports = [
    # paths to other modules
    ./applications.nix
    ./fonts.nix
    ./i3.nix
    ./alacritty.nix
    ./emacs.nix
    ./zsh.nix
    ./starship.nix
  ];

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "rkiggen";
    homeDirectory = "/home/rkiggen";
    sessionVariables = {
       I3_CONFIG = "/home/rkiggen/.config/i3";
    };
  };
}

