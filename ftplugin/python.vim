map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

setlocal omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
setlocal completeopt=menuone,longest,preview
let g:pep8_map='<leader>8'
let g:pyflakes_use_quickfix = 0

setlocal sw=4  " Autoident uses 4 space tabs
setlocal sts=4 " Tabs become 4 spaces while editing
setlocal ts=4  " Tabs are 4 if they're in the file

