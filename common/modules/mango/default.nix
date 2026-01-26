{
  homeManager,
  inputs,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mango;
  snip = pkgs.writeShellScript "snip" ''
    case $1 in
      full)
        ${pkgs.grim}/bin/grim - | wl-copy
        ;;
      selection)
        GEOM=$(${pkgs.slurp}/bin/slurp) || exit
        ${pkgs.grim}/bin/grim -g "$GEOM" - | wl-copy
        ;;
    esac
  '';
  smart-alacritty = pkgs.writeShellScript "smart-alacritty" ''
    alacritty msg create-window || alacritty
  '';
in {
  imports =
    if homeManager
    then [
      inputs.mango.hmModules.mango
      ./noctalia.nix
    ]
    else [
      inputs.mango.nixosModules.mango
    ];
  options.mango = {
    enable = lib.mkEnableOption "mango setup";
    noctalia-shell = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable noctalia-shell";
    };
  };

  config = lib.mkIf cfg.enable (
    if homeManager
    then {
      wayland.windowManager.mango = {
        enable = true;
        settings = ''
          # Window effect
          blur=0
          blur_layer=0
          blur_optimized=1
          blur_params_num_passes = 4
          blur_params_radius = 10
          blur_params_noise = 0.02
          blur_params_brightness = 0.9
          blur_params_contrast = 0.9
          blur_params_saturation = 1.2

          shadows = 0
          layer_shadows = 0
          shadow_only_floating = 1
          shadows_size = 10
          shadows_blur = 15
          shadows_position_x = 0
          shadows_position_y = 0
          shadowscolor= 0x000000ff

          border_radius=0
          no_radius_when_single=0
          focused_opacity=1
          unfocused_opacity=1


          # Animation Configuration(support type:zoom,slide)
          # tag_animation_direction: 1-horizontal,0-vertical
          animations=0
          layer_animations=0
          animation_type_open=slide
          animation_type_close=slide
          animation_fade_in=1
          animation_fade_out=1
          tag_animation_direction=1
          zoom_initial_ratio=0.3
          zoom_end_ratio=0.8
          fadein_begin_opacity=0.5
          fadeout_begin_opacity=0.8
          animation_duration_move=500
          animation_duration_open=400
          animation_duration_tag=350
          animation_duration_close=800
          animation_duration_focus=0
          animation_curve_open=0.46,1.0,0.29,1
          animation_curve_move=0.46,1.0,0.29,1
          animation_curve_tag=0.46,1.0,0.29,1
          animation_curve_close=0.08,0.92,0,1
          animation_curve_focus=0.46,1.0,0.29,1
          animation_curve_opafadeout=0.5,0.5,0.5,0.5
          animation_curve_opafadein=0.46,1.0,0.29,1

          # Scroller Layout Setting
          scroller_structs=20
          scroller_default_proportion=0.8
          scroller_focus_center=0
          scroller_prefer_center=0
          edge_scroller_pointer_focus=1
          scroller_default_proportion_single=1.0
          scroller_proportion_preset=0.5,0.8,1.0

          # Master-Stack Layout Setting
          new_is_master=0
          default_mfact=0.55
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
          # syncobj_enable=1
          allow_tearing=2

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

          windowrule=tags:1,appid:foot
          windowrule=tags:1,appid:alacritty
          windowrule=tags:2,appid:zen
          windowrule=tags:2,appid:firefox
          windowrule=tags:3,appid:vesktop
          windowrule=tags:3,appid:discord
          windowrule=tags:4,appid:steam

          # Appearance
          gappih=5
          gappiv=5
          gappoh=5
          gappov=5
          scratchpad_width_ratio=0.8
          scratchpad_height_ratio=0.9
          borderpx=2
          rootcolor=0x201b14ff
          bordercolor=0x444444ff
          focuscolor=0xc9b890ff
          maximizescreencolor=0x89aa61ff
          urgentcolor=0xad401fff
          scratchpadcolor=0x516c93ff
          globalcolor=0xb153a7ff
          overlaycolor=0x14a57cff

          # layout support:
          # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
          tagrule=id:1,layout_name:tile
          tagrule=id:2,layout_name:tile
          tagrule=id:3,layout_name:tile
          tagrule=id:4,layout_name:tile
          tagrule=id:5,layout_name:tile
          tagrule=id:6,layout_name:tile
          tagrule=id:7,layout_name:tile
          tagrule=id:8,layout_name:tile
          tagrule=id:9,layout_name:tile

          # Key Bindings
          # key name refer to `xev` or `wev` command output,
          # mod keys name: super,ctrl,alt,shift,none

          # reload config
          bind=SUPER,r,reload_config

          # menu and terminal

          bind=SUPER,Return,spawn,${smart-alacritty}
          ${lib.optionalString (config.mango.noctalia-shell
            && config.mango.enable) ''
            bind=SUPER,a,spawn,noctalia-shell ipc call launcher toggle
            bind=SUPER,v,spawn,noctalia-shell ipc call launcher clipboard
            bind=SUPER,y,spawn,noctalia-shell ipc call wallpaper toggle
            bind=SUPER,period,spawn,noctalia-shell ipc call launcher emoji
            bind=SUPER,comma,spawn,noctalia-shell ipc call settings toggle
          ''}

          ${lib.optionalString (!config.mango.noctalia-shell) ''
            # bind=SUPER,v,spawn,clipboard
            # bind=SUPER,n,spawn,rofi-b-or-n
            bind=SUPER,a,spawn,rofi -show drun
            bind=SUPER,period,spawn,rofi -show emoji -modi emoji
            bind=SUPER+SHIFT,l,spawn,rofi -show power-menu -modi power-menu:rofi-power-menu
            bind=SUPER,y,spawn,wall-picker
          ''}

          # exit
          bind=SUPER,m,quit
          bind=SUPER,q,killclient,

          # switch window focus
          bind=ALT,h,focusdir,left
          bind=ALT,l,focusdir,right
          bind=ALT,k,focusdir,up
          bind=ALT,j,focusdir,down

          bind=NONE,Print,spawn,${snip} full
          bind=SUPER,Print,spawn,${snip} selection

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
          bind=SUPER,n,switch_layout

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
          bind=CTRL+SHIFT,Up,movewin,+0,-50
          bind=CTRL+SHIFT,Down,movewin,+0,+50
          bind=CTRL+SHIFT,Left,movewin,-50,+0
          bind=CTRL+SHIFT,Right,movewin,+50,+0

          # resizewin
          bind=CTRL+ALT,k,resizewin,+0,-50
          bind=CTRL+ALT,j,resizewin,+0,+50
          bind=CTRL+ALT,h,resizewin,-50,+0
          bind=CTRL+ALT,l,resizewin,+50,+0

          # Volume Control (using wpctl/Pipewire)
          bind=NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          bind=NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          bind=NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

          # Mic Control
          bind=NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

          # Brightness Control (using brightnessctl)
          bind=NONE,XF86MonBrightnessUp,spawn,brightnessctl set +5%
          bind=NONE,XF86MonBrightnessDown,spawn,brightnessctl set 5%-

          # Mouse Button Bindings
          # NONE mode key only work in ov mode
          mousebind=SUPER,btn_left,moveresize,curmove
          mousebind=SUPER,btn_right,moveresize,curresize
          mousebind=NONE,btn_left,toggleoverview,1
          mousebind=NONE,btn_right,killclient,0

          # Axis Bindings
          axisbind=SUPER,UP,viewtoleft_have_client
          axisbind=SUPER,DOWN,viewtoright_have_client

          # layer rule
          layerrule=animation_type_open:zoom,layer_name:rofi
          layerrule=animation_type_close:zoom,layer_name:rofi

          # exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once = /bin/sh -c 'eval $(gnome-keyring-daemon --start --components=secrets,ssh); dbus-update-activation-environment --systemd --all'
          ${lib.optionalString (config.mango.noctalia-shell
            && config.mango.enable) ''
            exec = pkill quickshell ; noctalia-shell
          ''}

          ${lib.optionalString (!config.mango.noctalia-shell) ''
            exec-once = sh ~/.swaybg.sh
          ''}
        '';
      };
      home.packages = with pkgs; [
        wl-clipboard
        swaybg
      ];
    }
    else {
      programs.mango.enable = true;
      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-wlr
        ];
        config = {
          mango = {
            default = ["gtk"];
            "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
            "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
            "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
          };
        };
      };
    }
  );
}
