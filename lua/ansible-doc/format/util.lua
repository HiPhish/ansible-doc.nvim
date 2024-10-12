---Various functions I don't want to write more than once
local M = {}

local WIDTH = 79
local set_lines = vim.api.nvim_buf_set_lines

function M.breakline(line, indent)
	indent = indent or 0

	local result = {}
	-- TODO: break the line into chunks
	while true do
		if vim.fn.strwidth(line) <= WIDTH then
			table.insert(result, line)
			break
		end
		-- TODO: chop off a reasonable amount of the string, push it to the
		-- result, assign the remainder to `line`
	end
	return table.concat(result, '\n')
end

function M.put(bufnr, lines)
	if type(lines) == 'string' then
		lines = {lines}
	end
	set_lines(bufnr, -1, -1, true, lines)
end

return M
