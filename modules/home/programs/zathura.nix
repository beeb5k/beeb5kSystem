{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      incremental-search = true;
      font = "Hack Nerd font 12";
    };
    extraConfig = ''
      include matugen
    '';
  };
}
