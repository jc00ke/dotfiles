-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

return {
	-- Add indentation guides even on blank lines
	'lukas-reineke/indent-blankline.nvim',
	main = "ibl",
	-- See `:help indent_blankline.txt`
	opts = {
		enabled = false,
		-- char = '┊',
		-- show_trailing_blankline_indent = false,
		-- space_char_blankline = " ",
		-- show_current_context = true,
		-- show_current_context_start = true,
	},
}
