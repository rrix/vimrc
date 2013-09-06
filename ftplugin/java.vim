" Set :make in Java <F3> becomes make, <F4> becomes run.
map <F3> :make<CR>
map <F4> :!echo %\\|awk -F. '{print $1}'\\|xargs java<CR>
map! <F3> <Esc>:set makeprg=javac\\ %<CR>:make<CR>
map! <F4> <Esc>:!echo %\\|awk -F. '{print $1}'\\|xargs java<CR>
set makeprg="javac\\ %"
set errorformat="%A:%f:%l:\\ %m,%-Z%p^,%-C%.%#"

let g:SuperTabDefaultCompletionType = "<c-x><c-u>"

