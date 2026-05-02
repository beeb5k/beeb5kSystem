{
  homeManager,
  inputs,
  moduleNameSpace,
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.${moduleNameSpace}.windowManagers;
  snip = pkgs.writeShellScript "snip" ''
    case $1 in
      full)
        ${pkgs.grim}/bin/grim - | wl-copy
        ;;
      selection)
        GEOM=$(${pkgs.slurp}/bin/slurp) || exit
        ${pkgs.grim}/bin/grim -g "$GEOM" - | wl-copy
        ;;
      window)
        ${pkgs.grim}/bin/grim -g "$(mmsg -x | awk '
          / x / {x=$3}
          / y / {y=$3}
          / width / {w=$3}
          / height / {h=$3}
          END {print x "," y " " w "x" h}
          ')" - | wl-copy
        ;;
    esac
  '';
  smart-alacritty = pkgs.writeShellScript "smart-alacritty" ''
    alacritty msg create-window || exec alacritty
  '';
  smart-ghostty = pkgs.writeShellScript "smart-ghostty" ''
    ghostty +new-window || exec ghostty
  '';
  terminal =
    if config.beeMods.terminal.default == "alacritty" then
      smart-alacritty
    else if config.beeMods.terminal.default == "ghostty" then
      smart-ghostty
    else
      config.beeMods.terminal.default;
in
{
  imports =
    if homeManager then [ inputs.mango.hmModules.mango ] else [ inputs.mango.nixosModules.mango ];

  config = lib.mkIf cfg.mango.enable (
    if homeManager then
      {
        wayland.windowManager.mango = {
          enable = true;
          systemd.enable = true;
          systemd.variables = [ "--all" ];
          extraConfig = ''
            ${lib.optionalString (config.beeMods.matugen.enable) ''
              source=~/.config/mango/mango-colors.conf
            ''}

            # Window effect
            blur=${if cfg.eyeCandy.window.blur.enable then "1" else "0"}
            blur_layer=0
            blur_optimized=1
            blur_params_num_passes = ${toString cfg.eyeCandy.window.blur.passes}
            blur_params_radius = ${toString cfg.eyeCandy.window.blur.radius}
            blur_params_noise = 0.02
            blur_params_brightness = 0.9
            blur_params_contrast = 0.9
            blur_params_saturation = 1.2

            shadows=${if cfg.eyeCandy.window.shadows.enable then "1" else "0"}
            layer_shadows = 0
            shadow_only_floating = 1
            shadows_size = 10
            shadows_blur = 15
            shadows_position_x = 0
            shadows_position_y = 0

            border_radius=${toString cfg.eyeCandy.window.borderRadius}
            no_radius_when_single=0

            ${
              if (cfg.eyeCandy.window.blur.enable && cfg.eyeCandy.window.opacity == 1.0) then
                ''
                  focused_opacity=0.82
                  unfocused_opacity=0.82
                ''
              else
                ''
                  focused_opacity=${toString cfg.eyeCandy.window.opacity}
                  unfocused_opacity=${toString cfg.eyeCandy.window.opacity}
                ''
            }

            # Animation Configuration(support type:zoom,slide)
            # tag_animation_direction: 1-horizontal,0-vertical
            animations=${if cfg.eyeCandy.animations.enable then "1" else "0"}
            layer_animations=0
            animation_type_open=slide
            animation_type_close=zoom
            animation_fade_in=0
            animation_fade_out=1
            tag_animation_direction=1
            zoom_initial_ratio=0.8
            zoom_end_ratio=0.8
            fadein_begin_opacity=0.5
            fadeout_begin_opacity=0.5
            animation_duration_move=250
            animation_duration_open=250
            animation_duration_tag=250
            animation_duration_close=100
            animation_duration_focus=0
            animation_curve_open=0.05,0.7,0.1,1.0
            animation_curve_move=0.46,1.0,0.29,1
            animation_curve_tag=0.46,1.0,0.29,1
            animation_curve_close=0.0,0.0,1.0,1.0
            animation_curve_focus=0.05,0.7,0.1,1.0
            animation_curve_opafadeout=0.5,0.5,0.5,0.5
            animation_curve_opafadein=0.46,1.0,0.29,1

            # Scroller configuration
            scroller_structs=15
            scroller_default_proportion=0.6
            scroller_focus_center=0
            scroller_prefer_center=0
            edge_scroller_pointer_focus=1
            scroller_default_proportion_single=1.0
            scroller_ignore_proportion_single=0
            scroller_proportion_preset=0.5,0.8,1.0

            # Master-Stack Layout Setting
            new_is_master=0
            default_mfact=0.56
            default_nmaster=1
            smartgaps=0

            # Overview Setting
            hotarea_size=10
            enable_hotarea=0
            ov_tab_mode=0
            overviewgappi=5
            overviewgappo=30

            # Misc
            no_border_when_single=0
            axis_bind_apply_timeout=100
            focus_on_activate=1
            idleinhibit_ignore_visible=0
            sloppyfocus=1
            warpcursor=1
            focus_cross_monitor=0
            focus_cross_tag=0
            enable_floating_snap=0
            snap_distance=30
            # cursor_size=24
            drag_tile_to_tile=1
            xwayland_persistence=0
            syncobj_enable=0
            allow_tearing=0

            # keyboard
            repeat_delay=300;
            repeat_rate=50;
            numlockon=0
            xkb_rules_layout=us

            # Trackpad
            # need relogin to make it apply
            disable_trackpad=0
            tap_to_click=1
            tap_and_drag=1
            drag_lock=1
            trackpad_natural_scrolling=1
            disable_while_typing=1
            left_handed=0
            middle_button_emulation=0
            swipe_min_threshold=1

            # mouse
            # need relogin to make it apply
            mouse_natural_scrolling=0

            windowrule=tags:1,appid:^(foot|footclient|alacritty|dev.zed.Zed)$
            windowrule=tags:2,appid:^(zen|firefox|obsidian)$
            windowrule=tags:3,appid:^(vesktop|discord|thunderbird|Element|equibop)$
            windowrule=tags:4,appid:^steam$

            windowrule=scroller_proportion:0.3,appid:^steam$,title:^Friends List$
            windowrule=scroller_proportion:0.5,appid:^steam$,title:.*(Settings|Properties).*
            windowrule=isfloating:1,appid:^steam$,title:^Steam - News$
            windowrule=isfloating:1,appid:^(org.gnome.Calculator|org.pulseaudio.pavucontrol)$
            windowrule=isoverlay:1,appid:^com.gabm.satty$

            # Appearance
            gappih=5
            gappiv=5
            gappoh=5
            gappov=5
            scratchpad_width_ratio=0.8
            scratchpad_height_ratio=0.9
            borderpx=2

            # layout support:
            # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
            tagrule=id:1,layout_name:tgmix
            tagrule=id:2,layout_name:scroller
            tagrule=id:3,layout_name:scroller
            tagrule=id:4,layout_name:scroller
            tagrule=id:5,layout_name:grid
            tagrule=id:6,layout_name:tile
            tagrule=id:7,layout_name:tile
            tagrule=id:8,layout_name:tile
            tagrule=id:9,layout_name:tile

            # Key Bindings
            # key name refer to `xev` or `wev` command output,
            # mod keys name: super,ctrl,alt,shift,none

            # reload config
            bind=SUPER,r,reload_config

            bind=SUPER,Return,spawn,${terminal}

            bind=SUPER,v,spawn,dms ipc call clipboard toggle
            bind=SUPER,a,spawn,dms ipc call spotlight toggle
            bind=ALT,F4,spawn,dms ipc call powermenu toggle
            bind=SUPER,y,spawn,dms ipc call dankdash wallpaper
            bind=SUPER,comma,spawn,dms ipc call settings focusOrToggle

            bind=SUPER,F12,spawn,gnome-calculator
            bind=SUPER,b,spawn,zen
            bind=SUPER,e,spawn,nautilus

            # exit
            bind=SUPER,m,quit
            bind=SUPER,q,killclient,

            # switch window focus
            bind=SUPER,h,focusdir,left
            bind=SUPER,l,focusdir,right
            bind=SUPER,k,focusdir,up
            bind=SUPER,j,focusdir,down

            bind=NONE,Print,spawn,${snip} full
            bind=SUPER,Print,spawn,${snip} selection
            bind=SUPER+SHIFT,Print,spawn,${snip} window

            # swap window
            bind=SUPER+SHIFT,k,exchange_client,up
            bind=SUPER+SHIFT,j,exchange_client,down
            bind=SUPER+SHIFT,h,exchange_client,left
            bind=SUPER+SHIFT,l,exchange_client,right

            # switch window status
            bind=SUPER,g,toggleglobal,
            bind=ALT,Tab,toggleoverview,
            bind=SUPER,space,togglefloating,
            bind=ALT,a,togglemaximizescreen,
            bind=SUPER,f,toggle_all_floating,
            bind=ALT,f,togglefullscreen,
            bind=ALT+SHIFT,f,togglefakefullscreen,
            bind=SUPER,i,minimized,
            bind=SUPER,o,toggleoverlay,
            bind=SUPER+SHIFT,I,restore_minimized
            bind=ALT,z,toggle_scratchpad

            # scroller layout
            bind=ALT,e,set_proportion,1.0
            bind=ALT,x,switch_proportion_preset,

            # switch layout
            # bind=SUPER,n,switch_layout
            bind=SUPER,n,spawn,dms ipc call notifications toggle

            # tag switch
            bind=SUPER,1,view,1,0
            bind=SUPER,2,view,2,0
            bind=SUPER,3,view,3,0
            bind=SUPER,4,view,4,0
            bind=SUPER,5,view,5,0
            bind=SUPER,6,view,6,0
            bind=SUPER,7,view,7,0
            bind=SUPER,8,view,8,0
            bind=SUPER,9,view,9,0

            # tag: move client to the tag and focus it
            # tagsilent: move client to the tag and not focus it
            # bind=Alt,1,tagsilent,1
            bind=SUPER+SHIFT,1,tag,1,0
            bind=SUPER+SHIFT,2,tag,2,0
            bind=SUPER+SHIFT,3,tag,3,0
            bind=SUPER+SHIFT,4,tag,4,0
            bind=SUPER+SHIFT,5,tag,5,0
            bind=SUPER+SHIFT,6,tag,6,0
            bind=SUPER+SHIFT,7,tag,7,0
            bind=SUPER+SHIFT,8,tag,8,0
            bind=SUPER+SHIFT,9,tag,9,0

            # monitor switch
            bind=alt+shift,Left,focusmon,left
            bind=alt+shift,Right,focusmon,right
            bind=SUPER+Alt,Left,tagmon,left
            bind=SUPER+Alt,Right,tagmon,right

            # gaps
            bind=ALT+SHIFT,X,incgaps,1
            bind=ALT+SHIFT,Z,incgaps,-1
            bind=ALT+SHIFT,R,togglegaps

            # movewin
            bind=SUPER,Up,movewin,+0,-50
            bind=SUPER,Down,movewin,+0,+50
            bind=SUPER,Left,movewin,-50,+0
            bind=SUPER,Right,movewin,+50,+0

            # resizewin
            bind=ALT,k,resizewin,+0,-50
            bind=ALT,j,resizewin,+0,+50
            bind=ALT,h,resizewin,-50,+0
            bind=ALT,l,resizewin,+50,+0

            # Volume Control (using wpctl/Pipewire)
            bind=NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
            bind=NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            bind=NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

            bind=NONE,XF86AudioPlay,spawn,playerctl play-pause
            bind=NONE,XF86AudioNext,spawn,playerctl next
            bind=NONE,XF86AudioPrev,spawn,playerctl previous
            bind=NONE,XF86AudioStop,spawn,playerctl stop

            bind=NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

            bind=NONE,XF86MonBrightnessUp,spawn,brightnessctl set +5%
            bind=NONE,XF86MonBrightnessDown,spawn,brightnessctl set 5%-

            mousebind=SUPER,btn_left,moveresize,curmove
            mousebind=NONE,btn_middle,togglemaximizescreen,0
            mousebind=SUPER,btn_right,moveresize,curresize

            axisbind=SUPER,UP,viewtoleft_have_client
            axisbind=SUPER,DOWN,viewtoright_have_client

            layerrule=noanim:1,layer_name:^dms

            env=NIXOS_OZONE_WL,1
            env=QT_AUTO_SCREEN_SCALE_FACTOR,1
            env=ELECTRON_OZONE_PLATFORM_HINT,auto
            env=QT_QPA_PLATFORM,wayland
            env=XDG_SESSION_TYPE,wayland
            env=GDK_BACKEND,wayland,x11
            env=GDK_SCALE,1
          '';
          autostart_sh = ''
            wl-paste --type text --watch cliphist store &
            gnome-keyring-daemon --start --components=secrets,ssh,pkcs11 &

            ${lib.optionalString (config.beeMods.windowManagers.dwm.enable) ''
              systemctl --user stop xidlehook.service
              systemctl --user stop xautolock-session.service
              systemctl --user stop xss-lock.service
              systemctl --user stop clipcat.service
            ''}
          '';
        };
      }
    else
      {
        programs.mango.enable = true;
      }
  );
}
