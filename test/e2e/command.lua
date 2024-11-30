local yd = require 'yo-dawg'


describe('The AnsibleDoc command', function()
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

	it('throws an error for wrong module name', function()
		local success = pcall(nvim.command, nvim, 'AnsibleDoc XXXXXXXXXXX')
		assert.is_false(success)
	end)

	it('does not open a new window for wrong module name', function()
		local old_windows = nvim:tabpage_list_wins(0)
		pcall(nvim.command, nvim, 'AnsibleDoc XXXXXXXXXXX')
		local new_windows = nvim:tabpage_list_wins(0)
		-- Error is raised, no new windows are opened
		assert.are_same(old_windows, new_windows)
	end)
end)
