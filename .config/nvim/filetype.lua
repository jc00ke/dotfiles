vim.filetype.add({
  extension = { tfvars = "terraform", tf = "terraform", tfstate = "json", hujson = "jsonc", hurl = "hurl" },
  filename = { ["Justfile"] = "just" },
})
