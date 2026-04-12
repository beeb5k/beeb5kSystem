{
<<<<<<< HEAD
  config,
=======
>>>>>>> 1bb4948 (This is like that one dream you don't know how to describe)
  pkgs,
  ...
}:
{
  programs.fish.enable = true;

  home.packages = with pkgs; [
    fzf
    pay-respects
  ];

  programs.fish = {
    interactiveShellInit =
      #fish
      ''
        function fish_mode_prompt
        end
        set -g fish_greeting ""
        fish_vi_key_bindings
        set -U fish_color_user blue
        set -U fish_color_host normal
        set -U fish_color_cwd blue

        pay-respects fish | source

        alias fuck='f'
      '';
  };
}
