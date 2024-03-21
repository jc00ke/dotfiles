vim.filetype.add({
  extension = { tfvars = "terraform", tf = "terraform", tfstate = "json", hujson = "jsonc" },
  filename = { ["Justfile"] = "just" },
})
