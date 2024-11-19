-- Set tab settings specifically for Makefiles
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function()
		-- Use actual tabs
		vim.bo.expandtab = false
		-- Set tab width to 8 spaces (GNU Make standard)
		vim.bo.tabstop = 8
		vim.bo.shiftwidth = 8
		-- Show tabs visually so you can see them
		vim.wo.list = true
		vim.opt.listchars = {
			tab = "→ ",
			trail = "·",
			extends = "»",
			precedes = "«",
		}
	end,
})
-- Optional: Add a command to convert existing spaces to tabs
vim.api.nvim_create_user_command("MakefileFixIndent", function()
	-- Preserve cursor position
	local view = vim.fn.winsaveview()
	-- Convert indentation to tabs
	vim.cmd([[silent %s/^\s\+/\t/]])
	-- Restore cursor position
	vim.fn.winrestview(view)
end, {})
