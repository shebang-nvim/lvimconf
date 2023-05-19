--- Annotations for my custom LunarVim config
---@class LunarVimLvimLazySpecConfig
---@field spec LazySpec: spec for lazy.nvim
---
---@class LunarVimLvimLazyConfig
---@field opts table: opts for lazy.nvim
---
---@class LunarVimLvimConfig: any: lvim config table to be merged with lvim`lvim`
---@field colorscheme string: colorscheme 
---@field lazy LunarVimLvimLazyConfig: lazy config settings
---
---@class LunarVimCustomConfig: any: custom config table `lvim.custom_config`
---@field enable_dev_mode boolean: enables developer features
---@field shared_data_dir string: alternative data directory when using multiple neovim configs, default: `~/.local/state/nvim`
---@field shared_lua_files string[]: path to local lua files to be loaded on startup, default: `~/.config/nvim/lua/globals.lua`
---@field shadafile string: alternative shadafile, default: `~/.local/state/nvim/shada/main.shada`
---@field undodir string: path to undodir, default: `~/.local/state/nvim/undo`
---
---@class LvimConfConfig: any: lvimconf config table
---@field lvim LunarVimLvimConfig: standard lvim config settings 
---@field custom_config LunarVimCustomConfig: custom config settings
---
---@alias AutocmdPattern string|string[]

---@class AutocmdEvent
---@field buf integer
---@field event string
---@field file string
---@field group integer
---@field id integer
---@field line integer
---@field match string

---FIXME: This seems not to be defined anywhere in vim runtime
---@enum VimLogLevel
local _ = {
  TRACE = 0,
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
  OFF = 5,
}

--
-- from lazy.nvim

---@alias LazyPluginKind "normal"|"clean"|"disabled"

---@alias PluginOpts table|fun(self:LazyPlugin, opts:table):table?


---@class LazyPluginRef
---@field branch? string
---@field tag? string
---@field commit? string
---@field version? string
---@field pin? boolean
---@field submodules? boolean Defaults to true

---@class LazyPluginBase
---@field [1] string?
---@field name string display name and name used for plugin config files
---@field main? string Entry module that has setup & deactivate
---@field url string?
---@field dir string
---@field enabled? boolean|(fun():boolean)
---@field cond? boolean|(fun():boolean)
---@field lazy? boolean
---@field priority? number Only useful for lazy=false plugins to force loading certain plugins first. Default priority is 50
---@field dev? boolean If set, then link to the respective folder under your ~/projects

---@class LazyPlugin: LazyPluginBase
---@field dependencies? string[]

---@class LazyPluginSpecHandlers
---@field event? string[]|string|fun(self:LazyPlugin, event:string[]):string[]
---@field cmd? string[]|string|fun(self:LazyPlugin, cmd:string[]):string[]
---@field ft? string[]|string|fun(self:LazyPlugin, ft:string[]):string[]
---@field keys? string|string[]|LazyKeys[]|fun(self:LazyPlugin, keys:string[]):(string|LazyKeys)[]
---@field module? false

---@class LazyPluginSpec: LazyPluginBase
---@field dependencies? string|string[]|LazyPluginSpec[]

---@alias LazySpec string|LazyPluginSpec|LazySpecImport|LazySpec[]

---@class LazySpecImport
---@field import string spec module to import
---@field enabled? boolean|(fun():boolean)
---
---@class LazyKeys
---@field [1] string lhs
---@field [2]? string|fun()|false rhs
---@field desc? string
---@field mode? string|string[]
---@field noremap? boolean
---@field remap? boolean
---@field expr? boolean
---@field id string

--
-- from nvim-treesitter/nvim-treesitter
--

---@class TSModule
---@field module_path string
---@field enable boolean|string[]|function(string): boolean
---@field disable boolean|string[]|function(string): boolean
---@field keymaps table<string, string>
---@field is_supported function(string): boolean
---@field attach function(string)
---@field detach function(string)
---@field enabled_buffers table<integer, boolean>
---@field additional_vim_regex_highlighting boolean|string[]

---@class TSConfig
---@field modules {[string]:TSModule}
---@field sync_install boolean
---@field ensure_installed string[]|string
---@field ignore_install string[]
---@field auto_install boolean
---@field parser_install_dir string|nil
