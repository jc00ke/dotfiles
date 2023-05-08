return {
	{
		"ellisonleao/carbon-now.nvim",
		cmd = "CarbonNow",
		init = function()
			require("carbon-now").setup({
				options = {
					theme = "solarized",
					font_family = "Source Code Pro",
					bg = "#268BD2"
				}
			})
		end,
		keys = {
			{
				"<leader>cn",
				"<cmd>CarbonNow<cr>",
				desc = "Send text to [C]arbon [N]ow",
				mode = "v",
			},
		}
	}
}
