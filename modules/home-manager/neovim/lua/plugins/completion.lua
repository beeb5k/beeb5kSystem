return {
  {
    "blink.cmp",
    event = { "DeferredUIEnter" },
    on_require = "blink",
    after = function(plugin)
      require("blink.cmp").setup({
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- See :h blink-cmp-config-keymap for configuring keymaps
        keymap = { preset = "default" },
        appearance = {
          nerd_font_variant = "mono",
        },
        signature = { enabled = true },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
      })
    end,
  },
  {
    "copilot.lua",
    event = { "InsertEnter" },
    after = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },
}
