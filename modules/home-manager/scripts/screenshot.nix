{ pkgs }:

pkgs.writeShellScriptBin "screenshot" ''
  # create screenshot dir if it doesn't exist
  if [ ! -d ~/Pictures/Screenshots ]; then
    mkdir -p ~/Pictures/Screenshots
  fi
  grim -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
''
