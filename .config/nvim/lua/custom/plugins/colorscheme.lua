return {
	'ishan9299/nvim-solarized-lua',
	priority = 999,
	config = function()
		vim.cmd.colorscheme 'solarized'
	end,
	lazy = false
}
