# Yazi cli file manager

{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        programs.yazi = {
            enable = true;
        };

        environment.systemPackages = [

            nixpkgs.from.stable.yazi                # terminal file manager
            nixpkgs.from.stable.imagemagick         # software suite to create,edit, compose or convert bitmap images
            nixpkgs.from.stable.ffmpegthumbnailer   # lightweight video thumbnailer
            nixpkgs.from.stable.fontpreview         # highly customizable and minimal font previewer (bash)
            nixpkgs.from.stable.unar                # archive unpacker
            nixpkgs.from.stable.poppler             # PDF rendering library

        ];

    };
}
