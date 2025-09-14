{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -a terminal-features "tmux-256color:RGB"
      set -g default-terminal "tmux-256color"
      set -as terminal-overrides ",foot*:RGB:usstyle:ccolor"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
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
