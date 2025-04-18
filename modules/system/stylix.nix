{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    targets.grub.enable = false;
    base16Scheme = {
      base00 = "181616";
      base01 = "0d0c0c";
      base02 = "2d4f67";
      base03 = "a6a69c";
      base04 = "7fb4ca";
      base05 = "c5c9c5";
      base06 = "938aa9";
      base07 = "c5c9c5";

      base08 = "c4746e";
      base09 = "e46876";
      base0A = "c4b28a";
      base0B = "8a9a7b";
      base0C = "8ea4a2";
      base0D = "8ba4b0";
      base0E = "a292a3";
      base0F = "7aa89f";
    };
    
    polarity = "dark";
    image = ../../wallpapers/wallpaper.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };

    fonts = {
      sizes = {
        applications = 12;
        terminal = 11;
        desktop = 12;
      };
    };
  };
}
