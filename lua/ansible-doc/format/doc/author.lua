local put = require('ansible-doc.format.util').put


return function(bufnr, authors)
	put(bufnr, {
		'',
		'AUTHOR',
		string.format('  %s', table.concat(authors, ', ')),
	})
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 2
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocSectionHeading', linenr, 0,  #'AUTHOR')
end
