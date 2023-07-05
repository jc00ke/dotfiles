return {
	'folke/trouble.nvim',
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle<cr>",                       silent = true, noremap = true, desc = "Trouble" },
		{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", silent = true, noremap = true,
			                                                                                               desc =
			"Trouble [w]orkspace diagnostics" },
		{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  silent = true, noremap = true,
			                                                                                               desc =
			"Trouble [document] diagnostics" },
		{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               silent = true, noremap = true,
			                                                                                               desc =
			"Trouble [l]ocation list" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              silent = true, noremap = true,
			                                                                                               desc =
			"Trouble [q]uickfix" },
		{ "gR",         "<cmd>TroubleToggle lsp_references<cr>",        silent = true, noremap = true,
			                                                                                               desc =
			"Toggle Touble LSP references" },
	}
}
