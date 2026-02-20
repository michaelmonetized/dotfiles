require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.columns = 160
-- o.cursorlineopt ='both' -- to enable cursorline!

-- ── Auto-detect macOS appearance (Catppuccin Mocha ↔ Latte) ──
-- Checks system theme on startup and via a timer so nvim follows
-- macOS appearance changes in real-time without restarting.
local function sync_macos_appearance()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if not handle then return end
  local result = handle:read("*a")
  handle:close()

  local is_dark = result:match("Dark") ~= nil
  local bg = is_dark and "dark" or "light"

  if vim.o.background ~= bg then
    vim.o.background = bg
  end
end

-- Sync on startup
sync_macos_appearance()

-- Poll every 5 seconds for system theme changes
local timer = vim.uv.new_timer()
if timer then
  timer:start(5000, 5000, vim.schedule_wrap(sync_macos_appearance))
end
