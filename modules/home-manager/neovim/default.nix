{
  config,
  inputs,
  unstable,
  ...
}:
let
  utils = inputs.nixCats.utils;
in
{
  imports = [
    inputs.nixCats.homeModule
  ];
  config = {
    nixCats = {
      enable = true;
      nixpkgs_version = inputs.nixpkgs-unstable;
      addOverlays =
        # (import ./overlays inputs) ++
        [
          (utils.standardPluginOverlay inputs)
        ];
      packageNames = [ "Neovim" ];

      luaPath = ./.;

      categoryDefinitions.replace =
        {
          pkgs,
          settings,
          categories,
          extra,
          name,
          mkNvimPlugin,
          ...
        }@packageDef:
        {
          lspsAndRuntimeDeps = with pkgs; {
            general = [
              ripgrep
              fd
              bat
              fzf
              nodejs_23 # copilot's bloated ass want this.
            ];

            web = with unstable; {
              # cool thing but i dont want it for now.
              /*
                templ = with inputs; [
                  templ.packages.${system}.templ
                ];
              */
              tailwindcss = [
                tailwindcss-language-server
              ];
              HTMX = [
                htmx-lsp
              ];
              HTML = [
                vscode-langservers-extracted
              ];
              JS = [
                typescript-language-server
                biome
              ];
            };

            zig = with unstable; [
              zls
            ];

            rust = with unstable; [
              rust-analyzer
            ];

            python = [
              pyright
            ];

            lua = [
              lua-language-server
              stylua
            ];

            nix = [
              nixfmt-rfc-style
              nil
              nixd
            ];

            C = [
              clang-tools
              cmake-language-server
              cmake
              cmake-format
            ];
          };
          startupPlugins = {
            general = with unstable.vimPlugins; [
              pkgs.neovimPlugins.lze
              pkgs.neovimPlugins.lzextras
              mini-base16
              kanagawa-nvim
            ];
          };
          optionalPlugins = {
            editor = with unstable.vimPlugins; [
              oil-nvim
              nvim-autopairs # this tryes to do lots of magic which causes some problem. TODO : replace it with mini or blik pairs.
              comment-nvim
              eyeliner-nvim
              conform-nvim
              indent-blankline-nvim
            ];

            ui = with unstable.vimPlugins; [
              bufferline-nvim
              lualine-nvim
            ];

            tsitter = with unstable.vimPlugins; [
              nvim-treesitter.withAllGrammars
              nvim-treesitter-textobjects
            ];

            telescope = with unstable.vimPlugins; [
              fzf-lua
            ];

            ai = with unstable.vimPlugins; [
              copilot-lua
            ];

            completion = with unstable.vimPlugins; [
              blink-cmp
            ];

            extras = with unstable.vimPlugins; [
              cord-nvim
              which-key-nvim
              nvim-web-devicons
            ];
          };
          sharedLibraries = {
            general = with unstable; [
              # libgit2
            ];
          };
          environmentVariables = {
          };
          extraWrapperArgs = {
          };

          python3.libraries = {
            test = _: [ ];
          };
          extraLuaPackages = {
            test = [ (_: [ ]) ];
          };
        };

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions.replace = {
        Neovim =
          { pkgs, ... }:
          {
            settings = {
              wrapRc = true;
              aliases = [
                "nvim"
                "nv"
                "v"
                "vi"
                "vim"
              ];
              # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            extra = {
              base16colors = pkgs.lib.filterAttrs (
                k: v: builtins.match "base0[0-9A-F]" k != null
              ) config.lib.stylix.colors.withHashtag;
            };

            categories = {
              general = true;
              editor = true;
              ui = true;
              tsitter = true;
              telescope = true;
              ai = true;
              completion = true;
              extras = true;
              C = true;
              python = true;
              lua = true;
              nix = true;
              rust = true;
              zig = true;
              web = true;
            };
          };
      };
    };
  };
}
