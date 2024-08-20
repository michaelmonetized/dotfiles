-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "nightfox",

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

return M
