# Console applications

{ inputs, pkgs, nixpkgs, ... }: {

    config = {

        environment.systemPackages = [

            # terminal setup
            nixpkgs.from.stable.alacritty   # cross-platform, GPU-accelerated terminal emulator 
            nixkpgs.from.stable.tmux        # terminal multiplexer
            
            # tools
            nixpkgs.from.stable.btop
            nixpkgs.from.stable.pfetch
            nixpkgs.from.stable.tree
            nixpkgs.from.stable.unzip
            nixpkgs.from.stable.zip
        ];

    };
}
