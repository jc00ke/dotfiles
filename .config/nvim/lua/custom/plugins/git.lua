return {
	{
		"f-person/git-blame.nvim",
		init = function()
			vim.g.gitblame_enabled = 0 -- disable by default, toggle with <Leader>b
		end
	},
	{
		"TimUntersberger/neogit",
		dependencies = { "sindrets/diffview.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("neogit").setup({ integrations = { diffview = true } })
		end,
		keys = {
			{ "<leader>g",   "<cmd>Neogit<cr>",        noremap = true,  desc = "Open Neogit" },
			{ "<leader>dvo", "<cmd>DiffViewOpen<cr>",  noremap = false, desc = "Open DiffView" },
			{ "<leader>dvc", "<cmd>DiffViewClose<cr>", noremap = false, desc = "Close DiffView" }
		}
	}
}
