return function(bufnr, lines)
	vim.fn.appendbufline(bufnr, '$', string.format('  %s', table.concat(lines, '  ')))
	vim.cmd 'normal! Ggwip'
end
