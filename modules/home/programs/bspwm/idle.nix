{
  pkgs,
  config,
  ...
}: {
  services.screen-locker = {
    enable = false;
    inactiveInterval = 10;
    lockCmd = "sh ${config.home.homeDirectory}/.config/i3lock-color.sh";
    xss-lock.extraOptions = ["--transfer-sleep-lock"];
  };

  home.packages = with pkgs; [
    i3lock-color
  ];
}
