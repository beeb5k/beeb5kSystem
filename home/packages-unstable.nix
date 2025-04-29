{ unstable, ... }:
{
  home.packages = with unstable; [
    vscode-fhs
    go
    zig
    bun
    lua
    rustc
    rustfmt
    clippy
    cargo
    vesktop
    obsidian
  ];
}
