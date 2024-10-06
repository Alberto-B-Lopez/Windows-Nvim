return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")
		local install = require("nvim-treesitter.install")

		install.compilers = { "gcc" }

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
				disable = { "vimdoc", "go", "vim" },
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
				filetypes = {
					"html",
					"sql",
					"sas",
					"javascript",
					"typescript",
					"java",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"tsx",
					"rescript",
					"xml",
					"php",
					"markdown",
					"astro",
					"glimmer",
					"handlebars",
					"hbs",
				},
			},
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"java",
				"prisma",
				"python",
				"markdown",
				"markdown_inline",
				"svelte",
				"go",
				"sql",
				"graphql",
				"bash",
				"lua",
				"vim",
				"vimdoc",
				"c",
				"cpp",
				"dockerfile",
				"gitignore",
			},
			-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			-- auto install above language parsers
			auto_install = true,
		})
	end,
}
