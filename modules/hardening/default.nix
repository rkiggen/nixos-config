# modules/hardening/default.nix
{ imports = [ ./antivirus.nix ./firewall.nix ./firejail.nix ]; }