{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -sg escape-time 0
    '';
  };
}
