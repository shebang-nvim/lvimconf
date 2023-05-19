-- This file is automatically loaded by plugins.config
vim.g.mapleader = ","
vim.g.maplocalleader = " "

local opt = vim.opt
opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.completeopt = "menu,menuone,noselect"
-- opt.completeopt = { "menuone" "noselect" } -- mostly just for cmp

opt.conceallevel = 0 -- so that `` is visible in markdown files
-- opt.fileencoding = "utf-8" -- the encoding written to a file
opt.foldmethod = "manual" -- folding, set to "expr" for treesitter based folding
opt.foldlevel = 0 -- 0 means everything is unfolded
opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.mouse = "nv" -- allow the mouse to be used in neovim (normal and visual)
opt.pumheight = 10 -- pop up menu height
opt.pumblend = 0
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 0 -- always show tabs
opt.smartcase = true -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 500 -- default: 1000, time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo
opt.updatetime = 100 -- faster completion (4000ms default)
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.softtabstop = 2
opt.autoindent = true
opt.cindent = true
opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly,
opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.laststatus = 3
opt.showcmd = false
opt.ruler = false
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = false -- display lines as one long line
opt.scrolloff = 0
opt.sidescrolloff = 8
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.title = true

opt.linebreak = true
opt.textwidth = 0 -- zero disables auto wrapping

opt.belloff = "all" -- Just turn the dang bell off
-- colorcolumn = "80"
-- colorcolumn = "120"
opt.fillchars = { eob = "~" }

opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
--
opt.whichwrap = vim.opt.whichwrap + "<" + ">" + "[" + "]" + "h" + "l"
opt.iskeyword = vim.opt.iskeyword + "-"
opt.shadafile = lvim.custom_config.shadafile
opt.undodir = lvim.custom_config.undodir

if vim.fn.has "nvim-0.9.0" == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append { C = true }
end

-- vim.cmd[[colorscheme tokyonight]]
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
