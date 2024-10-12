local put = require('ansible-doc.format.util').put
local appendbufline = vim.fn.appendbufline


local KEYS = {'returned', 'sample', 'type'}
local LABELS = {
	returned = 'returned',
	sample = 'sample',
	type = 'type',
}

local function put_item(bufnr, name, item)
	put(bufnr, {'', string.format('  %s', name)})
	appendbufline(bufnr, '$', string.format('    %s', item.description))
	vim.cmd 'normal! Ggww'
	for _, key in ipairs(KEYS) do
		local value = item[key]
		if value then
			-- FIXME: The formatting depends on the `type` field of the item
			appendbufline(bufnr, '$', string.format('    %s: %s', LABELS[key], value))
		end
	end
end

return function(bufnr, items)
	put(bufnr, {'', 'RETURN VALUES:'})
	local names = vim.tbl_keys(items)
	table.sort(names)
	for _, name in ipairs(names) do
		put_item(bufnr, name, items[name])
	end
end
