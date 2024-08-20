require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", {
    desc = "CMD enter command mode"
})
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Move line up with Ctrl-k
-- map("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })

-- Move line down with Ctrl-j
-- map("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })

-- Duplicate line up with Ctrl-Shift-k
-- map("n", "<A-C-k>", ":t.<CR>:m .-2<CR>==", { noremap = true, silent = true, desc = "Duplicate line up" })

-- Duplicate line down with Ctrl-Shift-j
-- map("n", "<A-C-j>", ":t.<CR>:m .+1<CR>==", { noremap = true, silent = true, desc = "Duplicate line down" })
