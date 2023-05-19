local utils = require "utils"

-- if not utils.has("LuaSnip") then
--   return
-- end
--      ["<Tab>"] = cmp_mapping(function(fallback)
--        if cmp.visible() then
--          cmp.select_next_item()
--        elseif luasnip.expand_or_locally_jumpable() then
--          luasnip.expand_or_jump()
--        elseif jumpable(1) then
--          luasnip.jump(1)
--        elseif has_words_before() then
--          -- cmp.complete()
--          fallback()
--        else
--          fallback()
--        end
--      end, { "i", "s" }),
--      ["<S-Tab>"] = cmp_mapping(function(fallback)
--        if cmp.visible() then
--          cmp.select_prev_item()
--        elseif luasnip.jumpable(-1) then
--          luasnip.jump(-1)
--        else
--          fallback()
--        end
--      end, { "i", "s" }),
--
--

local cmp = require("lvim.utils.modules").require_on_index "cmp"
local luasnip = require("lvim.utils.modules").require_on_index "luasnip"
local cmp_window = require "cmp.config.window"
local cmp_mapping = require "cmp.config.mapping"
local jumpable = require "lvim.core.cmp".methods.jumpable

local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
if not status_cmp_ok then
  return
end
local ConfirmBehavior = cmp_types.ConfirmBehavior
local luasnip = require "luasnip"

local luasnip_expand_or_jump = function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end

-- local luasnip_jump_backwards = function()
--   if luasnip.expand_or_jumpable() then
--     if luasnip.jumpable(-1) then
--       luasnip.jump(-1)
--     end
--   end
-- end

local luasnip_choice = function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

lvim.builtin.cmp.confirm_opts = {
  behavior = "replace",
  select = true
}

lvim.builtin.cmp.mapping = cmp.mapping.preset.insert {
  ["<C-k>"] = cmp_mapping(cmp_mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    elseif jumpable(1) then
      luasnip.jump(1)
    elseif has_words_before() then
      -- cmp.complete()
      fallback()
    else
      fallback()
    end
  end, { "i", "s" })),
  ["<C-j>"] = cmp_mapping(cmp_mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    elseif jumpable(1) then
      luasnip.jump(1)
    elseif has_words_before() then
      -- cmp.complete()
      fallback()
    else
      fallback()
    end
  end, { "i", "s" })),
  ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
  ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
  ["<C-f>"] = cmp.mapping.scroll_docs(-4),
  ["<C-d>"] = cmp.mapping.scroll_docs(4),
  ["<A-l>"] = cmp.mapping(),
  ["<C-e>"] = cmp.mapping.abort(),
  -- ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  ["<CR>"] = cmp_mapping(function(fallback)
    if cmp.visible() then
      local confirm_opts = vim.deepcopy(lvim.builtin.cmp.confirm_opts) -- avoid mutating the original opts below
      local is_insert_mode = function()
        return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
      end
      if is_insert_mode() then -- prevent overwriting brackets
        confirm_opts.behavior = ConfirmBehavior.Insert
      end
      local entry = cmp.get_selected_entry()
      local is_copilot = entry and entry.source.name == "copilot"
      if is_copilot then
        confirm_opts.behavior = ConfirmBehavior.Replace
        confirm_opts.select = true
      end
      if cmp.confirm(confirm_opts) then
        return -- success, exit early
      end
    end
    fallback() -- if not exited early, always fallback
  end),


  ["<S-CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  ["<c-y>"] = cmp.mapping(
    cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    { "i", "c" }
  ),
  ["<M-y>"] = cmp.mapping(
    cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    { "i", "c" }
  ),

  ["<c-space>"] = cmp.mapping {
    i = cmp.mapping.complete(),
    c = function(
      _ --[[fallback]]
    )
      if cmp.visible() then
        if not cmp.confirm { select = true } then
          return
        end
      else
        cmp.complete()
      end
    end,
  },
  ["<tab>"] = cmp.config.disable,
}



