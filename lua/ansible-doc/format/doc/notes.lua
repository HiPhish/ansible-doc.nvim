local put = require('ansible-doc.format.util').put

local function format_note(bufnr, note)
	vim.fn.appendbufline(bufnr, '$', string.format('    • %s', note))
	vim.cmd 'normal! Ggww'
end

return function(bufnr, notes)
	put(bufnr, {
		'',
		'NOTES',
	})
	for _, note in ipairs(notes) do
		format_note(bufnr, note)
	end
end
