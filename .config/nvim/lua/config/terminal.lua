local os_env = os.getenv("OS")

local map = vim.keymap.set

-- [[ terminal keymaps ]]
map("n", "<leader>fs", [[:botright terminal <cr>i]], { desc = "Open terminal in horizontal split" })
map("n", "<leader>fv", [[:vertical terminal <cr>i]], { desc = "Open terminal in vertical split" })
map("n", "<leader>ff", [[:tab terminal <cr>i]], { desc = "Open terminal in new tab" })
map(
  "n",
  "<leader>fp",
  [[:tabnew|terminal postgres<cr>]],
  { desc = "Open terminal in new tab and run Postgres" }
)
map("t", "<esc>", [[<c-\><c-n>]])
map("t", "<c-o>", [[<c-\><c-n>]])
map('t', '', "")
map('t', '', "")

if os_env == "Windows_NT" then
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile ExecutionPolicy RemoteSigned -Command $PSStyle.OutputRendering = 'PlaidText'"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""

  local function pwsh_term(opener)
    return function()
      vim.cmd(opener)
      vim.fn.jobstart({
        "pwsh", "-NoLogo", "-NoProfile", "-NoExit", "-Command", ". \"$env:PROFILE\""
      }, { term = true })
      vim.cmd("startinsert")
    end
  end

  map("n", "<leader>fs", pwsh_term("split | enew"), { desc = "Open terminal in horizontal split" })
  map("n", "<leader>fv", pwsh_term("vsplit | enew"), { desc = "Open terminal in vertical split" })
  map("n", "<leader>ff", pwsh_term("tabnew | enew"), { desc = "Open terminal in new tab" })
end
