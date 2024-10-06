return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local keymap = vim.keymap
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				sql = { "sqlfluff" },
				go = { "gopls" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
			end,
		})

		-- Have this code just in case go.nvim goes crazy again
		--
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	callback = function()
		-- 		local filetype = vim.bo.filetype
		--
		-- 		if filetype ~= "go" then
		-- 			conform.format({ async = true })
		-- 		end
		-- 	end,
		-- })

		keymap.set({ "n", "v" }, "<leader>sf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			})
		end, { desc = "Format file or range selected" })
	end,
}
