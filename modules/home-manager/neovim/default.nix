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
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              ripgrep
              fd
              bat
              fzf
              lua-language-server
              pyright
              nil
              stylua
              nixfmt-rfc-style
              nodejs_23
              clang-tools
              unstable.zls
              unstable.rust-analyzer
            ];
          };
          startupPlugins = {
            general = with pkgs.vimPlugins; [
              pkgs.neovimPlugins.lze
              pkgs.neovimPlugins.lzextras
              kanagawa-nvim
              mini-base16
              fzf-lua
              lualine-nvim
              which-key-nvim
            ];
          };
          optionalPlugins = {
            general = {
              cmp = with pkgs.vimPlugins; [
                nvim-cmp
                luasnip
                friendly-snippets
                cmp_luasnip
                cmp-buffer
                cmp-path
                cmp-nvim-lua
                cmp-nvim-lsp
                cmp-cmdline
                cmp-nvim-lsp-signature-help
                cmp-cmdline-history
                copilot-cmp
              ];

              treesitter = with pkgs.vimPlugins; [
                nvim-treesitter.withAllGrammars
                nvim-treesitter-textobjects
              ];
              telescope = with pkgs.vimPlugins; [
                telescope-nvim
              ];

              git = with pkgs.vimPlugins; [
                gitsigns-nvim
              ];

              lsp = with pkgs.vimPlugins; [
                nvim-lspconfig
                lspkind-nvim
              ];

              others = with pkgs.vimPlugins; [
                comment-nvim
                nvim-autopairs
                eyeliner-nvim
                oil-nvim
                nvim-lspconfig
                noice-nvim
                nvim-notify
                nvim-web-devicons
                conform-nvim
                indent-blankline-nvim
                bufferline-nvim
                copilot-lua
              ];
            };
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

          extraPython3Packages = {
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
            };
          };
      };
    };
  };
}
