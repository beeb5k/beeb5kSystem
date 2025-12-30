{
  xdg.configFile = {
    "matugen/templates/zen.css" = {
      enable = true;
      text =
        # css
        ''
          @media (prefers-color-scheme: dark) {
            :root {
              --zen-colors-primary: {{colors.on_primary.default.hex}} !important;
              --zen-primary-color: {{colors.primary.default.hex}} !important;
              --zen-colors-secondary: {{colors.surface_bright.default.hex}} !important;
              --zen-colors-tertiary: {{colors.background.default.hex}} !important;
              --zen-colors-border: {{colors.primary.default.hex}} !important;
              --toolbarbutton-icon-fill: {{colors.primary.default.hex}} !important;
              --lwt-text-color: {{colors.on_background.default.hex}} !important;
              --toolbar-field-color: {{colors.on_background.default.hex}} !important;
              --tab-selected-textcolor: rgb(160, 207, 240) !important;
              --toolbar-field-focus-color: {{colors.on_background.default.hex}} !important;
              --toolbar-color: {{colors.on_background.default.hex}} !important;
              --newtab-text-primary-color: {{colors.on_background.default.hex}} !important;
              --arrowpanel-color: {{colors.on_background.default.hex}} !important;
              --arrowpanel-background: {{colors.background.default.hex}} !important;
              --sidebar-text-color: {{colors.on_background.default.hex}} !important;
              --lwt-sidebar-text-color: {{colors.on_background.default.hex}} !important;
              --lwt-sidebar-background-color: {{colors.scrim.default.hex}} !important;
              --toolbar-bgcolor: {{colors.on_primary.default.hex}} !important;
              --newtab-background-color: {{colors.background.default.hex}} !important;
              --zen-themed-toolbar-bg: {{colors.background.default.hex}} !important;
              --zen-main-browser-background: {{colors.background.default.hex}} !important;
              --toolbox-bgcolor-inactive: {{colors.background.default.hex}} !important;
            }

            #permissions-granted-icon {
              color: {{colors.background.default.hex}} !important;
            }

            .sidebar-placesTree {
              background-color: {{colors.background.default.hex}} !important;
            }

            #zen-workspaces-button {
              background-color: {{colors.background.default.hex}} !important;
            }

            #TabsToolbar {
              background-color: {{colors.background.default.hex}} !important;
            }

            #urlbar-background {
              background-color: {{colors.background.default.hex}} !important;
            }

            .content-shortcuts {
              background-color: {{colors.background.default.hex}} !important;
              border-color: {{colors.primary.default.hex}} !important;
            }

            .urlbarView-url {
              color: {{colors.primary.default.hex}} !important;
            }

            #zenEditBookmarkPanelFaviconContainer {
              background: {{colors.scrim.default.hex}} !important;
            }

            #zen-media-controls-toolbar {
              & #zen-media-progress-bar {
                &::-moz-range-track {
                  background: {{colors.surface_bright.default.hex}} !important;
                }
              }
            }

            toolbar .toolbarbutton-1 {
              &:not([disabled]) {
                &:is([open], [checked])
                  > :is(
                    .toolbarbutton-icon,
                    .toolbarbutton-text,
                    .toolbarbutton-badge-stack
                  ) {
                  fill: {{colors.scrim.default.hex}};
                }
              }
            }

            .identity-color-blue {
              --identity-tab-color: #89b4fa !important;
              --identity-icon-color: #89b4fa !important;
            }

            .identity-color-turquoise {
              --identity-tab-color: #94e2d5 !important;
              --identity-icon-color: #94e2d5 !important;
            }

            .identity-color-green {
              --identity-tab-color: #a6e3a1 !important;
              --identity-icon-color: #a6e3a1 !important;
            }

            .identity-color-yellow {
              --identity-tab-color: #f9e2af !important;
              --identity-icon-color: #f9e2af !important;
            }

            .identity-color-orange {
              --identity-tab-color: #fab387 !important;
              --identity-icon-color: #fab387 !important;
            }

            .identity-color-red {
              --identity-tab-color: #f38ba8 !important;
              --identity-icon-color: #f38ba8 !important;
            }

            .identity-color-pink {
              --identity-tab-color: #f5c2e7 !important;
              --identity-icon-color: #f5c2e7 !important;
            }

            .identity-color-purple {
              --identity-tab-color: #cba6f7 !important;
              --identity-icon-color: #cba6f7 !important;
            }

            hbox#titlebar {
              background-color: {{colors.background.default.hex}} !important;
            }

            #zen-appcontent-navbar-container {
              background-color: {{colors.background.default.hex}} !important;
            }
          }
        '';
    };
  };
}
