vim.filetype.add({
  extension = { tfvars = "terraform", tf = "terraform", tfstate = "json" },
  filename = { ["Justfile"] = "just" },
})