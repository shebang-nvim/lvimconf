lvim.builtin.telescope.active = false
return function(opts)
  return {
    {
      dir = "~/dev/neovim-plugins/lvm-telescope.nvim",
      -- "shebang-nvim/lvm-telescope.nvim",
      -- dev = true,
      enabled = true,
      main = 'lvm.telescope',
      lazy = true,
      -- priority = 1100, -- make sure to load this before all the other start plugins
      dependencies = {

        {
          "nvim-telescope/telescope.nvim",
          -- config = function()
          --   -- require("lvim.core.telescope").setup()
          -- end,
          -- dependencies = { "telescope-fzf-native.nvim" },
          lazy = true,
          cmd = "Telescope",
          enabled = true,
        },
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          lazy = true,
          enabled = true,
          dependencies = { "nvim-telescope/telescope.nvim", },
        },
        { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
        { "nvim-telescope/telescope-symbols.nvim",      dependencies = { "nvim-telescope/telescope.nvim" } },
        {
          "ahmedkhalf/project.nvim",
          dependencies = { "kkharji/sqlite.lua",
            "nvim-telescope/telescope.nvim" }
        },
        { "nvim-telescope/telescope-hop.nvim",           dependencies = { "nvim-telescope/telescope.nvim" } },
        { "nvim-telescope/telescope-smart-history.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
        { "nvim-telescope/telescope-frecency.nvim",      dependencies = { "nvim-telescope/telescope.nvim" } },
        { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
        { "nvim-telescope/telescope-dap.nvim",           dependencies = { "nvim-telescope/telescope.nvim" } },
        { "AckslD/nvim-neoclip.lua",                     dependencies = { "nvim-telescope/telescope.nvim" } },
        {
          dir = "~/dev/neovim-plugins/lvm-query-tools.nvim",
          -- "shebang-nvim/lvm-query-tools.nvim",

          -- lazy = false,
          -- event = "VeryLazy",
          main = 'lvm.query-tools',
          dependencies = { "nvim-telescope/telescope.nvim" },
          opts = {
            store = {
              models = {
                files = {
                  ['lvm-models-conf'] = {
                    path = [[~/.config/lvim/lua/lvimconf/lvm/models.lua]],
                    description = "LVM Models Config",
                  },
                   ['lvim config.lua'] = {
                    path = [[~/.config/lvim/config.lua]],
                    description = "LunarVim Config",
                  },
                  ['lvim lvm-telescope.lua'] = {
                    path = [[~/.config/lvim/lua/lvimconf/plugins/lvm_telescope.lua]],
                    description = "LunarVim LvmTelescope Config",
                  },

                  ['LvmTelescope Default Config'] = {
                    path = [[~/dev/neovim-plugins/lvm-telescope.nvim/lua/lvm/telescope/defaults.lua]],
                    description = "LvmTelescope Default Config",
                  }
                },
                --   -- either table or json file
                repositories = {
                  --
                  ["nvim-telescope/telescope.nvim"] = {
                    path = [[~/dev/repos/github.com/nvim-telescope/telescope.nvim]],
                    description = "telescope repositoriy",
                  },
                  ["nvim-telescope/telescope-frecency.nvim"] = {
                    path = [[~/dev/repos/github.com/nvim-telescope/telescope-frecency.nvim]],
                    description = "telescope frecency",
                  },
                  ["folke/dot"] = {
                    path = [[~/dev/repos/github.com/folke/dot]],
                    description = "Dot files's from folke",
                  },
                  ["github"] = {
                    path = [[~/dev/repos/github.com/github]],
                    description = "Github Projects",
                  },
                 },
              },
            },
          },
          keys = function(opts)
            return {
              { "<A-9>", "<cmd>lua require('telescope').extensions['query-tools'].files()<cr>", { desc = "LvmQueryTools Files Query" } },
              { "<A-8>", "<cmd>lua require('telescope').extensions['query-tools'].repositories()<cr>", { desc = "LvmQueryTools Repositories Query" } },
              { "<A-7>", "<cmd>lua require('telescope').extensions['query-tools'].queries()<cr>", { desc = "LvmQueryTools Query Rool Picker" } },
            }
          end,
          config = function(_, opts)
            local tele_config = {
              extensions = {
                ['query-tools'] = {
                  -- What scope to change the directory, valid options are
                  -- * global (default)
                  -- * tab
                  -- * win
                  scope_chdir = "win",

                  quiet = false,
                  -- Show hidden files in telescope
                  show_hidden = true,

                  -- When set to false, you will get a message when project.nvim changes your
                  -- directory.
                  silent_chdir = false,


                  theme = "ivy",

                  mappings = {
                    ["i"] = {
                      -- your custom insert mode mappings
                    },
                    ["n"] = {
                      -- your custom normal mode mappings
                    },
                  },

                },
              }
            }
            local telescope = require 'telescope'
            telescope.setup(tele_config)
            require("telescope").load_extension "query-tools"
            require("lvm.query-tools").setup(opts)
          end,

          -- config = function (_, opts)
          --   require("mini.pairs").setup(opts)
          -- end
        },


      },
      version = false, -- telescope did only one release, so use HEAD for now
      keys = {
        { "<space>wt" },
        { "<space>/" },
        { "<space>en" },
        { "<leader>uC" },
        { "<space>bo" },
        { "<space>fh" },
        { "<space>ff" },
        { "<leader>sd" },
        { "<space>fi" },
        { "<leader>'" },
        { "<leader>:" },
        { "<space>fp" },
        { "<leader>," },
        { "<space>gc" },
        { "<space>gs" },
        { "<space>fe" },
        { "<space>fv" },
        { "<leader>sM" },
        { "<leader>sR" },
        { "<space>pp" },
        { "<space>pP" },
        { "<space>fs" },
        { "<space>fd" },
        { "<space>fO" },
        { ",fo" },
        { "<space>fo" },
        { "<space>fg" },
        { "<leader>/" },
        { "<space>ft" },
        { "<space><space>d" },
        { "<leader>dd" },
        { "gl" },
        { "<space>ez" },
        { "<leader>;" },
        { "<space>f/" },
        { "<leader>fr" },
        { "gw" },
        { "<space>fb" },
        { "<space>fa" },
        { "<space>gp" },
        { "<space>fB" },
        { "<leader>sK" },
      },
      event = { "BufReadPost", "BufNewFile" },
      --
      opts = {
        module = {
          keymaps = {
            {
              "<space>ez",
              "edit_project_files",
              desc = "Edit zsh config",
              picker_opts = {
                shorten_path = false,
                cwd = "~/.config/zsh/",
                prompt = "~ zsh config ~",
                hidden = true,

                layout_strategy = "horizontal",
                layout_config = {
                  -- preview_width = 0.55,
                  width = 0.9,
                },

              },
            },
            {
              "<space>en",
              "edit_project_files",
              desc = "Edit Neovim Config (lvim)",
              picker_opts = {
                prompt_title = "Neovim config",
                shorten_path = false,
                cwd = "~/.config/lvim",

                layout_strategy = "horizontal",
                layout_config = {
                  -- preview_width = 0.55,
                  width = 0.9,
                },
              },
            },
          },
        },
        which_key = {
          mode = { "n", "v" },
          ["<Space>"] = { name = "+Telescope" },
          ["<Space>e"] = { name = "+edit files" },
          ["<Space>f"] = { name = "+files and find" },
          ["<Space>g"] = { name = "+git" },
          ["<Space>p"] = { name = "+projects" },
          ["<Space>b"] = { name = "+options" },
          ["<Space>w"] = { name = "+treesitter" },
        },
      },
      config = function(_, opts)
        require("lvm.telescope").setup(opts)
        local qt = require("telescope").load_extension("query-tools")
        -- require("telescope._extensions.query-tools.config").setup(opts)

        local wk = require "which-key"
        wk.register(opts.which_key)
      end,
    }
  }
end
-- return {

--   { dir = "~/dev/neovim-plugins/lvm-telescope.nvim", import = "lvm.telescope.plugins" },
-- }
