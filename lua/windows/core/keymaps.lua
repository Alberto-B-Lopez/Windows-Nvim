vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>r", [[:w<CR>:term python %<CR>]], { noremap = true, silent = true })

local keymap = vim.keymap -- for conciseness

-- NORMAL mode keymaps
keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
keymap.set("n", "<leader>a", "ggVG", { desc = "select all" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<C-_>", function()
	require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
-- Netrw Normal Mode
keymap.set("n", "<leader>ee", ":Explore<CR>", { desc = "Open Netrw" })
vim.keymap.set("n", "<leader>ma", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
	if buftype == "nofile" then
		local dir = vim.fn.expand("%:p:h")
		vim.cmd("call mkdir('" .. dir .. "', 'p')")
		vim.cmd("enew")
	else
		vim.notify("This mapping only works in the Netrw buffer", vim.log.levels.WARN)
	end
end, { desc = "Create a new file in Netrw" })

-- INSERT mode keymaps
keymap.set("i", "<C-f>", "<Right>", { desc = "Moves right in insert mode" })
keymap.set("i", "<C-b>", "<Left>", { desc = "Moves left in insert mode" })

-- VISUAL mode keymaps
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- keymap.set("v", "<C-j", ":m.1<CR>")
-- keymap.set("v", "<C-k", ":m.-2<CR>")
