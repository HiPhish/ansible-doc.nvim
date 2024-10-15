local yd = require 'yo-dawg'

describe('the buffer options', function()
	local nvim

	before_each(function()
		nvim = yd.start()
		nvim:command 'AnsibleDoc ansible.builtin.command'
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	it('has the correct file type', function()
		local filetype = nvim:get_option_value('filetype', {buf=0})
		assert.are_equal('ansibledoc', filetype)
	end)

	it('has the correct buffer name', function()
		nvim:command 'AnsibleDoc ansible.builtin.command'
		local bufname = nvim:buf_get_name(0)
		assert.are_equal('ansibledoc://ansible.builtin.command', bufname)
	end)

	it('has no file', function()
		local buftype = nvim:get_option_value('buftype', {buf=0})
		assert.are_equal('nofile', buftype)
	end)

	it('is not modifiable', function()
		local modifiable = nvim:get_option_value('modifiable', {buf=0})
		assert.is_false(modifiable)
	end)

	it('is read-only', function()
		local readonly = nvim:get_option_value('readonly', {buf=0})
		assert.is_true(readonly)
	end)
end)
