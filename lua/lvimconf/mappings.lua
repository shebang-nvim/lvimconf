local mappings = {


}
local map = vim.keymap.set

lvim.leader = ","
lvim.builtin.which_key.mappings[","] = { "<cmd>Telescope buffers<CR>", "Buffer List"}
lvim.builtin.which_key.mappings["e"] = { "<cmd>Neotree reveal_force_cwd<CR>", "Explorer" }


lvim.keys.command_mode['%g'] = "<C-R>=expand('~/dev/repos/github.com/')<CR>"
lvim.keys.command_mode['%p'] = "<C-R>=expand('~/.local/share/lunarvim/site/pack/lazy/opt/')<CR>"

lvim.keys.normal_mode['<leader>`'] = {":b#<CR>", {desc = "Buffer Alternate"}}
lvim.keys.normal_mode['<leader><leader>'] = {"<cmd>Telescope buffers<CR>", {desc = "Buffer List", noremap = true, silent = true}}

local terminal_mappings = {
  -- Exit insert
  { "jj", [[<C-\><C-n>]], {desc = 'Exit insert mode'}},
  { "jk", [[<C-\><C-n>]], {desc = 'Exit insert mode'}},
  { "kk", [[<C-\><C-n>]], {desc = 'Exit insert mode'}},
  { "kj", [[<C-\><C-n>]], {desc = 'Exit insert mode'}},
  {"<C-h>", "<C-\\><C-N><C-w>h",  {silent = true, desc = "Terminal windows left" }},
  -- Terminal movements
  {"<C-j>", "<C-\\><C-N><C-w>j",  {silent = true, desc = "Terminal windows down" }},
  {"<C-k>", "<C-\\><C-N><C-w>k",  {silent = true, desc = "Terminal windows up" }},
  {"<C-l>", "<C-\\><C-N><C-w>l",  {silent = true, desc = "Terminal windows right" }},
  -- Escape
  {"<Esc>",[[<C-\><C-n>]], {desc = 'Escape remap'}},
  {"<M-[>",[[<Esc>]], {desc = 'Escape'}},
  -- TODO
  {"<M-h>",[[<c-\><c-n><c-w>h]], {desc = 'TODO'}},
  {"<M-j>",[[<c-\><c-n><c-w>j]], {desc = 'TODO'}},
  {"<M-k>",[[<c-\><c-n><c-w>k]], {desc = 'TODO'}},
  {"<M-l>",[[<c-\><c-n><c-w>l]], {desc = 'TODO'}},

}

for _, map in ipairs(terminal_mappings) do
  local lhs =  table.remove(map,1)
  lvim.keys.term_mode[lhs] = map
end

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<S-Right>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<S-Left>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })



-- Macros

-- map('n','u', '<Nop>',  {desc = 'Undo Disabled'})
-- map('n','U', '<Nop>',  {desc = 'Undo Disabled'})
-- map('n','q', '<Nop>',  {desc = 'Default Macro Recording Disabled'})
-- map('n','<Space>q', 'q',  {desc = 'Macro Recording' })
--

