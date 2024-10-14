local put = require('ansible-doc.format.util').put


local function put_item(bufnr, item)
	local module = item.module
	local parts = vim.split(module, '.', {plain=true})
	-- NOTE: Instead of a hyperlink we should have an interactive reference
	-- where the user can press 'K' to jump to that documentation entry.
	put(bufnr, {
		string.format('    • Module %s', module),
		string.format('         The official documentation on the %s module.', module),
		string.format('         https://docs.ansible.com/ansible-core/2.17/collections/%s_module.html', table.concat(parts, '/')),
	})
end


return function(bufnr, seealso)
	put(bufnr, {'', 'SEE ALSO'})
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 1
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocSectionHeading', linenr, 0,  #'SEE ALSO')

	for _, item in ipairs(seealso) do
		put_item(bufnr, item)
	end
end
