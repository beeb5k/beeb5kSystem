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
    pay-respects
    nix-index
    nix-search-cli
  ];

  # Fish configuration ------------------------------------------------------------------------- {{{
  # Configuration that should be above `loginShellInit` and `interactiveShellInit`.
  programs.fish.shellInit = ''
    set -U fish_term24bit 1
  '';

  programs.fish.interactiveShellInit = ''
    set -g fish_greeting ""

    fish_vi_key_bindings
    terminal-change-color
    pokeget random --hide-name

    pay-respects fish | source

    alias fuck='f'
  '';
  # }}}
}
# vim: foldmethod=marker
