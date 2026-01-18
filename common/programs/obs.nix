{pkgs, ...}: {
  programs.obs-studio = {
    enable = false;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-vkcapture
      obs-move-transition
      obs-pipewire-audio-capture
    ];
  };
}
