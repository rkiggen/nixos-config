# hardening/firejail.nix: sandboxing via firejail
{ pkgs, ... }: {
    config = {
        environment.systemPackages = [ pkgs.firejail ];
        programs.firejail.enable = true;

        wrappedBinaries = {
            firefox = {
                executable = "${pkgs.firefox}/bin/firefox";
                profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
                desktop = "${pkgs.firefox}/share/applications/firefox.desktop";
                extraArgs = [
                    "--ignore=private-dev"
                    "--dbus-user.talk=org.freedesktop.Notifications"
                ];
            };
        };
    };

    # For example profiles take a look at:
    # https://github.com/chiraag-nataraj/firejail-profiles
    environment.etc."firejail/firefox.local".text = ''   
        # Fix noexec on btrfs home subvolume
        ignore noexec ~
    '';    
}