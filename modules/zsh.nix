# Z shell

{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        # for global user
        users.defaultUserShell = pkgs.zsh; 

        # enable zsh
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

        # Prevent the new user dialog in zsh
        system.userActivationScripts.zshrc = "touch .zshrc";
    };
}

