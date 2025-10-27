{
  programs.hyprlock = {
    enable = true;
    sourceFirst = true;
    settings = {
      source = [ "colors.conf" ];
      background = {
        monitor = "";
        # path = "$image";
        color = "$_background";
        # blur_passes = 2;
        # contrast = 1;
        # brightness = 0.5;
        # vibrancy = 0.2;
        # vibrancy_darkness = 0.2;
      };

      general = {
        immediate_render = true;
        hide_cursor = true;
        grace = 5;
      };

      animation = [
        "inputFieldDots, 1, 2, linear"
        "fadeIn, 0"
      ];

      input-field = {
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "$_outline";
        inner_color = "$_surface_container";
        font_color = "$_primary";
        fade_on_empty = false;
        rounding = -1;
        check_color = "$_on_secondary_container";
        # placeholder_text = "<i><span foreground='##cdd6f4'>Enter Password...</span></i>";
        hide_input = false;
        position = "0, -200";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "$_on_background";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
          color = "$_on_background";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
