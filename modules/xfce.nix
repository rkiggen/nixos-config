# XFCE desktop environment configuration

{ config, lib, pkgs, nixpkgs, ... }: 
let
    wallpaper = ../assets/wallpaper-bigsur.png;
    blurredWallpaper = pkgs.runCommand "blurred-wallpaper.png" {
        nativeBuildInputs = [ pkgs.imagemagick ];
    } ''
    magick ${wallpaper} -resize 3840x2160^ -gravity center -extent 3840x2160 \
      -blur 0x24 -brightness-contrast -15x0 "$out"
  '';
in
{

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
        # the window manager's function is to manage open windows. Window management involves controlling
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
                    background = "${blurredWallpaper}";
                    greeters.slick = {
                        enable = true;
                        theme = {
                            package = pkgs.whitesur-gtk-theme;
                            name = "WhiteSur-Dark";
                        };
                        iconTheme = {
                            package = pkgs.whitesur-icon-theme;
                            name = "WhiteSur-dark";
                        };
                        cursorTheme = {
                            package = pkgs.whitesur-cursors;
                            name = "WhiteSur-cursors";
                            size = 24;
                        };

                        extraConfig = ''
                            draw-user-backgrounds = true
                            show-hostname = false
                            show-keyboard = false
                            show-a11y = false
                            show-quit = false
                            show-power = true
                            show-clock = true
                            font-name = Inter 11
                        '';
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
        # services.displayManager.defaultSession = "none+i3";

        # Change screensaver to xmatrix | glmatrix from xscreensaver package
        # https://docs.xfce.org/apps/xfce4-screensaver/faq#where_are_all_the_screensavers 
        # location .desktop file should be in ~/.local/share/applications/screensavers !
        environment.etc."xdg/applications/screensavers/xmatrix.desktop".text = ''
            [Desktop Entry]
            Type=Application
            Name=XMatrix
            Exec=${pkgs.xscreensaver}/libexec/xscreensaver/xmatrix -root
            TryExec=${pkgs.xscreensaver}/libexec/xscreensaver/xmatrix
            Categories=Screensaver;
        '';

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
        };

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = [

            # X11/XORG packages
            nixpkgs.from.stable.xscreensaver        # set of screensavers

            # Gtk specific packages
            nixpkgs.from.stable.blueman 		    # GTK based bluetooth manager
            nixpkgs.from.stable.pavucontrol	        # Pulse Audio Volume Control
            nixpkgs.from.stable.file-roller         # Gnome Archive Manager
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

            ## GTK theme: whitesur
            nixpkgs.from.stable.gtk-engine-murrine  # very flexible theme engine
            nixpkgs.from.stable.whitesur-gtk-theme  # MacOS BigSur like Gtk+ theme based on Elegant Design
            nixpkgs.from.stable.whitesur-cursors    # X-cursor theme inspired by macOS and based on capitaine-cursors
            nixpkgs.from.stable.whitesur-icon-theme # MacOS Big Sur style icon theme for Linux desktops

            ## plank dock
            nixpkgs.from.stable.plank               # Elegant, simple, clean dock
            nixpkgs.from.stable.bamf                # Application matching framework

            ## other
            nixpkgs.from.stable.conky               # Advanced, highly configurable system monitor based on torsmo
            nixpkgs.from.stable.variety             # a wallpaper manager for Linux systems
        ];
    };
}

