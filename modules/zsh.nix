# Z shell

{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        programs.zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;

            shellAliases = {
                ll = "ls -l";
                update = "sudo nixos-rebuild switch";
            };
            histSize = 10000;
        };

    };
}

