{ config, pkgs, ... }:

{

  programs.pidgin = {
    enable = true;
    plugins = [ 
    	pkgs.pidgin-osd 
	pkgs.pidgin-skypeweb 
	pkgs.purple-slack 
	pkgs.purple-discord 
	pkgs.purple-matrix  
	#pkgs.tdlib-purple
	pkgs.pidgin-window-merge
     ];
  };
}
