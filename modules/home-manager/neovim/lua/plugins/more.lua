return {
	{
		"nvim-autopairs",
		event = "InsertEnter",
		after = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"comment.nvim",
		event = "BufReadPost",
		after = function()
			require("Comment").setup({})
		end,
	},
	{
		"eyeliner.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("eyeliner").setup({
				highlight_on_key = true,
				dim = true,
			})
		end,
	},
	{
		"gitsigns.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"nvim-notify",
		event = "DeferredUIEnter",
		after = function()
			require("notify").setup({
				timeout = 3000,
				stages = "fade_in_slide_out",
				render = "simple",
			})
			vim.notify = require("notify")
		end,
	},
	{
		"which-key.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("which-key").setup({})
		end,
	},
	{
		"indent-blankline.nvim",
		event = { "BufReadPost" },
		after = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = false },
			})
		end,
	},
}
