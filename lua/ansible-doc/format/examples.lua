local put = require('ansible-doc.format.util').put


return function(bufnr, examples)
	put(bufnr, {'', 'EXAMPLES:'})
	vim.fn.append(vim.fn.line('$'), examples)
	vim.cmd '$:s/\\v%U00/\\r/g'  -- replace ASCII NUL character with line break
end
