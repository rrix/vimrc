if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible        " Use Vim defaults (much better!)
set ai                  " always set autoindenting on
set viminfo=!,'20,\"50  " read/write a .viminfo file, don't store more
                        " than 50 lines of registers, store globals
set history=50          " keep 50 lines of command line history
set dir=/var/tmp,/tmp,.

" Appearance related variables
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

" Formatting options
set et                  " Tabs become spaces
set sw=2                " Autoident uses 4 space tabs
set sts=2               " Tabs become 4 spaces while editing
set fo+=l               " Don't wrap long lines if they're long when you enter insert mode
set fo+=2               " Use second line for indent

" Search related variables
set is                  " Jump to result while searching
" set ic                  " Ignore case when searching
" set scs                 " Don't ignore case if you change case
set nohls               " Don't highlight search results

" Buffer commands

" In text files, always limit the width of text to 78 characters but disable
" it for known file types
au BufRead,BufNewFile *                 set tw=78
au BufRead,BufNewFile *.cpp,*.h,*rc     set tw=0

" Pathogen plugin manager
call pathogen#infect()

" Sources
" TODO: Filetype.vim plugin
au BufNewFile,BufRead *.cpp,*.h source ~/.vim/cpp.vimrc
au BufNewFile,BufRead *.java source ~/.vim/java.vimrc
au BufNewFile,BufRead *.pde source ~/.vim/plugin/arduino.vim
au BufNewFile,BufRead *.rb,*.haml,*.erb source ~/.vim/ruby.vim
au BufNewFile,BufRead *.tex source ~/.vim/tex.vimrc
au BufNewFile,BufRead /home/rrix/dev/trunk/* source ~/dev/trunk/kdesdk/scripts/kde-devel-vim.vim
au BufNewFile,BufRead *.js,*.json,*/*enyo* source ~/.vim/plugin/json.vim

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif

" start with spec file template
au BufNewFile *.cpp                        0r ~/.vim/templates/cpp
au BufNewFile *.h                          0r ~/.vim/templates/h
au BufNewFile *.java                       0r ~/.vim/templates/java
au BufNewFile *.spec                       0r /usr/share/vim/vimfiles/template.spec
au BufNewFile *.tex                        0r ~/.vim/templates/tex
au BufNewFile ~/dev/blag/_posts/*.markdown 0r ~/.vim/templates/blagpost

" Open the URL under the cursor
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

" Enable code folding
set foldmethod=syntax " fold based on indent
set foldnestmax=5     " deepest fold is 10 levels
set foldlevel=2       " this is just what i use

" NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set undodir=~/.vim/undodir
set undofile

map <Leader>f :Ggrep 
vmap <Leader>s :Vissort<CR>

" mark 'misplaced' tab characters
set listchars=tab:·\ ,trail:·
set list

" visual shifting (builtin-repeat)
vnoremap < <gv
vnoremap > >gv

" Jekyll
let g:jekyll_path = "/home/rrix/dev/blag/"
map <Leader>jb  :JekyllBuild<CR>
map <Leader>jn  :JekyllPost<CR>
map <Leader>jl  :JekyllList<CR>

" set background=dark
" colorscheme solarized
