{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.beeMods.mango.enable {
    xdg.configFile."matugen/templates/colors-xresources" = {
      text = ''
        dwm.normbordercolor : {{colors.outline.default.hex}}
        dwm.normfgcolor : {{colors.on_surface.default.hex}}
        dwm.selbordercolor : {{colors.primary.default.hex}}
        dwm.selfgcolor : {{colors.primary.default.hex}}
        dmenu.foreground : {{colors.on_surface.default.hex}}
        dmenu.selbackground : {{colors.primary.default.hex}}
        dmenu.selforeground : {{colors.on_primary.default.hex}}
        <* if {{ is_dark_mode }} *>
        dmenu.background : {{colors.background.default.hex}}
        st.background: {{colors.surface.default.hex}}
        dwm.normbgcolor : {{colors.surface.default.hex}}
        dwm.selbgcolor : {{colors.surface_container.default.hex}}
        <* else *>
        dmenu.background : {{colors.surface_container.default.hex}}
        st.background: {{colors.surface_container.default.hex}}
        dwm.normbgcolor : {{colors.surface_container.default.hex}}
        dwm.selbgcolor : {{colors.secondary_fixed.default.hex}}
        <* endif *>

        st.foreground: {{colors.on_surface.default.hex}}
        st.cursorColor: {{colors.primary.default.hex}}

        st.color0: {{dank16.color0.default.hex}}
        st.color8: {{dank16.color8.default.hex}}

        st.color1: {{dank16.color1.default.hex}}
        st.color9: {{dank16.color9.default.hex}}

        st.color2: {{dank16.color2.default.hex}}
        st.color10: {{dank16.color10.default.hex}}

        st.color3: {{dank16.color3.default.hex}}
        st.color11: {{dank16.color11.default.hex}}

        st.color4: {{dank16.color4.default.hex}}
        st.color12: {{dank16.color12.default.hex}}

        st.color5: {{dank16.color5.default.hex}}
        st.color13: {{dank16.color13.default.hex}}

        st.color6: {{dank16.color6.default.hex}}
        st.color14: {{dank16.color14.default.hex}}

        st.color7: {{dank16.color7.default.hex}}
        st.color15: {{dank16.color15.default.hex}}
      '';
    };
  };
}
