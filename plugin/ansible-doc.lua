if vim.g.loaded_ansibledoc ~= nil then
  return
end
vim.g['loaded_ansibledoc'] = true

local ansible_doc = require 'ansible-doc'


local all_entries  -- Caching of module names
local function complete(arg_lead, _cmd_line, _cursor_pos)
	local function pred(s)
		return vim.startswith(s, arg_lead)
	end
	-- Lazy loading so we don't need to get the list at startup
	if not all_entries then
		all_entries = vim.tbl_keys(ansible_doc.list())
	end
	return vim.tbl_filter(pred, all_entries)
end

local function render_doc(params)
	local doc = ansible_doc.doc(params.fargs[1])
	-- TODO: Use a dedicated Ansible documentation buffer
	ansible_doc.render(0, doc)
	vim.bo.filetype = 'ansibledoc'
end

vim.api.nvim_create_user_command('AnsibleDoc', render_doc, {
	nargs = 1,
	complete = complete,
	desc = 'Displays Ansible documentation'
})
