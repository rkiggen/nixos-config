{ config, pkgs, ... }:

{
  # Define fonts
  fonts.packages = with pkgs; [
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # font awesome v6 (icons)
    font-awesome_4			    # font awesome v4 (icons)
    corefonts                               # MS
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "DroidSansMono" ]; })
  ];

}

