{ nixpkgs, config, ... }: {

  imports = [
    # paths to other modules
    ./applications.nix
    #./i3.nix
    ./firefox.nix
    ./brave.nix
    ./tor-browser.nix
    ./emacs.nix
    ./cheat-sheets.nix
    ./direnv.nix
    ./fonts.nix
    ./fzf.nix
    ./git.nix
    # ./gpg.nix
    ./yazi.nix
    ./wezterm.nix
    ./zsh.nix
    ./starship.nix
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;
  services.poweralertd.enable = true;

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
