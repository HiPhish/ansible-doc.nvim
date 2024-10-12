if vim.g.loaded_ansibledoc ~= nil then
  return
end
vim.g['loaded_ansibledoc'] = true

local ansible_doc = require 'ansible-doc'
local api = vim.api
local filetype = 'ansibledoc'


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
	local name = params.fargs[1]
	local doc = ansible_doc.doc(name)
	local bufname = string.format('ansibledoc://%s', name)
	local buffer, window

	-- Find previously opened buffer or create a new one
	for _, buf in ipairs(api.nvim_list_bufs()) do
		if api.nvim_buf_get_name(buf) == bufname then
			buffer = buf
		end
	end
	if not buffer then
		buffer = api.nvim_create_buf(true, false)
		api.nvim_buf_set_name(buffer, bufname)
		vim.bo[buffer].filetype = 'ansibledoc'
		api.nvim_set_option_value('filetype', filetype, {buf=buffer})
	end

	-- Find an already open Ansible documentation window or a open a new one
	for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
		local buf = api.nvim_win_get_buf(win)
		if api.nvim_get_option_value('filetype', {buf=buf}) == filetype then
			window = win
			break
		end
	end
	if not window then
		window = api.nvim_open_win(buffer, true, {split = 'above'})
	else
		api.nvim_win_set_buf(window, buffer)
		api.nvim_tabpage_set_win(0, window)
	end

	-- TODO: only do this if the buffer is newly created
	ansible_doc.render(0, doc)
	api.nvim_set_option_value('filetype', filetype, {buf=buffer})
	api.nvim_set_option_value('buftype', 'nofile', {buf=buffer})
	api.nvim_set_option_value('modifiable', false, {buf=buffer})
	api.nvim_set_option_value('readonly', false, {buf=buffer})
end

vim.api.nvim_create_user_command('AnsibleDoc', render_doc, {
	nargs = 1,
	complete = complete,
	desc = 'Displays Ansible documentation'
})
