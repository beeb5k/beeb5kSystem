{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    (inputs.nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default)
  ];

  home.packages = with pkgs; [
    nautilus
  ];

  programs.yazi.enable = true;

  programs.yazi.yaziPlugins = {
    enable = true;
    plugins = {
      full-border.enable = true;
      recycle-bin.enable = true;
      jump-to-char = {
        enable = true;
        keys.toggle.on = ["F"];
      };
    };
  };
}
