-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "github_light",

  hl_override = {
    Comment = {
      italic = false,
      fg = "#d2f4ff",
    },
    ["@comment"] = {
      italic = false,
      fg = "#d2f4ff",
    },
  },
}

M.ui = {
  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "round",
    order = nil,
    modules = nil,
  },
  tabufline = {
    order = { "buffers", "tabs", "btns" },
  },
}

return M
