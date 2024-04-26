return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local keymap = vim.keymap
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		lint.linters_by_ft = {
			typescript = { "biomejs", "eslint" },
			javascript = { "biomejs", "eslint" },
			typescriptreact = { "biomejs", "eslint" },
			javascriptreact = { "biomejs", "eslint" },
		}

		local eslint = lint.linters.eslint_d

		eslint.args = {
			"--no-warn-ignored", -- <-- this is the key argument
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			-- sql = { "sqlfluff" },
			python = { "flake8" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
		keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Manually trigger linting in current file" })
	end,
}
