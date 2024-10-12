" Use the mock ansible-doc during testing
let g:ansibledocprg = 'test/mock/bin/ansible-dock'

execute 'set rtp+=' .. getcwd()
