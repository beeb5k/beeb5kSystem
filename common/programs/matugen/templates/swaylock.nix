{
  config,
  pkgs,
  ...
}:
{
  xdg.configFile."matugen/templates/swaylock-colors" = {
    text = ''
      # --- Swaylock Config (Moved from Nix settings) ---
      show-failed-attempts
      indicator-radius=100
      indicator-thickness=7
      line-uses-inside

      # --- Base Colors ---
      color={{colors.background.default.hex}}
      layout-text-color={{colors.on_surface.default.hex}}

      # --- State: Idle (Gray-like ring for visibility) ---
      # Using surface_variant for a distinct but neutral gray ring
      ring-color={{colors.surface_variant.default.hex}}
      inside-color={{colors.surface.default.hex}}
      text-color={{colors.on_surface.default.hex}}

      # Key Highlight (When typing)
      key-hl-color={{colors.primary.default.hex}}
      separator-color={{colors.outline.default.hex}}

      # --- State: Verifying (Pressing Enter) ---
      # Switched to Primary to make the "Enter" state pop
      ring-ver-color={{colors.primary.default.hex}}
      inside-ver-color={{colors.primary_container.default.hex}}
      text-ver-color={{colors.on_primary_container.default.hex}}

      # --- State: Wrong Password ---
      ring-wrong-color={{colors.error.default.hex}}
      inside-wrong-color={{colors.error_container.default.hex}}
      text-wrong-color={{colors.on_error_container.default.hex}}

      # --- State: Backspace / Clear ---
      ring-clear-color={{colors.secondary.default.hex}}
      inside-clear-color={{colors.surface_variant.default.hex}}
      text-clear-color={{colors.on_surface_variant.default.hex}}

      # --- Misc ---
      bs-hl-color={{colors.error.default.hex}}
      caps-lock-key-hl-color={{colors.tertiary.default.hex}}
      caps-lock-bs-hl-color={{colors.error.default.hex}}
    '';
  };
}
