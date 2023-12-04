return {
	"olimorris/persisted.nvim",
	config = function()
		require("persisted").setup({
			autoload = true,
		})
	end,
	init = function()
		require("telescope").load_extension("persisted")
	end,
	keys = {
		{ '<leader>st', "<cmd>Telescope persisted<cr>", desc = "[S]ession [T]elescope" }
	}
}
