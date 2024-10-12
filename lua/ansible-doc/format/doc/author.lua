local put = require('ansible-doc.format.util').put


return function(bufnr, authors)
	put(bufnr, {
		'',
		string.format('AUTHOR: %s', table.concat(authors, ', ')),
	})
end
