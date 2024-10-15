local yd = require 'yo-dawg'


describe('Interaction with the document contents', function()
	local nvim

	before_each(function()
		nvim = yd.start()
		nvim:command 'AnsibleDoc ansible.builtin.command'
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	it('follows cross-references', function()
		nvim:win_set_cursor(0, {7, 65})
		local old_buffer = nvim:get_current_buf()
		nvim:feedkeys('K', 'm', true)
		local new_buffer = nvim:get_current_buf()
		assert.not_equal(old_buffer, new_buffer)
		local bufname = nvim:buf_get_name(new_buffer)
		assert.are_equal('ansibledoc://ansible.builtin.shell', bufname)
	end)
end)
