---@alias opts_default table {noremap: boolean, silent: boolean}: default map options

---@alias keymap_setter_t fun(mode: string|table, lhs: string, rhs: string|function, opts: table|nil)
local set     = vim.keymap.set

---@alias keymap_deleter_t fun(opts: table|nil)
local del     = vim.keymap.del

local extend  = function(...) return { vim.tbl_extend('force', ...) } end
local tbl_map = vim.tbl_map

local each    = function(opts, set)
  tbl_map(function(v)
    set(v.mode, v.lhs, v.rhs, v.opts)
  end, opts)
end
--
each({
  -- Lang
  { { "<A-t>", ";at" }, ":luafile %<CR>",{ "n" },desc = "Source current lua file" },
  { { "<A-e>", ";ae" }, actions.lang.execute_buffer, desc = actions.lang.execute_buffer },
  { { "<A-s>", ";as" }, actions.toggle_panel,        desc = actions.toggle_panel, },
  { { "<A-r>", ";ar" }, actions.lang.execute_line,   desc = actions.lang.execute_line, },
  { { ";vc", ";ar" },   actions.inspect_cursor_pos,  desc = actions.inspect_cursor_pos,},
}, { noremap = true, silent = true })
