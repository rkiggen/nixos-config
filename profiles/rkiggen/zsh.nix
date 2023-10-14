{ config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  # direnv hook
  programs.zsh.initExtra = ''
    eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
    export LIBVIRT_DEFAULT_URI="qemu:///system"
    pfetch
  '';
}
