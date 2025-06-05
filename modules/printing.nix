# Setup printing via CUPS
# https://nixos.wiki/wiki/Printing

{ pkgs, nixpkgs, ... }: {

    config = {

        # Enable CUPS to print documents
        services.printing = {
            enable = true;
            drivers = [ pkgs.canon-cups-ufr2 ]; # Canon i-Sensys MFC645cx
            browsing = true;
            extraConf = ''
                DefaultPaperSize A4
            '';
        };

        services.avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;

            # Necessary for detecting the scanner
            publish = {
                enable = true;
                addresses = true;
                userServices = true;
            };
        };

        # Add printers
        # hardware.printers = {
        #     ensurePrinters = [
        #         {
        #             name = "Canon_MFC645cx";
        #             location = "Home";
        #             deviceUri = "usb://Dell/1250c%20Color%20Printer?serial=YNP023240";
        #             model = "Dell-1250c.ppd.gz";
        #             ppdOptions = {
        #                 PageSize = "A4";
        #             };
        #         }
        #     ];
        #     ensureDefaultPrinter = "Canon_MFC645cx";
        # };

    };
}