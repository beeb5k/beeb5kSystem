{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./rofi-theme.nix];

  services.clipcat = {
    enable = config.bspwm.enable;
    daemonSettings = {
      daemonize = true;
      max_history = 50;
      desktop_notification = {
        enable = false;
      };
    };
    menuSettings = {
      server_endpoint = "/run/user/1000/clipcat/grpc.sock";
      finder = "rofi";

      rofi = {
        menu_length = 10;
        line_length = 100;
        menu_prompt = "Clipboard";
        extra_arguments = [];
      };
    };
  };
  programs.rofi = {
    enable = config.bspwm.enable;
    font = "Lilex Nerd Font";
    plugins = with pkgs; [rofi-calc rofi-emoji];
    theme = "~/.config/rofi/themes/config.rasi";
  };
}
