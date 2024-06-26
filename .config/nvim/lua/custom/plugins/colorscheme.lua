return {
	{
		"ishan9299/nvim-solarized-lua",
		priority = 999,
		config = function()
			-- vim.cmd.colorscheme 'solarized'
		end,
		lazy = false,
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{
		"calind/selenized.nvim",
		priority = 999,
		config = function()
			vim.cmd.colorscheme("selenized")
		end,
		lazy = false,
	},
}
