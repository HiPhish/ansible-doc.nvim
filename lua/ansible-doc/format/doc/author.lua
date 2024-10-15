local put = require('ansible-doc.format.util').put


return function(bufnr, author)
	if type(author) == 'table' then
		author = table.concat(author, ', ')
	end
	put(bufnr, {
		'',
		'AUTHOR',
		string.format('  %s', author),
	})
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 2
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocSectionHeading', linenr, 0,  #'AUTHOR')
end
