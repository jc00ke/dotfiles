return {
	"vimlab/split-term.vim",
	keys = {
		{
			"<leader>fs",
			"<cmd>Term<cr>",
			desc = "Open terminal in horizontal split",
			noremap = true,
			silent = true
		},
		{
			"<leader>fv",
			"<cmd>VTerm<cr>",
			desc = "Open terminal in vertical split",
			noremap = true,
			silent = true
		},
		{
			"<leader>ff",
			"<cmd>TTerm<cr>",
			desc = "Open terminal in new tab",
			noremap = true,
			silent = true
		},
		{
			"<leader>fp",
			"<cmd>TTerm<cr> postgres<cr>",
			desc = "Open new terminal and run postgres",
			noremap = true,
			silent = true
		},
		{
			"<esc>",
			[[<c-\><c-n>]],
			mode = "t",
			noremap = true,
			silent = true
		},
		{
			"<C-o>",
			[[<C-\><C-n>]],
			mode = "t",
			noremap = true,
			silent = true
		}
	}
}
