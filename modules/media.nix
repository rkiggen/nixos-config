# Audio & video: play media
{ pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [

            # audio & video
            nixpkgs.from.stable.vlc

        ];
    };
}
