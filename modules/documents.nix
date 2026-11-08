# Creating/viewing/editing documents
{ pkgs, nixpkgs, ... }: {

    config = {
        environment.systemPackages = [

            # documents
            nixpkgs.from.stable.calibre							    # ebook reader
            nixpkgs.from.stable.foliate							    # ebook reader
            nixpkgs.from.stable.evince
            nixpkgs.from.stable.libreoffice							# office suite (microsoft office alternative)
            # nixpkgs.from.stable.masterpdfeditor					    # pdf editor
            nixpkgs.from.stable.meld                                # visual diff and merge tool
            nixpkgs.from.stable.zathura                             # pdf viewer

            # spelling
            nixpkgs.from.stable.hunspell                            # Spell checker
            nixpkgs.from.stable.hunspellDicts.en_US                 # Hunspell dictionary for English (United States) from Wordlist
            nixpkgs.from.stable.hunspellDicts.nl_nl                 # Hunspell dictionary for Dutch (Netherlands) from OpenTaal
        ];
    };
}
