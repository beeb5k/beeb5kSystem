{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    package = (
      pkgs.obs-studio.override {
        browserSupport = false;
        scriptingSupport = false;
        cudaSupport = true;
      }
    );
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };
}
