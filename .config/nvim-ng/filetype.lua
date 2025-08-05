vim.filetype.add({
  extension = {
    env = "dotenv",
    tfvars = "terraform-vars",
    tf = "terraform",
    tfstate = "json",
    hujson = "jsonc",
    hurl = "hurl"
  },
  filename = {
    [".env"] = "dotenv",
    ["Justfile"] = "just"
  },
  -- Detect and apply filetypes based on certain patterns of the filenames
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
