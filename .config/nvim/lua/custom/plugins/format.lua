return {
	"stevearc/conform.nvim",
	lazy = false,
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
	config = function()
		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_format = "fallback", range = range })
		end, { range = true })
	end,
	-- Everything in opts will be passed to setup()
	opts = {
		log_level = vim.log.levels.DEBUG,
		-- Define your formatters
		formatters_by_ft = {
			bash = { "shfmt" },
			css = { "prettierd", "prettier", stop_after_first = true },
			eelixir = { "mix", "rustywind" },
			go = { "goimports", "gofumpt" },
			heex = { "mix", "rustywind" },
			html = { "superhtml" },
			javascript = { "deno_fmt", stop_after_first = true },
			json = { "deno_fmt" },
			jsonc = { "deno_fmt" },
			-- javascript = { "deno_fmt", "prettierd", "prettier", stop_after_first = true },
			just = { "just" },
			lua = { "stylua" },
			nix = { "alejandra", "nix_fmt", stop_after_first = true },
			python = { "isort", "black" },
			sh = { "shfmt" },
			sql = { "sleek", "sqlfluff" },
			terraform = { "terraform_fmt" },
			typescript = { "deno_fmt" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
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
