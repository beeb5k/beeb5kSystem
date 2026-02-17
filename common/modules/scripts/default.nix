{
  homeManager,
  inputs,
  ...
}:
{ pkgs, ... }:
let
  # CHANGED: writeShellScript -> writeShellScriptBin
  volume-control = pkgs.writeShellScriptBin "volume-control" ''
    TAG="audio-volume"

    function get_vol {
      ${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
    }

    case $1 in
      up)   ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ ;;
      down) ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
      mute) ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    esac

    vol=$(get_vol)
    is_muted=$(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep "MUTED")

    if [ -n "$is_muted" ]; then
      ${pkgs.dunst}/bin/dunstify -a "Volume" -u low \
        -h string:x-canonical-private-synchronous:$TAG \
        "Volume: Muted"
    else
      ${pkgs.dunst}/bin/dunstify -a "Volume" -u low \
        -h string:x-canonical-private-synchronous:$TAG \
        -h int:value:"$vol" \
        "Volume: $vol%"
    fi
  '';

  # CHANGED: writeShellScript -> writeShellScriptBin
  brightness-control = pkgs.writeShellScriptBin "brightness-control" ''
    TAG="screen-brightness"

    case $1 in
      up)   ${pkgs.brightnessctl}/bin/brightnessctl set +5% ;;
      down) ${pkgs.brightnessctl}/bin/brightnessctl set 5%- ;;
    esac

    # Get current percentage
    current=$(${pkgs.brightnessctl}/bin/brightnessctl info | grep -oP '\(\K[0-9]+(?=%\))')

    ${pkgs.dunst}/bin/dunstify -a "Brightness" -u low \
      -h string:x-canonical-private-synchronous:$TAG \
      -h int:value:"$current" \
      "Brightness: $current%"
  '';

  # CHANGED: writeShellScript -> writeShellScriptBin
  mic-control = pkgs.writeShellScriptBin "mic-control" ''
    TAG="audio-mic"

    case $1 in
      toggle) ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle ;;
    esac

    is_muted=$(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep "MUTED")

    if [ -n "$is_muted" ]; then
        ${pkgs.dunst}/bin/dunstify -a "Microphone" -u low \
          -h string:x-canonical-private-synchronous:$TAG \
          "Microphone: Muted"
    else
        ${pkgs.dunst}/bin/dunstify -a "Microphone" -u low \
          -h string:x-canonical-private-synchronous:$TAG \
          "Microphone: On"
    fi
  '';
in
{
  home.packages = [
    volume-control
    brightness-control
    mic-control
  ];
}
