" {{{1
" ==== Sane defaults ==== {{{2
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible        " Use Vim defaults (much better!)
set ai                  " always set autoindenting on
set viminfo=!,'20,\"50  " read/write a .viminfo file, don't store more
                        " than 50 lines of registers, store globals
set history=50          " keep 50 lines of command line history
set dir=/var/tmp,/tmp,.

if exists('+undofile')
  set undodir=~/.vim/undodir
  set undofile
end

" Pathogen plugin manager
call pathogen#infect()

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif
" }}}2

" ==== Appearance related variables ==== {{{2
set ruler               " show the cursor position all the time
syntax on
set so=6                " Number of liness to keep above and below the cursor
set pt=<F2>             " Toggle paste mode on F2
let &guicursor = &guicursor . ",a:blinkon0" " Don't wake up system with blinking cursor:
filetype plugin on
set lbr                 " break on words rather than lines when wrapping in editor
set ls=2                " Always draw a status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %{getcwd()}\ \ \ Line:\ %l/%L:%c " Sexy Status Line
set number              " Show line numberse
set numberwidth=3       " Three digit line numbers

" Solarized {{{3
let g:solarized_termtrans=1
let g:solarized_menu=1
colorscheme solarized
" }}}3
" }}}2

" ==== Formatting options ==== {{{2
set et                  " Tabs become spaces
set sw=2                " Autoident uses 4 space tabs
set sts=2               " Tabs become 4 spaces while editing
set fo+=l               " Don't wrap long lines if they're long when you enter insert mode
set fo+=2               " Use second line for indent
set tw=78               " Wrap at 78 characters
" }}}2

" ==== Search related variables==== {{{2
set is                  " Jump to result while searching
" set ic                  " Ignore case when searching
" set scs                 " Don't ignore case if you change case
set nohls               " Don't highlight search results
" }}}2

" ==== Filetype Sources ==== {{{2
au BufNewFile,BufRead *.cpp,*.h                    source ~/.vim/plugin/cpp.vimrc
au BufNewFile,BufRead *.java                       source ~/.vim/plugin/java.vimrc
au BufNewFile,BufRead *.js,*.json                  source ~/.vim/plugin/json.vim
au BufNewFile,BufRead *.pde                        source ~/.vim/plugin/arduino.vim
au BufNewFile,BufRead *.rb,*.haml,*.erb            source ~/.vim/plugin/ruby.vim
au BufNewFile,BufRead *.tex                        source ~/.vim/plugin/tex.vimrc
au BufNewFile,BufRead /home/rrix/Documents/blag    source ~/.vim/plugin/blag.vim
au BufNewFile,BufRead /home/rrix/Documents/hslblag source ~/.vim/plugin/hslblag.vim
au BufNewFile,BufRead /home/rrix/dev/trunk/*       source ~/dev/trunk/kdesdk/scripts/kde-devel-vim.vim
au BufNewFile,BufRead *.md                         set filetype=markdown

" start with spec file template
au BufNewFile *.cpp                        0r ~/.vim/templates/cpp
au BufNewFile *.h                          0r ~/.vim/templates/h
au BufNewFile *.java                       0r ~/.vim/templates/java
au BufNewFile *.spec                       0r /usr/share/vim/vimfiles/template.spec
au BufNewFile *.tex                        0r ~/.vim/templates/tex

" Random bits
au BufRead *vimrc                          set foldmethod=marker
au BufRead *vimrc                          set foldlevel=1
" }}}2

" ==== Open the URL under the cursor ==== {{{2
function! HandleURI()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    echo s:uri
    if s:uri != ""
        exec "!kde-open \"" . s:uri . "\""
    else
        echo "No URI found in line."
    endif
endfunction
map <Leader>w :call HandleURI()<CR>
" }}}2

" ==== Enable code folding ==== {{{2
set foldmethod=syntax " fold based on indent
set foldnestmax=5     " deepest fold is 10 levels
set foldlevel=2       " this is just what i use
" }}}2

" ==== Align Magick ==== {{{2
call Align#AlignCtrl( "Wlp0P0" )
vmap <Leader>] :Align 
" TODO: Make this smarter with AlignCtrl
" }}}2

" ==== Wrappy Stuff for Visual Mode ==== {{{2
vmap ' S'
vmap " S"
vmap ( S)
vmap ) S(
vmap { S{
vmap } S}
vmap [ S]
vmap ] S[
" }}}2

" ==== Abbreviations ==== {{{2
ab soap save_and_open_page
" }}}2

" ==== Random Magick ==== {{{2
" escape on kj
imap kj <C-[>

" <leader>e creates an edit command with your current file filled in
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" <leader>gf opens the file under the cursor, if it doesn't exist
map <leader>gf :e <cfile><cr>

" Write as root
command! W w !sudo tee % >/dev/null

" Random leader maps
" Find using fugitive 
map <Leader>f :Ggrep 
" Sort using Vissort
vmap <Leader>s :Vissort<CR>

" mark 'misplaced' tab characters
set listchars=tab:·\ ,trail:·
set list

" visual shifting (builtin-repeat)
vnoremap < <gv
vnoremap > >gv
"}}}2

" ====  Gist configurations ==== {{{2
let g:github_user                  = "rrix"
let g:github_token                 = "b76cb7f7cdd411c50da0dc1d813f6928"
let g:gist_open_browser_after_post = 1
let g:gist_browser_command         = "kde-open %URL%"
"}}}2
" }}}1
