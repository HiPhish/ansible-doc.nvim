local put = require('ansible-doc.format.util').put


return function(bufnr, authors)
	put(bufnr, {
		'',
		'AUTHOR',
		string.format('  %s', table.concat(authors, ', ')),
	})
end
