return {

  {
    "savq/melange-nvim",
    config = function()
      -- code
    end
  },

  -- Two TreeSitter supported colorschemes ispired by base16-tomorrow-night and monokai pro.
  -- Both colorschemes are availaible for vim and neovim and written in Lua.
  {
    'Yazeed1s/minimal.nvim'
  },
  -- Github's Neovim themes
    {
      'projekt0n/github-nvim-theme',
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require('github-theme').setup({


        })

        vim.cmd('colorscheme github_dark_dimmed')
      end,

    }
}
