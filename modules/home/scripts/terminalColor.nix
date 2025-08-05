{pkgs}:
pkgs.writeShellApplication {
  name = "terminal-change-color";

  text = ''
    seq="$(bash ~/.config/sequences.sh)"
    for tty in /dev/pts/[0-9]*; do
      if [ -w "$tty" ]; then
        ttyname=$(basename "$tty")
        proc=$(ps -t "$ttyname" -o comm= 2>/dev/null | head -n1)
          if [[ "$proc" =~ (foot|kitty|wezterm|gnome-terminal|bash|zsh|fish) ]]; then
            printf '%s' "$seq" > "$tty"
          fi
      fi
    done
  '';
}
