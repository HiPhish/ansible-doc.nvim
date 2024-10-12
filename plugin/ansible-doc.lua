if vim.g.loaded_ansibledoc ~= nil then
  return
end
vim.g['loaded_ansibledoc'] = true

local ansible_doc = require 'ansible-doc'

local function render_doc(params)
	local doc = ansible_doc.doc(params.fargs[1])
	ansible_doc.render(0, doc)
	vim.bo.filetype = 'ansibledoc'
end

vim.api.nvim_create_user_command('AnsibleDoc', render_doc, {nargs=1})
