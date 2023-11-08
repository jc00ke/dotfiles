return {
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({
				enabled = false
			})
		end
	},
	{
		"NeogitOrg/neogit",
		dependencies = { "sindrets/diffview.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("neogit").setup({
				disable_commit_confirmation = true,
				integrations = { diffview = true },
			})
		end,
		keys = {
			{ "<leader>g",   "<cmd>Neogit<cr>",        noremap = true,  desc = "Open Neogit" },
			{ "<leader>dvo", "<cmd>DiffViewOpen<cr>",  noremap = false, desc = "Open DiffView" },
			{ "<leader>dvc", "<cmd>DiffViewClose<cr>", noremap = false, desc = "Close DiffView" }
		}
	}
}
