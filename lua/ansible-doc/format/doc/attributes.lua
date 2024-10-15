local put = require('ansible-doc.format.util').put


local KEYS = {'platforms', 'support'}

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
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 1
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocAttribute', linenr, 2, 2 + #name)

	vim.fn.appendbufline(bufnr, '$', string.format('    %s', attribute.description))
	vim.cmd 'normal! Ggww'
	vim.fn.appendbufline(bufnr, '$', '')
	if attribute.details then
		local value = attribute.details
		vim.fn.appendbufline(bufnr, '$', string.format('    %s:', LABELS['details']))
		vim.fn.appendbufline(bufnr, '$', string.format('        %s', value))
		vim.cmd 'normal! Ggww'  -- Break line and join it with the label line
		vim.fn.appendbufline(bufnr, '$', '')
	end
	for _, key in ipairs(KEYS) do
		local value = attribute[key]
		if value ~= nil then
			vim.fn.appendbufline(bufnr, '$', string.format('    %s: %s', LABELS[key], value))
		end
	end
end

return function (bufnr, attributes)
	put(bufnr, {'', 'ATTRIBUTES'})
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 1
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocSectionHeading', linenr, 0,  #'ATTRIBUTES')

	local names = vim.tbl_keys(attributes)
	table.sort(attributes)

	for _, name in ipairs(names) do
		put_attribute(bufnr, name, attributes[name])
	end
end
