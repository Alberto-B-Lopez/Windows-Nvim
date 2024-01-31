local cmp = require("cmp")
local path = os.getenv("PBV")

local config = vim.fn.expand(path)
if vim.fn.filereadable(config) == 0 then
	return
end

local database = vim.fn.json_decode(vim.fn.readfile(config))

local source = {}

source.new = function()
	return setmetatable({}, { __index = source })
end

source.get_keyword_completions = function(self, keyword)
	for table_name, value in pairs(database) do
		if string.match(table_name, "^" .. keyword) then
			return value["values"]
		end
	end
end

source.regex_pattern = "%w+%.%s*(%w+_%w+[_%w]*)%."

source.complete = function(self, request, callback)
	local trigger = false
	local cursor_pos = request.offset
	local line = request.context.cursor_before_line
	local stdmv = string.sub(line, cursor_pos - 18, cursor_pos)
	local cursor_col = vim.fn.col(".")
	local table_name = line:sub(1, cursor_col):match(self.regex_pattern)

	if vim.startswith(string.lower(stdmv), "pnr_booking_views.") then
		trigger = true
	end

	if table_name then
		local items = {}
		local completion = self:get_keyword_completions(table_name)
		if completion then
			local table_len = #completion["Field Description"]
			for i = 1, table_len do
				table.insert(items, {
					label = completion["Physical Field Name"][i],
					documentation = {
						kind = "markdown",
						value = completion["Field Description"][i],
					},
				})
			end
		end
		callback({
			items = items,
			isIncomplete = true,
		})
	elseif trigger then
		local items = {}
		for k, data in pairs(database) do
			table.insert(items, {
				label = k,
			})
		end
		callback({
			items = items,
			isIncomplete = true,
		})
	else
		callback({ isIncomplete = true })
	end
end

cmp.register_source("pnr_booking_views", source)

cmp.setup.filetype("sql", {
	sources = cmp.config.sources({
		{ name = "secmv" },
		{ name = "pnr_booking_views" },
		{ name = "stdmv" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
	}),
	window = {
		documentation = cmp.config.window.bordered(),
	},
})
