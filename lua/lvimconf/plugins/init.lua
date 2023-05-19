local M = {}
local log = require 'log'

M.setup = function(opts)
  opts = opts or {}
  if not opts.plugin_list then
    return
  end

  if opts.dev_path then
    lvim.lazy.dev = {
      path = opts.dev_path,
      fallback = false,
    }
  end

  local result = {}
  for _, plugin_name in ipairs(opts.plugin_list) do
    local plugin_spec = require("lvimconf.plugins." .. plugin_name)

    if type(plugin_spec) == 'function' then
      ---TODO: enable config injection
      plugin_spec = plugin_spec()
    end
    for _, value in ipairs(plugin_spec) do
      local plugin_name = value[1]
      if value.dir then
        plugin_name = value.dir
      end
      log:debug(string.format("adding plugin %s", plugin_name))
      table.insert(result,1,value)
    end

    --vim.list_extend(result, plugin_spec)
  end
  lvim.plugins = result
end


return M
