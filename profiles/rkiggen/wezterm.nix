{ nixpkgs, ...}: {

#  home.packages = [
#    nixpkgs.from.stable.wezterm
#  ];

  programs.wezterm = {
  	enable = true;
	enableZshIntegration = true;
	enableBashIntegration = true;
	#extraConfig = builtins.readFile ./wezterm.lua  # use this line instead of the home.file."config" line when you want to change your wezterm config without rebuilding !
  }
  home.file.".config/wezterm/wezterm.lua".source = ./wezterm.lua;
}
