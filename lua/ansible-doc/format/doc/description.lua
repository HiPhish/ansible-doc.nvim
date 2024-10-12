local put = require('ansible-doc.format.util').put
local feedkeys = vim.api.nvim_feedkeys

return function(_bufnr, lines)
	vim.fn.append(vim.fn.line('$'), string.format('  %s', table.concat(lines, '  ')))
	vim.cmd 'normal! Ggwip'
end
