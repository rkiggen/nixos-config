{ nixpkgs, config, ... }: {
  home.packages = [
    nixpkgs.from.stable.pinentry-gnome
    nixpkgs.from.stable.gnome.seahorse
  ];

  services.gnome-keyring.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    sshKeys = ["D528D50F4E9F031AACB1F7A9833E49C848D6C90"];
    pinentryFlavor = "gnome3";
  };

  programs = {
    gpg = {
      enable = true;
    };
  };
}
