let
  git_status = "$\{custom.git_status_dirty}";
  count = "$\{count}";
in
{
  xdg.configFile = {
    "matugen/templates/starship.toml" = {
      enable = true;
      text =
        # toml
        ''
          add_newline = true

          # A minimal left prompt
          format = """$python$directory$character"""

          # move the rest of the prompt to the right
          # right_format = """$status$git_branch$custom.git_status_dirty$git_status"""
          right_format = """$status$cmd_duration$git_branch${git_status}$git_status"""

          palette="matugen"

          [palettes.matugen]
          <* for name, value in colors *>
          {{name}} = '{{value.default.hex}}'
          <* endfor *>

          [character]
          success_symbol = "[](primary)"
          error_symbol = "[](error)"
          vicmd_symbol = "[](tertiary)"

          [python]
          format = '[(\($virtualenv\) )]($style)'
          style = 'surface_tint'

          [directory]
          style = "outline"
          truncation_length = 1
          truncation_symbol = ""
          fish_style_pwd_dir_length = 1

          # right prompt uses left space padding
          [git_branch]
          format = ' [$branch]($style)'
          style = 'secondary'

          [git_status]
          format = '( [\[$ahead_behind$stashed\]]($style))'
          style = "secondary"
          stashed = "≡"
          ahead = "⇡${count}"
          behind = "⇣${count}"

          [custom.git_status_dirty]
          when = 'test -n "$(git status --porcelain 2>/dev/null)"'
          symbol = "•"
          style = "surface_tint"
          format="[$symbol]($style)"
          shell = ["sh"]

          [cmd_duration]
          format = ' [$duration]($style)'

          [line_break]
          disabled = true

          [status]
          disabled = false
          symbol = ' ✘'
        '';
    };
  };
}
