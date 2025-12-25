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
        #             location = "Ofice";
        #             deviceUri = "ipp://Canona9afc7.ad.essential-it.be/ipp";
        #             model = "CNRCUPSMF645CZK.ppd";  # Location of the ppd driver file for the printer. lpinfo -m shows a list of supported models.
        #             ppdOptions = {
        #                 Duplex = "DuplexNoTumble";
        #                 PageSize = "A4";
        #             };
        #         }
        #     ];
        #     ensureDefaultPrinter = "Canon_MFC645cx";
        # };

    };
}