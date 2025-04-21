{ config, pkgs, ... }: {

  programs.emacs.enable = true;
  home.file = {
    ".emacs.d" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.emacs.d";
      recursive = true;
    };
  };
}
