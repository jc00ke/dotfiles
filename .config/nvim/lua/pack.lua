local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end
vim.api.nvim_create_user_command("PackClean", pack_clean, {})


local function pack_list()
  local plugins = vim.pack.get(nil, { info = false })
  table.sort(plugins, function(p1, p2)
    return p2.spec.name > p1.spec.name
  end)

  local qf_items = {}
  for _, plugin in ipairs(plugins) do
    table.insert(qf_items, {
      filename = plugin.spec.name,
      text = "active: " .. tostring(plugin.active) .. ", version: " .. (plugin.spec.version or "-"),
    })
  end

  vim.fn.setqflist({}, 'r', { title = 'Plugins', items = qf_items })
  vim.cmd('copen')
end
vim.api.nvim_create_user_command("PackList", pack_list, {})

local function pack_update(opt)
  local update_opts = {}
  if not opt.bang then
    update_opts = { target = 'lockfile', force = true }
  end
  vim.pack.update(nil, update_opts)
end
vim.api.nvim_create_user_command("PackUpdate", pack_update, { bang = true })
