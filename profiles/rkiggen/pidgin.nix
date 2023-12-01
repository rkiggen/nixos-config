{ config, pkgs, ... }:

{

  programs.pidgin = {
    enable = true;
    plugins =[ pkgs.pidgin-osd pkgs.skypeweb pkgs.purple-slack pkgs.purple-discord pkgs.purple-matrix  ] 
 };
