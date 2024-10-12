" Use the mock ansible-doc during testing
let g:ansibledocprg = './test/mock/bin/ansible-doc'

execute 'set rtp+=' .. getcwd()
