return {
  "nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  for_cat = "general.lsp",
  on_require = { "lspconfig" },
  lsp = function(plugin)
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    lspconfig[plugin.name].setup({
      capabilities = capabilities,
      settings = plugin.lsp and plugin.lsp.settings or {},
    })
  end,
}
