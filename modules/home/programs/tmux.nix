{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g status-position top
      set -sg escape-time 0
      set-option -g status-style bg=default
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix
    '';
  };
}
