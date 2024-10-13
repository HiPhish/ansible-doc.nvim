local put = require('ansible-doc.format.util').put
local appendbufline = vim.fn.appendbufline


local KEYS = {'returned', 'type'}
local LABELS = {
	returned = 'returned',
	sample = 'sample',
	type = 'type',
}

local format_sample
local formatters = {
	string = function(value)
		return string.format('"%s"', value)
	end,
	number = function(value)
		return string.format('%d', value)
	end,
	boolean = function(value)
		return value and 'true' or 'false'
	end,
	table = function(value)
		if vim.islist(value) then
			local items = vim.tbl_map(format_sample, value)
			return string.format('[%s]', table.concat(items, ', '))
		end
		local items = {}
		for k, v in pairs(value) do
			table.insert(items, string.format('%s: %s', format_sample(k), format_sample(v)))
		end
		return string.format('{%s}', table.concat(items, ', '))
	end,
}

function format_sample(sample)
	local formatter = formatters[type(sample)]
	return formatter(sample)
end

local function put_item(bufnr, name, item)
	put(bufnr, {'', string.format('  %s', name)})
	appendbufline(bufnr, '$', string.format('    %s', item.description))
	vim.cmd 'normal! Ggww'
	for _, key in ipairs(KEYS) do
		appendbufline(bufnr, '$', string.format('    %s: %s', LABELS[key], item[key]))
	end
	appendbufline(bufnr, '$', string.format('    %s: %s', LABELS.sample, format_sample(item.sample)))
end

return function(bufnr, items)
	put(bufnr, {'', 'RETURN VALUES'})
	local names = vim.tbl_keys(items)
	table.sort(names)
	for _, name in ipairs(names) do
		put_item(bufnr, name, items[name])
	end
end
