local attributes = require 'ansible-doc.format.doc.attributes'
local author = require 'ansible-doc.format.doc.author'
local description = require 'ansible-doc.format.doc.description'
local notes = require 'ansible-doc.format.doc.notes'
local seealso = require 'ansible-doc.format.doc.seealso'
local options = require 'ansible-doc.format.doc.options'
local put = require('ansible-doc.format.util').put

return function(bufnr, doc)
	vim.api.nvim_buf_set_lines(bufnr, 0, 1, true, {string.format('MODULE %s (%s)', doc.plugin_name, doc.filename)})
	vim.fn.appendbufline(bufnr, '$', '')
	description(bufnr, doc.description)
	if doc.has_action then
		put(bufnr, {'', '* note: This module has a corresponding action plugin.'})
	end
	options(bufnr, doc.options)
	attributes(bufnr, doc.attributes)
	notes(bufnr, doc.notes)
	seealso(bufnr, doc.seealso)
	author(bufnr, doc.author)
end
