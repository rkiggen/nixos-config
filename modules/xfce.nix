# XFCE desktop environment configuration

{ config, lib, pkgs, nixpkgs, ... }: {

    config = {
        # Apply xserver mappings to virtual console config.
        console.useXkbConfig = true;

        # Configure credential management
        security.pam.services.gdm.enableGnomeKeyring = true;
        services.gnome.gnome-keyring.enable = true;

        # Configure your desktop environment (desktopmanager, displaymanager & windowmanager)
        # Display Server:
        # The display server lies at the base of the desktop environment: the display server's main job
        # is to handle low-lever drawing functions, which means that it draws directly to the screen.
        # Other graphical programs don't directly draw on the screen; instead they send drawing requests
        # to the display server, which draws on the screen for them.

        # X11 and Wayland are the 2 main options of display servers.
        # X.Org server is the open-source implementation of the X Window System X11 display server
        # 
        # Window Manager:
        # the window manager;s function is to manage open windows. Window management involves controlling
        # the size of windows and their positionsn(as requested by you or applications).
        # Some examples of window managers: Kwin (comes with KDE), Mutter (comes with GNOME), Xfwm (Xfce's window manager)
        # 
        # Login Manager (or Display Manager):
        # The login manager is the first graphical program that shows up to give you a list of users so you select one and login.
        # It also gives you the option to choose the desktop environment you want.
        # Most popular login managers: Gdm (GNOME display manager), Kdm (Kde display manager), lightdm (many dekstop environments and 
        # Linux distros come with lightdm because it's very customizable and flexible).
        #
        # Source: https://www.makeuseof.com/difference-display-server-display-manager-window-manager/
        services.xserver = {
            enable = true;
            excludePackages = with pkgs; [
                xterm
            ];
            desktopManager = {
                xterm.enable = false;
                xfce.enable = true;
            };
            displayManager = {
                lightdm = {
                    enable = true;
                    greeters.slick = {
                        enable = true;
                    };
                };
            };

            # Configure keymap in X11
            xkb = {
                layout = "us";
                variant = "altgr-intl";
            };
        };

        services.displayManager.defaultSession = "xfce";

        programs = {
            dconf.enable = true;
            gnupg.agent = {
                enable = true;
                enableSSHSupport = true;
            };
            thunar = {
                enable = true;
                plugins = with pkgs.xfce; [
                    thunar-archive-plugin
                    thunar-media-tags-plugin
                    thunar-volman
                ];
            };
            # enable file-rolle: an archive manager for GNOME
            file-roller = {
                enable = true;
            };
        };

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = [
            # Gtk specific packages
            nixpkgs.from.stable.blueman 		    # GTK based bluetooth manager
            nixpkgs.from.stable.pavucontrol	        # Pulse Audio Volume Control

            nixpkgs.from.stable.evince			    # GNOME's document viewer
            nixpkgs.from.stable.libqalculate		# Adavanced calculator library
            nixpkgs.from.stable.qalculate-gtk       # Ultimate desktop calculator

            # Xfce specific packages
            nixpkgs.from.stable.xfce.catfish
            nixpkgs.from.stable.xfce.gigolo
            nixpkgs.from.stable.xfce.orage
            nixpkgs.from.stable.xfce.xfburn
            nixpkgs.from.stable.xfce.xfce4-appfinder
            nixpkgs.from.stable.xfce.xfce4-clipman-plugin
            nixpkgs.from.stable.xfce.xfce4-cpugraph-plugin
            nixpkgs.from.stable.xfce.xfce4-dict
            nixpkgs.from.stable.xfce.xfce4-fsguard-plugin
            nixpkgs.from.stable.xfce.xfce4-genmon-plugin
            nixpkgs.from.stable.xfce.xfce4-netload-plugin
            nixpkgs.from.stable.xfce.xfce4-panel
            nixpkgs.from.stable.xfce.xfce4-pulseaudio-plugin
            nixpkgs.from.stable.xfce.xfce4-systemload-plugin
            nixpkgs.from.stable.xfce.xfce4-weather-plugin
            nixpkgs.from.stable.xfce.xfce4-whiskermenu-plugin
            nixpkgs.from.stable.xfce.xfce4-xkb-plugin
            nixpkgs.from.stable.xfce.xfdashboard

            # Theming
            nixpkgs.from.stable.arc-theme           # Flat theme with transparent elements for GTK 3, GTK 2 and Gnome Shell
            nixpkgs.from.stable.dracula-icon-theme  # dracula icon theme (dark)
            nixpkgs.from.stable.catppuccin-cursors # Catppuccin cursor theme based on Volantes

        ];
    };
}

