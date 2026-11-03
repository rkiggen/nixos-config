# hardening/firejail.nix: sandboxing via firejail
{ pkgs, ... }: {
    config = {
        environment.systemPackages = [ pkgs.firejail ];

        programs.firejail = {
            enable = true;
            wrappedBinaries = {

                claude = {
                    executable = "${pkgs.claude-code}/bin/claude";
                    profile = "${./firejail/claude-code.profile}";
                };

                opencode = {
                    executable = "${pkgs.opencode}/bin/opencode";
                    profile = "${./firejail/opencode.profile}";
                };
            };
        };
    
        # For example profiles take a look at:
        # https://github.com/chiraag-nataraj/firejail-profiles
        # Define non-mutable profiles
        #environment.etc."firejail/firefox.local".text = ''   
        #    # Fix noexec on btrfs home subvolume
        #    ignore noexec ~
        #'';    
    };
}


