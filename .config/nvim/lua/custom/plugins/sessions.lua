return {
	"olimorris/persisted.nvim",
	config = function()
		require("persisted").setup({
			autoload = true,
		})
	end,
	enabled = function()
		-- disable when in man pager mode
		for _, arg in ipairs(vim.v.argv) do
			if arg == "+Man!" then
				return false
			end
		end
		return true
	end,
	init = function()
		require("telescope").load_extension("persisted")
	end,
	keys = {
		{ '<leader>st', "<cmd>Telescope persisted<cr>", desc = "[S]ession [T]elescope" }
	}
}
