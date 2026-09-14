# Utilities: filesharing, security tools & windows compatibility
{ pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [
            
            # filesharing
            nixpkgs.from.stable.deluge                              # torrent client
                       
            # security
            nixpkgs.from.stable.keepassxc                           # password manager
            nixpkgs.from.stable.veracrypt                           # file encryption

            #  windows compatibility
            nixpkgs.from.stable.wineWow64Packages.stable            # open source implementation of the Windows API on top of X, OpenGL, and Unix 
            nixpkgs.from.stable.winetricks             
        ];
    };
}
