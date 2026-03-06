{
  xdg.configFile."wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "swaylock -f -C ~/.config/swaylock/swaylock-colors &";
        text = "  Lock   ";
        keybind = "l";
      }
      {
        label = "logout";
        action = "mmsg -q";
        text = " Logout  ";
        keybind = "m";
      }
      {
        label = "shutdown";
        action = "shutdown -h now";
        text = "Shutdown ";
        keybind = "d";
      }
      {
        label = "reboot";
        action = "reboot";
        text = " Reboot  ";
        keybind = "r";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = " Suspend ";
        keybind = "s";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
    ];
    style = ''
      @import url("colors.css");

      window {
          font-family: HYLeMiaoTiJ, CaskaydiaCove Nerd Font, monospace;
          font-size: 12pt;
          font-weight: bold;
          color: @on_surface; 
          background-color: @surface_bg;
      }

      button {
          background-repeat: no-repeat;
          background-position: center;
          font-size: 40px;
          background-size: 60%;
          border: none;
          color: @primary_accent;
          text-shadow: none;
          border-radius: 20px;
          background-color: transparent;
          margin-top: 120px;
          margin-bottom: 120px;
          transition: all 0.3s cubic-bezier(.55, 0.0, .28, 1.682), box-shadow 0.5s ease-in;
      }

      button:hover {
          background-color: @hover_bg;
          background-size: 80%;
      }

      /* Icon Paths */
      #lock { background-image: image(url("./icons/lock.png")); }
      #logout { background-image: image(url("./icons/logout.png")); }
      #suspend { background-image: image(url("./icons/sleep.png")); } 
      #shutdown { background-image: image(url("./icons/power.png")); }
      #reboot { background-image: image(url("./icons/restart.png")); }
      #hibernate { background-image: image(url("./icons/hibernate.png")); }
    '';
  };
}
