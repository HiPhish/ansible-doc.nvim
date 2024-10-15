local yd = require 'yo-dawg'


describe('The documentation window', function()
	local nvim

	before_each(function()
		nvim = yd.start()
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	it('opens in a new window', function()
		local first_window = nvim:get_current_win()
		nvim:command 'AnsibleDoc ansible.builtin.command'
		local second_window = nvim:get_current_win()
		assert.not_equal(first_window, second_window)
	end)

	it('reuses the same window', function()
		local first_window = nvim:get_current_win()
		nvim:command 'AnsibleDoc ansible.builtin.command'
		local second_window = nvim:get_current_win()
		nvim:tabpage_set_win(0, first_window)
		nvim:command 'AnsibleDoc ansible.builtin.shell'
		local third_window = nvim:get_current_win()
		assert.are_equal(second_window, third_window)
	end)

	it('prefers the current window', function()
		nvim:command 'AnsibleDoc ansible.builtin.command'
		nvim:command 'vsplit'
		local other_window = nvim:get_current_win()
		nvim:command 'AnsibleDoc ansible.builtin.shell'
		assert.are_equal(other_window, nvim:get_current_win())
	end)

	it('can handle missing keys in a document', function()
		local first_window = nvim:get_current_win()
		-- This module has no notes
		nvim:command 'AnsibleDoc ansible.builtin.file'
		local second_window = nvim:get_current_win()
		assert.not_equal(first_window, second_window)
	end)

	describe('the buffer options', function()
		before_each(function()
			nvim:command 'AnsibleDoc ansible.builtin.command'
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
end)
