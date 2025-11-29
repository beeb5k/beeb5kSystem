{
  config,
  pkgs,
  ...
}:
{
  # Fish Shell
  programs.fish.enable = true;

  # Add Fish plugins
  home.packages = with pkgs; [
    fzf
    # pokeget-rs
    pay-respects
    nix-index
    nix-search-cli
  ];

  programs.fish = {
    shellInit = ''
      set -U fish_term24bit 1
    '';

    interactiveShellInit = /* fish */ ''
      set -g fish_greeting ""

      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert block
      set fish_cursor_visual block
      set fish_cursor_replace_one block
      set fish_cursor_external block
      set fish_vi_force_cursor 1
      # terminal-change-color
      # pokeget random --hide-name

      pay-respects fish | source

      alias fuck='f'
    '';
  };
}
