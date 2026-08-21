require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>q", ":q<cr>", { desc = "Quit" })
map("n", ";", ":", { desc = "Enter command mode" })
