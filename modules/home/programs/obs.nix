{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-vkcapture
      # obs-nvfbc # diabling this because it is marked as broken and wont let me rebuild
      obs-move-transition
      obs-pipewire-audio-capture
    ];
  };
}
