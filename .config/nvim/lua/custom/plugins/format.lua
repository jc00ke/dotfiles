return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- Everything in opts will be passed to setup()
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			css = { "prettierd", "prettier", stop_after_first = true },
			eelixir = { "mix", "rustywind" },
			heex = { "mix", "rustywind" },
			javascript = { "deno_fmt", "prettierd", "prettier", stop_after_first = true },
			just = { "just" },
			lua = { "stylua" },
			nix = { "alejandra", "nix_fmt", stop_after_first = true },
			python = { "isort", "black" },
			sql = { "sleek", "sqlfluff" },
			terraform = { "terraform_fmt" },
			typescript = { "deno_fmt" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		-- Customize formatters
		formatters = {
			nix_fmt = {
				command = "nix fmt",
			},
			shfmt = {
				prepend_args = { "-i", "2" },
			},
			sleek = {
				prepend_args = { "--uppercase", "true" },
			},
			terraform_fmt = {
				command = "tofu",
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
