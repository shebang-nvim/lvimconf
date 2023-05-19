-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

require 'lvimconf'.setup({
  -- lvim standard config table
  ---@type LvimConfConfig
  lvim = {
    -- colorscheme = 'melange',
    colorscheme = 'github_dark_dimmed',
  },

  ---@type LunarVimCustomConfig
  custom_config = {
    enable_dev_mode = true,
  }
})

require "lvimconf.settings"
require "lvimconf.mappings"
require "lvimconf.luasnip".setup()
require "lvimconf.cmp"

require "lvimconf.plugins".setup(
  {
    dev_path = '~/dev/neovim-plugins',
    plugin_list = {
      'lvm_telescope',
      'nvim_neo_tree',
      'colorschemes',
      'git',
      'mini',
      -- 'lvm'
    },
  }
)
