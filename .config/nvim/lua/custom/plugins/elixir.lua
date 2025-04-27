-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
	--
	-- whatever keybinds you want, see below for more suggestions
	vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
	vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
	vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
end

return {
	"elixir-tools/elixir-tools.nvim",
	ft = { "elixir", "eex", "heex", "surface" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local elixir = require("elixir")
		local elixirls = require("elixir.elixirls")

		elixir.setup({
			credo = { enable = true },
			elixirls = {
				enable = true,
				settings = elixirls.settings({
					dialyzerEnabled = false,
					enableTestLenses = false,
				}),
				on_attach = on_attach,
				root_dir = function(fname)
					return lspconfig.util.root_pattern("mix.exs", ".git", "main.exs")(fname) or vim.loop.os_homedir()
				end,
				tag = "v0.27.2",
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
