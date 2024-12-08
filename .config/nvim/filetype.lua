vim.filetype.add({
  extension = { tfvars = "terraform-vars", tf = "terraform", tfstate = "json", hujson = "jsonc", hurl = "hurl" },
  filename = { ["Justfile"] = "just" },
})
