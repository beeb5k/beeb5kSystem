{
  xdg.configFile = {
    "matugen/templates/zen.css" = {
      enable = true;
      text =
        # css
        ''
          :root {
            /* --- Matugen Colors (UI) --- */
            --zen-primary-color: {{colors.primary_container.default.hex}} !important;
            --toolbarbutton-icon-fill: {{colors.primary.default.hex}} !important;
            --toolbar-field-color: {{colors.on_background.default.hex}} !important;
            --tab-selected-textcolor: {{colors.primary.default.hex}} !important;
            --toolbar-color: {{colors.on_background.default.hex}} !important;
            --arrowpanel-color: {{colors.on_surface.default.hex}} !important;
            --arrowpanel-background: {{colors.surface_container.default.hex}} !important;
            --sidebar-text-color: {{colors.on_background.default.hex}} !important;
            /* --zen-main-browser-background: {{colors.background.default.hex}} !important; */
          }

          .sidebar-placesTree {
            background-color: {{colors.surface_container.default.hex}} !important;
          }

          #zen-workspaces-button {
            background-color: {{colors.surface_container.default.hex}} !important;
          }

          #TabsToolbar {
            background-color: {{colors.background.default.hex}} !important;
          }

          .urlbar-background {
            background-color: {{colors.surface_container.default.hex}} !important;
          }

          .urlbar-input::selection {
            color: {{colors.on_primary.default.hex}} !important;
            background-color: {{colors.primary.default.hex}} !important;
          }

          .urlbarView-url {
            color: {{colors.on_surface_variant.default.hex}} !important;
          }

          toolbar .toolbarbutton-1 {
            &:not([disabled]) {
              &:is([open], [checked])
                > :is(
                  .toolbarbutton-icon,
                  .toolbarbutton-text,
                  .toolbarbutton-badge-stack
                ) {
                fill: {{colors.primary.default.hex}}
              }
            }
          }

          .identity-color-blue {
            --identity-tab-color: \{{color12}} !important;
            --identity-icon-color: \{{color12}} !important;
          }

          .identity-color-turquoise {
            --identity-tab-color: \{{color6}} !important;
            --identity-icon-color: \{{color6}} !important;
          }

          .identity-color-green {
            --identity-tab-color: \{{color10}} !important;
            --identity-icon-color: \{{color10}} !important;
          }

          .identity-color-yellow {
            --identity-tab-color: \{{color11}} !important;
            --identity-icon-color: \{{color11}} !important;
          }

          .identity-color-orange {
            --identity-tab-color: \{{color3}} !important;
            --identity-icon-color: \{{color3}} !important;
          }

          .identity-color-red {
            --identity-tab-color: \{{color9}} !important;
            --identity-icon-color: \{{color9}} !important;
          }

          .identity-color-pink {
            --identity-tab-color: \{{color13}} !important;
            --identity-icon-color: \{{color13}} !important;
          }

          .identity-color-purple {
            --identity-tab-color: \{{color5}} !important;
            --identity-icon-color: \{{color5}} !important;
          }

          #zen-appcontent-navbar-container {
            background-color: {{colors.background.default.hex}} !important;
          }
        '';
    };
  };
}
