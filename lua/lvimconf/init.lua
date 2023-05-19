local M = {}
local utils = require 'utils'

---@diagnostic disable-next-line: param-type-mismatch
local nvim_data_state_dir = vim.fn.expand("~/.local/state/nvim", ":p")
---@diagnostic disable-next-line: param-type-mismatch
local nvim_config_dir = vim.fn.expand("~/.config/nvim", ":p")

---@type LvimConfConfig
local defaults = {
  lvim = {
    colorscheme = 'lunar',
  },
  ---@type LunarVimCustomConfig
  custom_config = {
    enable_dev_mode = false,
    ---@diagnostic disable-next-line: param-type-mismatch
    shared_data_dir = vim.fn.expand("~/.local/state/nvim", ":p"),
    shared_lua_files = { utils.join_paths(nvim_config_dir, 'lua/globals.lua') },
    undodir = utils.join_paths(nvim_data_state_dir, 'undo'),
    shadafile = utils.join_paths(nvim_data_state_dir, 'shada/main.shada'),
  }
}

local validate_and_merge_config = function(config)
  config = config or {}
  config = vim.tbl_deep_extend('force', defaults, config or {})

  vim.validate({
    ['lvim.colorscheme'] = { config.lvim.colorscheme, 'string' },
  })

  vim.validate({
    ['custom_config.shared_data_dir']  = { config.custom_config.shared_data_dir, 'string' },
    ['custom_config.shared_lua_files'] = { config.custom_config.shared_lua_files, 'table', true },
    ['custom_config.undodir']          = { config.custom_config.undodir, 'string' },
    ['custom_config.shadafile']        = { config.custom_config.shadafile, 'string' },
  })

  return config
end

M.setup = function(config)
  config = validate_and_merge_config(config)


  ---@type LunarVimCustomConfig
  lvim.custom_config = config.custom_config
  M.load_lua_files()

  if config.lvim.colorscheme then
    lvim.colorscheme = config.lvim.colorscheme
  end
end


M.load_colorscheme = function(s)
  vim.cmd("colorscheme " .. s)
end

M.load_lua_files = function()
  vim.tbl_map(function(v)
    vim.cmd("luafile " .. v)
  end, lvim.custom_config.shared_lua_files)
end

return M
