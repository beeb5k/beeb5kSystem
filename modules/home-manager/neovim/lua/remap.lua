local function scold()
  vim.notify("Nope use hjkl", "warn")
end

vim.keymap.set({ "n", "v", "i" }, "<Up>", scold)
vim.keymap.set({ "n", "v", "i" }, "<Down>", scold)
vim.keymap.set({ "n", "v", "i" }, "<Left>", scold)
vim.keymap.set({ "n", "v", "i" }, "<Right>", scold)
