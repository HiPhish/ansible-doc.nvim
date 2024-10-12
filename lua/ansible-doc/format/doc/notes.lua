local put = require('ansible-doc.format.util').put

local function format_note(note)
	vim.fn.append(vim.fn.line('$'), string.format('    • %s', note))
	vim.cmd 'normal! Ggww'
end

return function(bufnr, notes)
	put(bufnr, {
		'',
		'NOTES:',
	})
	put(bufnr, vim.tbl_map(format_note, notes))
end
