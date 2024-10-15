local put = require('ansible-doc.format.util').put

local keys = {
	'options', 'attributes', 'notes', 'seealso', 'author'
}

local putters = {
	description = require 'ansible-doc.format.doc.description',
	options = require 'ansible-doc.format.doc.options',
	attributes = require 'ansible-doc.format.doc.attributes',
	notes = require 'ansible-doc.format.doc.notes',
	seealso = require 'ansible-doc.format.doc.seealso',
	author = require 'ansible-doc.format.doc.author',
}

return function(bufnr, doc)
	vim.api.nvim_buf_set_lines(bufnr, 0, 1, true, {string.format('MODULE %s (%s)', doc.plugin_name, doc.filename)})
	vim.api.nvim_buf_add_highlight(bufnr, -1, 'ansibledocHeader', 0, 0,  #'MODULE ' + #doc.plugin_name)
	vim.fn.appendbufline(bufnr, '$', '')
	putters.description(bufnr, doc.description)
	if doc.has_action then
		put(bufnr, {'', '* note: This module has a corresponding action plugin.'})
	end
	for _, key in ipairs(keys) do
		if doc[key] then
			putters[key](bufnr, doc[key])
		end
	end
end
