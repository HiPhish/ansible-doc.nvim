local put = require('ansible-doc.format.util').put


return function(bufnr, examples)
	put(bufnr, {'', 'EXAMPLES'})
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 1
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocSectionHeading', linenr, 0,  #'EXAMPLES')
	vim.fn.appendbufline(bufnr, '$', examples)
	vim.cmd '$:s/\\v%U00/\\r/g'  -- replace ASCII NUL character with line break
end
