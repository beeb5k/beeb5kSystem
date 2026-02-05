{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-right ""
      set -g status-left "#S"
      set -g base-index 1
      set -g renumber-windows on
      set -g mode-key vi
      set -sg escape-time 0
      set-option -g status-style bg=default
      set-option -g window-status-current-style "fg=blue bold"
      set -g prefix C-SPACE
    '';
  };
}
