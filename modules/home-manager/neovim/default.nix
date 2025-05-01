{
  config,
  inputs,
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
      nixpkgs_version = inputs.nixpkgs;
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

            web = with pkgs; {
              # cool thing but i dont want it for now.
              /*
                templ = with inputs; [
                  templ.packages.${system}.templ
                ];
              */

              html = [
                emmet-ls
                vscode-langservers-extracted
              ];

              JS = [
                typescript-language-server
                eslint
                biome
              ];
            };

            zig = with pkgs; [
              zls
            ];

            rust = with pkgs; [
              rust-analyzer
            ];

            go = with pkgs; [
              gopls
              delve
              gotools
              go-tools
              go
              golangci-lint
            ];

            python = with pkgs; [
              pyright
              isort
              black
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
            general = with pkgs.vimPlugins; [
              pkgs.neovimPlugins.lze
              pkgs.neovimPlugins.lzextras
              mini-base16
              catppuccin-nvim
              diffview-nvim
            ];
          };
          optionalPlugins = with pkgs.vimPlugins; {
            editor = [
              oil-nvim
              ultimate-autopair-nvim
              comment-nvim
              eyeliner-nvim
              conform-nvim
              nvim-lint
              indent-blankline-nvim
            ];

            ui = [
              bufferline-nvim
              lualine-nvim
              mini-starter
            ];

            tsitter = [
              nvim-treesitter.withAllGrammars
              nvim-treesitter-textobjects
            ];

            telescope = [
              fzf-lua
            ];

            git = [
              neogit
              gitsigns-nvim
            ];

            ai = [
              copilot-lua
            ];

            completion = [
              blink-cmp
            ];

            web = [
              nvim-ts-autotag
            ];

            extras = [
              cord-nvim
              which-key-nvim
              nvim-web-devicons
            ];
          };
          sharedLibraries = {
            general = with pkgs; [
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
              git = true;
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
              go = true;
            };
          };
      };
    };
  };
}
