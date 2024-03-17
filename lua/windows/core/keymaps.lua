vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>r", [[:w<CR>:term python %<CR>]], { noremap = true, silent = true })

local keymap = vim.keymap -- for conciseness

-- NORMAL mode keymaps
keymap.set("n", "<leader>a", "ggVG", { desc = "select all" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<C-_>", function()
	require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })

-- INSERT mode keymaps
keymap.set("i", "<C-f>", "<Right>", { desc = "Moves right in insert mode" })
keymap.set("i", "<C-b>", "<Left>", { desc = "Moves left in insert mode" })

-- VISUAL mode keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- keymap.set("v", "<C-j", ":m.1<CR>")
-- keymap.set("v", "<C-k", ":m.-2<CR>")
