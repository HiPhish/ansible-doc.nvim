local yd = require 'yo-dawg'


describe('The documentation window', function()
	local nvim

	before_each(function()
		nvim = yd.start()
	end)

	after_each(function()
		yd.stop(nvim)
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

	it('can handle a single author', function()
		nvim:command 'AnsibleDoc amazon.aws.aws_az_info'
	end)

	it('can handle a single line of description', function()
		nvim:command 'AnsibleDoc amazon.aws.backup_plan'
	end)

	it('can handle a missing sample', function()
		nvim:command 'AnsibleDoc amazon.aws.backup_plan'
	end)
end)
