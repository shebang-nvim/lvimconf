local utils = require "utils"



local actions = {}
actions.buffer = {}

local wrap_desc =utils.wrap_desc

actions.buffer.delete = wrap_desc(function()
  if utils.has("mini.bufremove") then
    require("mini.bufremove").delete(0, true)
  else
    vim.cmd([[bdelete]])
  end
end, "Buffer Delete")

actions.buffer.trim_trailing_whitespace = wrap_desc(function()
  if utils.has("mini.trailspace") then
    require("mini.trailspace").trim()
  end
end, "Buffer Trim Trailing Whitespace")

actions.buffer.highlight_trailing_whitespace = wrap_desc(function()
  if utils.has("mini.trailspace") then
    require("mini.trailspace").track_normal_buffer()
  end
end, "Buffer Highlight Trailing Whitespace")

return {
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    main = 'mini.pairs',
    -- config = function (_, opts)
    --   require("mini.pairs").setup(opts)
    -- end
  },

  -- surround
  {
    "echasnovski/mini.surround",

    enabled = true,
    main = 'mini.surround',
    event = "VeryLazy",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete surrounding" },
        { opts.mappings.find,           desc = "Find right surrounding" },
        { opts.mappings.find_left,      desc = "Find left surrounding" },
        { opts.mappings.highlight,      desc = "Highlight surrounding" },
        { opts.mappings.replace,        desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      vim.list_extend(mappings, keys)
      return mappings
    end,
    opts = {
      mappings = {
        add = "sa",            -- Add surrounding in Normal and Visual modes
        delete = "sd",         -- Delete surrounding
        find = "sf",           -- Find surrounding (to the right)
        find_left = "sF",      -- Find surrounding (to the left)
        highlight = "sh",      -- Highlight surrounding
        replace = "sr",        -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },

  {
    "echasnovski/mini.comment",
    event = { "BufReadPost", "BufNewFile" },
    main = "mini.comment",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring {}
        end,
      },
    },
    -- config = function(_, opts)
    --   require("mini.comment").setup(opts)
    -- end,
  },

  {
    "echasnovski/mini.bufremove",
    keys = function(_, keys)
      return {
        { "<Leader>bd", actions.buffer.delete.rhs, { desc = actions.buffer.delete.desc } },
      }
    end,
    version = "*",
  },

  -- {
  --   "echasnovski/mini.jump",
  --   enabled = false,
  --   event = { "BufReadPost", "BufNewFile" },
  --   config = function()
  --     require("mini.jump").setup {
  --       -- Module mappings. Use `''` (empty string) to disable one.
  --       mappings = {
  --         forward = "f",
  --         backward = "F",
  --         forward_till = "t",
  --         backward_till = "T",
  --         repeat_jump = ";",
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.misc",
  --   lazy = false,
  --   opts = { make_global = { "put", "put_text", "get_gutter_width", "resize_window", "find_root", "zoom" } },
  --   config = function(_, opts)
  --     require("mini.misc").setup(_, opts)
  --     local mini_misc = require "mini.misc"
  --     mini_misc.setup_restore_cursor()
  --     -- mini_misc.setup_auto_root()
  --   end,
  -- },

  {
    "echasnovski/mini.doc",
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.doc").setup()
    end,
  },

  {
    "echasnovski/mini.trailspace",
    version = "*",
    lazy = false,
    event = { "BufWritePre", "InsertLeave" },
    config = function(_, opts)
      require("mini.trailspace").setup(opts)
      local default_config = {

        autotrim_trailing_whitespace = {
          enabled_ft = {
            "lua",
          },
        },
      }


      local handlers = {}
      --- Insert leave root handler
      ---@param event AutocmdEvent
      ---@param opts table
      -- handlers.insert_leave = function(event, opts)
      --   -- lvm.log:debug("insert_leave root handler", event)
      --   local ft = vim.bo.filetype
      --   if vim.tbl_contains(default_config.autotrim_trailing_whitespace.enabled_ft, ft) then
      --     actions.buffer.trim_trailing_whitespace.rhs(event, opts)
      --   end
      -- end

      handlers.buf_write_pre = function(event, opts)
        -- lvm.log:debug("buf_write_pre root handler", event)
        local ft = vim.bo.filetype
        if vim.tbl_contains(default_config.autotrim_trailing_whitespace.enabled_ft, ft) then
          actions.buffer.trim_trailing_whitespace.rhs(event, opts)
        end
      end

      handlers.buf_win_enter = function(event, opts)
        -- lvm.log:debug("buf_win_enter root handler", event)
        local ft = vim.bo.filetype
        if vim.tbl_contains(default_config.autotrim_trailing_whitespace.enabled_ft, ft) then
          actions.buffer.highlight_trailing_whitespace.rhs(event, opts)
        end
      end
      -- Delegate to insert_leave handler
      -- vim.api.nvim_create_autocmd("InsertLeave", {
      --   pattern = "*",
      --   group = utils.augroup "insert_leave",
      --   callback = handlers.insert_leave,
      -- })

      -- Delegate to buf_write_pre handler
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        group = utils.augroup "buf_write_pre",
        callback = handlers.buf_write_pre,
      })

      -- Delegate to buf_win_enter handler
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = "*",
        group = utils.augroup "buf_win_enter",
        callback = handlers.buf_win_enter,
      })


    end,
  },

  -- {
  --   "echasnovski/mini.align",
  --   version = "*",
  --   event = { "BufReadPost", "BufNewFile" },
  --   lazy = false,

  --   keys = {
  --     { "ga", mode = { "n", "v" }, desc = "Initiate Alignment" },
  --     { "gA", mode = { "n", "v" }, desc = "Initiate Alignment with Preview" },
  --   },
  --   opts = {
  --     mappings = {
  --       start = "ga",
  --       start_with_preview = "gA",
  --     },
  --   },

  --   config = function(_, opts)
  --     require("mini.align").setup(opts)
  --   end,
  -- },

  {
    "echasnovski/mini.splitjoin",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    main = "mini.splitjoin",
    opts = {
      detect = {
        -- Detect only inside balanced parenthesis
        brackets = { "%b()" },

        -- Allow both `,` and `;` to separate arguments
        separator = "[,;]",

        -- Make any separator define an argument
        exclude_regions = {},
      },
    },
    keys = { "gS", mode = { "n", "v" } },
    -- config = function(_, opts)
    --   require("mini.splitjoin").setup(opts)
    -- end,
  },

  -- -- better text-objects
  -- {
  --   "echasnovski/mini.ai",
  --   keys = {
  --     { "a", mode = { "x", "o" } },
  --     { "i", mode = { "x", "o" } },
  --   },
  --   event = { "BufReadPost", "BufNewFile" },
  --   dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  --   opts = function()
  --     local ai = require "mini.ai"
  --     return {
  --       n_lines = 500,
  --       custom_textobjects = {
  --         o = ai.gen_spec.treesitter({
  --           a = { "@block.outer", "@conditional.outer", "@loop.outer" },
  --           i = { "@block.inner", "@conditional.inner", "@loop.inner" },
  --         }, {}),
  --         f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
  --         c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     require("mini.ai").setup(opts)
  --     -- register all text objects with which-key
  --     if utils.has "which-key.nvim" then
  --       ---@type table<string, string|table>
  --       local i = {
  --         [" "] = "Whitespace",
  --         ['"'] = 'Balanced "',
  --         ["'"] = "Balanced '",
  --         ["`"] = "Balanced `",
  --         ["("] = "Balanced (",
  --         [")"] = "Balanced ) including white-space",
  --         [">"] = "Balanced > including white-space",
  --         ["<lt>"] = "Balanced <",
  --         ["]"] = "Balanced ] including white-space",
  --         ["["] = "Balanced [",
  --         ["}"] = "Balanced } including white-space",
  --         ["{"] = "Balanced {",
  --         ["?"] = "User Prompt",
  --         _ = "Underscore",
  --         a = "Argument",
  --         b = "Balanced ), ], }",
  --         c = "Class",
  --         f = "Function",
  --         o = "Block, conditional, loop",
  --         q = "Quote `, \", '",
  --         t = "Tag",
  --       }
  --       local a = vim.deepcopy(i)
  --       for k, v in pairs(a) do
  --         a[k] = v:gsub(" including.*", "")
  --       end

  --       local ic = vim.deepcopy(i)
  --       local ac = vim.deepcopy(a)
  --       for key, name in pairs { n = "Next", l = "Last" } do
  --         i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
  --         a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
  --       end
  --       require("which-key").register {
  --         mode = { "o", "x" },
  --         i = i,
  --         a = a,
  --       }
  --     end
  --   end,
  -- },
}
