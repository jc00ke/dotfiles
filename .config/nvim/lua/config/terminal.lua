local os_env = os.getenv("OS")

if os_env == "Windows_NT" then
  vim.opt.shell = "pwsh"
end
