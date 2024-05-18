return {
	{
		"vim-test/vim-test",
		enabled = true,
		keys = {
			{ "<leader>t",  "<cmd>TestNearest<cr>", desc = "Run nearest test" },
			{ "<leader>l",  "<cmd>TestLast<cr>",    desc = "Run last test" },
			{ "<leader>T",  "<cmd>TestFile<cr>",    desc = "Run all tests in the file" },
			{ "<leader>ta", "<cmd>TestSuite<cr>",   desc = "Run all tests" },
			{ "<leader>tv", "<cmd>TestVisit<cr>",   desc = "Visits the test file from which you last run your tests" },
		},
		init = function()
			vim.g["test#strategy"] = "neovim"
			vim.g["test#neovim#start_normal"] = 1
		end,
	},
	{
		"nvim-neotest/neotest",
		enabled = false,
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-elixir"),
					-- require("neotest-vim-test")({ allow_file_types = { "ruby", "elixir" } })
				},
				quickfix = {
					open = false,
				},
			})
		end,
		dependencies = {
			"jfpedroza/neotest-elixir",
			"nvim-tree/nvim-web-devicons",
			-- "vim-test/vim-test",
			-- "nvim-neotest/neotest-vim-test",
		},
		keys = {
			{
				"<leader>t",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>l",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Run last test",
			},
			{
				"<leader>T",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run all tests in the file",
			},
			{
				"<leader>ta",
				function()
					local neotest = require("neotest")
					neotest.run.run({ suite = true })
					neotest.summary.open()
				end,
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open()
				end,
			},
			{
				"<leader>tp",
				function()
					require("neotest").output_panel.toggle()
				end,
			},
		},
	},
}
