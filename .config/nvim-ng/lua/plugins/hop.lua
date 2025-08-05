return {
	"phaazon/hop.nvim",
	config = function()
		require("hop").setup()
	end,
	keys = {
		{
			"<leader>h",
			"<cmd>HopWord<cr>",
			desc = "Start Hop",
			noremap = true,
			silent = true,
		},
		{
			"HH",
			"<cmd>HopWord<cr>",
			desc = "Start Hop",
			noremap = true,
			silent = true
		}
	}
}
