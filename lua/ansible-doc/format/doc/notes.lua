local put = require('ansible-doc.format.util').put

local function format_note(bufnr, note)
	vim.fn.appendbufline(bufnr, '$', string.format('    • %s', note))
	vim.cmd 'normal! Ggww'
end

return function(bufnr, notes)
	put(bufnr, {'', 'NOTES'})
	local linenr = vim.api.nvim_buf_line_count(bufnr) - 1
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocSectionHeading', linenr, 0,  #'NOTES')

	for _, note in ipairs(notes) do
		format_note(bufnr, note)
	end
end
