local utils = require "utils"

-- if not utils.has("LuaSnip") then
--   return
-- end

-- local cmp = require("lvim.utils.modules").require_on_index "cmp"
-- local luasnip = require("lvim.utils.modules").require_on_index "luasnip"
-- local cmp_window = require "cmp.config.window"
-- local cmp_mapping = require "cmp.config.mapping"
-- local jumpable = require "lvim.core.cmp".methods.jumpable

-- local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
-- if not status_cmp_ok then
--   return
-- end
-- local ConfirmBehavior = cmp_types.ConfirmBehavior

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local extend = function(...) return { vim.tbl_extend('force', ...) } end
local extend_opts = function(opts, custom)
  -- code
end
local luasnip = require "luasnip"

local luasnip_expand_or_jump = function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end

local luasnip_jump_backwards = function()
  if luasnip.expand_or_jumpable() then
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end
end

local luasnip_choice = function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end

local keys = {
  {
    "<C-k>",
    luasnip_expand_or_jump,
    silent = true,
    mode = { "i", "s" },
  },
  {
    "<C-j>",
    luasnip_jump_backwards,
    mode = { "i", "s" },
  },
  {
    "<C-l>",
    luasnip_choice,
    mode = "i",
  },
}
