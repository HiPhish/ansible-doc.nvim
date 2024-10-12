local put = require('ansible-doc.format.util').put


local KEYS = {'details', 'platforms', 'support'}

local LABELS = {
	platforms = 'platforms',
	details = 'details',
	support = 'support'
}


local function put_attribute(bufnr, name, attribute)
	put(bufnr, {
		'',
		string.format('  %s', name),
	})
	vim.fn.appendbufline(bufnr, '$', string.format('    %s', attribute.description))
	vim.cmd 'normal! Ggww'
	vim.fn.appendbufline(bufnr, '$', '')
	for _, key in ipairs(KEYS) do
		local value = attribute[key]
		if value then
			vim.fn.appendbufline(bufnr, '$', string.format('    %s: %s', LABELS[key], value))
		end
	end
end

return function (bufnr, attributes)
	put(bufnr, {'', 'ATTRIBUTES:'})

	local names = vim.tbl_keys(attributes)
	table.sort(attributes)

	for _, name in ipairs(names) do
		put_attribute(bufnr, name, attributes[name])
	end
end
