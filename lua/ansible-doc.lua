local M = {}

---Returns the entire inventory of Ansible modules
---@return {[string]: string} modules  Maps a module name to its description
function M.list()
	local obj = vim.system({'ansible-doc', '--list', '-j'}, {text=true}):wait()
	return vim.json.decode(obj.stdout)
end

---Fetches the documentation of a single module
---@param module string  Fully qualified module name
---@return table doc  The documentation as a Lua table
function M.doc(module)
	local ansibledocprg = vim.g['ansibledocprg'] or 'ansible-doc'
	local obj = vim.system({ansibledocprg, '-j', module}, {text=true}):wait()
	if obj.code ~= 0 then
		error(obj.stderr)
	end
	local result = vim.json.decode(obj.stdout)[module]
	if result == nil then
		error(string.format('No such module: %s', module))
	end
	return result
end

local render_doc = require 'ansible-doc.format.doc'
local render_examples = require 'ansible-doc.format.examples'
local render_return = require 'ansible-doc.format.return'

---Temporary function for development, replace with a proper function later on.
---Renders the documentation into the current buffer.
function M.render(bufnr, data)
	render_doc(bufnr, data.doc)
	render_examples(bufnr, data.examples)
	if data['return'] ~= vim.NIL then
		render_return(bufnr, data['return'])
	end
end

return M
