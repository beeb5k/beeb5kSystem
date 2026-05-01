homeManager:
{ pkgs, lib, ... }:
let
  sync_dms = pkgs.writeShellScriptBin "sync_dms" ''
    jq=${pkgs.jq}/bin/jq
    CONFIG_FILE=$HOME/.local/state/DankMaterialShell/session.json

    get_val() { $jq -r ".$1" "$CONFIG_FILE"; }
    set_val() {
      local tmp=$(mktemp)
      $jq --arg val "$2" ".$1 = \$val" "$CONFIG_FILE" > "$tmp" && mv "$tmp" "$CONFIG_FILE"
    }


    function sync_all {
      ISNIGHTMODE=$(get_val "nightModeEnabled")
      NIGHTMODETEMP=$(get_val "nightModeTemperature")
      WALL=$(get_val "wallpaperPath")
      ${pkgs.xwallpaper}/bin/xwallpaper --zoom "$WALL"

      if [[ "$ISNIGHTMODE" == "true" ]]; then
        echo "bitch $ISNIGHTMODE"
        ${pkgs.redshift}/bin/redshift -o "$NIGHTMODETEMP"
      else
        ${pkgs.redshift}/bin/redshift -x
      fi
    }

    function dmenu_settings {
      ISNIGHTMODE=$(get_val "nightModeEnabled")
      options="NightMode (Currently $ISNIGHTMODE)\nSync Now"

      choice=$(echo -e "$options" | dmenu -p "Settings:")

      case "$choice" in
        *"NightMode"*)
          if [[ "$ISNIGHTMODE" == "true" ]]; then
            set_val "nightModeEnabled" "false"
          else
            set_val "nightModeEnabled" "true"
          fi
          sync_all
          ;;
        "Sync Now")
          sync_all
          ;;
      esac
    }

    case "$1" in
      settings) dmenu_settings ;;
      *)        sync_all ;;
    esac
  '';
  logout_dmenu = pkgs.writeShellScriptBin "logout_dmenu" ''
    options="Lock\nLogout\nReboot\nShutdown"

    choice=$(echo -e "$options" | dmenu -p "System:")

    case "$choice" in
      Lock)     slock ;;
      Logout)   pkill dwm ;;
      Reboot)   reboot ;;
      Shutdown) poweroff ;;
      *)        exit 1 ;;
    esac
  '';
in
{
  config = lib.mkIf homeManager (
    lib.optionalAttrs homeManager {
      home.packages = with pkgs; [
        sync_dms
        logout_dmenu
      ];
    }
  );
}
