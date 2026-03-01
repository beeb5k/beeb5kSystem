{
  homeManager,
  inputs,
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dwm;
in
{
  imports =
    if homeManager then
      [
        ./picom.nix
      ]
    else
      [ ];

  options.dwm = {
    enable = lib.mkEnableOption "dwm setup";
  };

  config = lib.mkIf cfg.enable (
    if !homeManager then
      {
        environment.systemPackages = with pkgs; [
          feh
          maim
          slop
          xdotool
          xclip
          (st.overrideAttrs (oldAttrs: rec {
            patches = map pkgs.fetchpatch [
              # {
              #   url = "https://st.suckless.org/patches/scrollback/st-scrollback-ringbuffer-0.9.2.diff";
              #   sha256 = "sha256-/AoHajojVUAAqF4iKbN1lGM6h9PhZxCbMfAS2PRvbDE=";
              # }
              {
                url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff";
                sha256 = "sha256-ZypvRONAHS//wnZjivmqpWIqZlKTqAQ0Q8DhQpZVaqU=";
              }
              {
                url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.9.2.diff";
                sha256 = "sha256-CuNJ5FdKmAtEjwbgKeBKPJTdEfJvIdmeSAphbz0u3Uk=";
              }
              {
                url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20220127-2c5edf2.diff";
                sha256 = "sha256-8oVLgbsYCfMhNEOGadb5DFajdDKPxwgf3P/4vOXfUFo=";
              }
              {
                url = "https://st.suckless.org/patches/xresources/st-xresources-20230320-45a15676.diff";
                sha256 = "sha256-WcL9IeyanXFiOFDGGRU0QNT8DU7wSo2o+3n+TaqASUY=";
              }
              {
                url = "https://st.suckless.org/patches/vertcenter/st-vertcenter-20231003-eb3b894.diff";
                sha256 = "sha256-RbFNdGNi5HLAp1s8QOX3qsfxpkLcp1p/vksyZORN/uc=";
              }
              {
                url = "https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff";
                hash = "sha256-yx9VSwmPACx3EN3CAdQkxeoJKJxQ6ziC9tpBcoWuWHc=";
              }
              {
                url = "https://st.suckless.org/patches/csi_22_23/st-csi_22_23-0.8.5.diff";
                hash = "sha256-+izEkGVkLCbhZNBD2WN4uX5j+YMmou7JaMVmPG0mrYk=";
              }
              {
                url = "https://st.suckless.org/patches/sync/st-appsync-20200618-b27a383.diff";
                sha256 = "sha256-lys7/nup7a+GcmW+CutX0kjmbbOis2stkuhw02beuPs=";
              }
              {
                url = "https://st.suckless.org/patches/fix_keyboard_input/st-fix-keyboard-input-20180605-dc3b5ba.diff";
                sha256 = "sha256-h5ZrCj4IrkMQanLSMmgXaRd7qZYqvbzqUnuFt/axsMI=";
              }
              {
                url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
                sha256 = "sha256-WN/R6dPuw1eviHOvVVBw2VBSMDtfi1LCkXyX36EJKi4=";
              }
            ];
            postPatch = oldAttrs.postPatch or "" + ''
              sed -i 's/Button4, *kscrollup, *{.i = 1}/Button4, kscrollup, {.i = 5}/g' config.def.h
              sed -i 's/Button5, *kscrolldown, *{.i = 1}/Button5, kscrolldown, {.i = 5}/g' config.def.h

              sed -i 's/const int boxdraw = 0;/const int boxdraw = 1;/g' config.def.h
              sed -i 's/const int boxdraw_bold = 0;/const int boxdraw_bold = 1;/g' config.def.h
              # sed -i 's/const int boxdraw_braille = 0;/const int boxdraw_braille = 1;/g' config.def.h
            '';
          }))
        ];

        services.xserver = {
          enable = true;
          autoRepeatDelay = 300;
          autoRepeatInterval = 20;
          excludePackages = with pkgs; [ xterm ];
          displayManager = {
            startx.enable = true;
          };
          windowManager.dwm = {
            enable = true;
            package =
              (pkgs.dwm.override {
                conf = ./config.h;
                patches = map pkgs.fetchpatch [
                  {
                    url = "https://dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.4.diff";
                    sha256 = "sha256-+OXRqnlVeCP2Ihco+J7s5BQPpwFyRRf8lnVsN7rm+Cc=";
                  }
                  {
                    url = "https://dwm.suckless.org/patches/attachaside/dwm-attachaside-6.6.diff";
                    sha256 = "sha256-xxRnyk0/go9HJHrrGuGlWmDXKh/MmNRLClpk1/dY9gg=";
                  }
                  {
                    url = "https://dwm.suckless.org/patches/actualfullscreen/dwm-actualfullscreen-20211013-cb3f58a.diff";
                    sha256 = "sha256-vsTuudJCy7Zo1wdwpI/nY7Zu1txXx90QoDfJLmfDUH8=";
                  }
                  {
                    url = "https://dwm.suckless.org/patches/xcursor/dwm-xcursor-20250909-74edc27.diff";
                    hash = "sha256-vUPP6oLrGgzUKokxzvYyz7Kcx0IrE4LRLsNvwX/VG1M=";
                  }
                  {
                    url = "https://dwm.suckless.org/patches/autostart/dwm-autostart-20210120-cb3f58a.diff";
                    sha256 = "sha256-mrHh4o9KBZDp2ReSeKodWkCz5ahCLuE6Al3NR2r2OJg=";
                  }
                  {
                    url = "https://raw.githubusercontent.com/bakkeby/patches/master/dwm/dwm-focusdir-6.2.diff";
                    sha256 = "sha256-KMZBgccoWnkTFr8ubJWa4tCKLK5X1CcJH1GE4EB9cYk=";
                  }
                ];
              }).overrideAttrs
                (oldAttrs: rec {
                  version = "6.8";
                  src = pkgs.fetchzip {
                    url = "https://dl.suckless.org/dwm/dwm-${version}.tar.gz";
                    hash = "sha256-mkMFmqV9NVGTdDGqW8f+T7r0YQNU1KDsn6uRcacoNco=";
                  };

                  buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ pkgs.libxcursor ];
                });
          };
        };
      }
    else
      {
        home.file.".dwm/autostart.sh" = {
          executable = true;
          text = ''
            #!${pkgs.bash}/bin/bash

            eval $(gnome-keyring-daemon --start --components=secrets,ssh)
            dbus-update-activation-environment --systemd --all &

            # xsetroot -cursor_name left_ptr &

            if [ -f ~/.fehbg ]; then
              sh ~/.fehbg &
            fi

            [ -f ~/.Xresources ] && xrdb -merge ~/.Xresources &
            # xrandr --output eDP --set TearFree on

            ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &

            dunst &
            clipcatd
            ${lib.optionalString (config.services.picom.enable) ''
              systemctl --user restart picom.service
            ''}
          '';
        };

        services.clipcat = {
          enable = config.dwm.enable;
          daemonSettings = {
            daemonize = false;
            max_history = 50;
            desktop_notification = {
              enable = false;
            };
          };
          menuSettings = {
            server_endpoint = "/run/user/1000/clipcat/grpc.sock";
            finder = "rofi";

            rofi = {
              menu_length = 10;
              line_length = 100;
              menu_prompt = "Clipboard";
              extra_arguments = [ ];
            };
          };
        };

        xresources.extraConfig = ''
          #include "${config.xdg.configHome}/x11/matugen_st.Xresources"
        '';
        xresources.properties = {
          "Xft.dpi" = 96;
          "Xft.autohint" = 0;
          "Xft.antialias" = true;
          "Xft.hinting" = true;
          "Xft.lcdfilter" = "lcddefault";
          "Xft.hintstyle" = "hintfull";
          "Xft.rgba" = "rgb";
          "st.font" =
            "${config.terminal.font.family}:size=${toString config.terminal.font.size}:antialias=true:autohint=true";
          "st.borderpx" = 5;
        };
      }
  );
}
