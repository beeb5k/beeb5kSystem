return {
	"nvim-web-devicons",
	event = "DeferredUIEnter",
	after = function()
		require("nvim-web-devicons").setup({
			default = true,
		})
	end,
}
