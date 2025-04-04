{ nixpkgs, config, ... }: {

  imports = [
    # paths to other modules
    #./window_managers/i3.nix
    ./programs
    ./browsers/firefox.nix
    ./browsers/brave.nix
    ./browsers/tor-browser.nix
    ./terminals/wezterm
    ./shells/zsh.nix
    #./emacs.nix
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

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