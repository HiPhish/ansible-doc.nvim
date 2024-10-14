local put = require('ansible-doc.format.util').put

local labels = {
	type = 'type',
	elements = 'elements',
	default = 'default',
	version_added = 'Added in version',
	version_added_collection = 'Added to collection',
}

local keys = {'default', 'elements', 'type'}


local function put_option(bufnr, name, option)
	put(bufnr, {
		'',
		string.format('  %s%s', name, option.required and ' (required)' or ''),
	})
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 1
	if option.required then
		vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocOptionRequired', linenr, 2, 2 + #name)
	else
		vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocOption', linenr, 2, 2 + #name)
	end
	vim.fn.appendbufline(bufnr, '$', string.format('    %s', table.concat(option.description, '  ')))
	vim.cmd 'normal! Ggww'
	vim.fn.appendbufline(bufnr, '$', '')
	for _, key in ipairs(keys) do
		local value = option[key]
		if value then
			vim.fn.appendbufline(bufnr, '$', string.format('    %s: %s', labels[key], value))
		end
	end
end


return function(bufnr, options)
	put(bufnr, {'', 'OPTIONS (red indicates it is required)'})
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 1
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocSectionHeading', linenr, 0,  7)
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocOptionRequired', linenr, 9, 12)

	local names = vim.tbl_keys(options)
	table.sort(names)

	for _, name in ipairs(names) do
		put_option(bufnr, name, options[name])
	end
end
