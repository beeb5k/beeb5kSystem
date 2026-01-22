{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    user-templates = ''
      [config]
      [templates.foot]
      input_path = '~/.config/matugen/templates/foot-colors.ini'
      output_path = '~/.config/wal/templates/foot-colors.ini'
    '';
  };
}
