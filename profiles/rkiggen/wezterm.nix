{ config, nixpkgs, ...}: {

#  home.packages = [
#    nixpkgs.from.stable.wezterm
#  ];

  programs.wezterm = {
  	enable = true;
	enableZshIntegration = true;
	enableBashIntegration = true;
  };
  
  xdg.configFile."wezterm/wezterm.lua".enable = false; # do not autogenerate wezterm.lua
  home.file.".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/wezterm/wezterm.lua";
}
