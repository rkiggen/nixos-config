{ config, nixpkgs, ...}: {

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  #xdg.configFile."starship.tom".enable = false; # do not autogenerate starship.toml
  #xdg.configFile."starship.toml".source = ./starship.toml;
  home.file.".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/starship/starship.toml";

}
