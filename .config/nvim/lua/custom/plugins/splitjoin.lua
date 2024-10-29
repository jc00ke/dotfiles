return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter", "AndrewRadev/splitjoin.vim" },
	keys = {
		-- { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
	},
	opts = {
		use_default_keymaps = false,
		max_join_length = 150,
	},
	init = function()
		local langs = require("treesj.langs")["presets"]

		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = "*",
			callback = function()
				local opts = { buffer = true }
				if langs[vim.bo.filetype] then
					vim.keymap.set("n", "J", "<Cmd>TSJToggle<CR>", opts)
					vim.keymap.set("n", "JS", "<Cmd>TSJSplit<CR>", opts)
					vim.keymap.set("n", "JJ", "<Cmd>TSJJoin<CR>", opts)
				else
					vim.keymap.set("n", "JS", "<Cmd>SplitjoinSplit<CR>", opts)
					vim.keymap.set("n", "JJ", "<Cmd>SplitjoinJoin<CR>", opts)
				end
			end,
		})
	end,
}
