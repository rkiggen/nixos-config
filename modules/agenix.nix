# agenix cli: necessary for creating/editing secrets

{ agenix, pkgs, ... }: {

    environment.systemPackages = [
        agenix.packages.${pkgs.system}.default
    ];
    
}
