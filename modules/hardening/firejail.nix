# hardening/firejail.nix: sandboxing via firejail
{ pkgs, ... }: {
    config = {
        environment.systemPackages = [ pkgs.firejail ];
        programs.firejail.enable = true;
    };
}