# Graphics: drawing / image manipulation
{ pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [

            # drawing / image manipulation
            nixpkgs.from.stable.pinta                               # drawing/editing program modeled after Paint.NET
            nixpkgs.from.stable.inkscape-with-extensions            # vector graphics editor
        
        ];
    };
}
