{ config, pkgs, ...}:

{
  # Enable support for SANE scanners
  hardware.sane = {
    enable = true;
    brscan5 = {
      enable = true;                          # Enable Brother 5 driver support
      netDevices = {
        ads1700w = {
          ip = "10.0.2.102";
          model = "ADS-1700W";
        };
      };
    };
  };

}

