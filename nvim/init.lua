vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"
require "configs.catppuccin"
-- require "configs.conform"
require "configs.gitsigns"
require "configs.lazy"
-- require "configs.lspconfig"
require "configs.neogit"
require "configs.noice"
require "configs.notify"
require "configs.nvimtree"
require "configs.supermaven"
require "configs.transparent"

vim.schedule(function()
  require "mappings"
end)

vim.o.termguicolors = true
vim.cmd "colorscheme catppuccin-latte"
