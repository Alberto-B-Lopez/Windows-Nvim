return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon.setup({
			settings = {
				save_on_toggle = true,
			},
		})
		-- REQUIRED

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():append()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "1", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "2", function()
			harpoon:list():select(2)
		end)
		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}