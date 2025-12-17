{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.rust;
in {
  options.rust = {
    enable = mkEnableOption "Rust lang globally";
  };

  config = mkMerge [
    (
      mkIf cfg.enable {
        home.packages = with pkgs; [
          rustlings
          rust-analyzer
          rustc
          cargo
          clippy
          rustfmt
        ];
      }
    )
  ];
}
