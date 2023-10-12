{ config, nixpkgs, ... }: {

  home.packages = [
        nixpkgs.from.stable.bc                  # GNU software calculator
        nixpkgs.from.stable.betterlockscreen    # fast and sweet looking lockscreen for linux systems
  	nixpkgs.from.stable.feh		        # light-weight image viewer
	nixpkgs.from.stable.libnotify		# a library that sends desktop notifications to a notification daemon
        nixpkgs.from.stable.ncmpcpp             # A featureful ncurses based MPD client inspired by ncmpc
        nixpkgs.from.stable.ncpamixer           # An ncurses mixer for PulseAudio inspired by pavucontrol
	nixpkgs.from.stable.light	   	# GNU/Linux application to control backlights	
        nixpkgs.from.stable.lm_sensors          # Tools for reading hardware sensors
        nixpkgs.from.stable.rofi
	nixpkgs.from.stable.scrot	        # a command-line screen capture utility
        nixpkgs.from.stable.yad                 # GUI dialog tool for shell scripts
	nixpkgs.from.stable.zathura	        # a highly customizable and functional PDF viewer
  ];

  services.dunst = {
  	enable = true;
  };

  services.picom = {
  	enable = true;
	activeOpacity = 1.0;
	inactiveOpacity = 0.8;
	backend = "glx";
	fade = true;
	fadeDelta = 5;
	opacityRules = [ "100:name *= 'i3lock'"];
	shadow = true;
	shadowOpacity = 0.75;
  };
}
