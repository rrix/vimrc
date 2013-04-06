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
set visualbell          " Use a visual bell instead of \a since gvim sucks at \a
let g:mapleader=" "
let mapleader=" "
" set autochdir

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
set ruler                                                               "show the cursor position all the time
syntax on
set so=6                                                                "Number of liness to keep above and below the cursor
set pt=<F2>                                                             "Toggle paste mode on F2
let &guicursor = &guicursor . ",a:blinkon0"                             "Don't wake up system with blinking cursor:
set lbr                                                                 "break on words rather than lines when wrapping in editor
set ls=2                                                                "Always draw a status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %{getcwd()}\ \ \ Line:\ %l/%L:%c "Sexy Status Line
set number                                                              "Show line numberse
set numberwidth=3                                                       "Three digit line numbers

set cursorcolumn                                                        "highlight column cursor is in
set cursorline                                                          "highlight line cursor is in

" Solarized {{{3
let g:solarized_termtrans=1
let g:solarized_menu=1
let g:solarized_contrast='high'
let g:solarized_visibility='high'
set background=light
colorscheme solarized
" }}}3

" Gvim {{{3
set guifont=OxygenMono
set guioptions-=T
" }}}3
" }}}2

" ==== Formatting options ==== {{{2
set et    " Tabs become spaces
set sw=2  " Autoident uses 4 space tabs
set sts=2 " Tabs become 4 spaces while editing
set ts=2  " Tabs are two if they're in the file
set fo+=l " Don't wrap long lines if they're long when you enter insert mode
set fo+=2 " Use second line for indent
set tw=78 " Wrap at 78 characters
" }}}2

" ==== Search related variables==== {{{2
set is                  " Jump to result while searching
set ic                  " Ignore case when searching
set scs                 " Don't ignore case if you change case
set nohls               " Don't highlight search results
" }}}2

" ==== Filetype Sources ==== {{{2
filetype plugin on
au! BufNewFile,BufRead *.rb,*.haml,*.erb            source ~/.vim/ftplugin/ruby.vim
au! BufNewFile,BufRead /home/rrix/Documents/blag    source ~/.vim/plugin/blag.vim
au! BufNewFile,BufRead /home/rrix/Documents/hslblag source ~/.vim/plugin/hslblag.vim

au! BufNewFile,BufRead *.pde                        set filetype=arduino
" au! BufNewFile,BufRead *.js,*.json                  set filetype=json
" au! BufNewFile,BufRead *.md                         set filetype=markdown
au! BufNewFile,BufRead *.escad,*.scad               set filetype=openscad

au! FileType ruby,eruby                             set omnifunc=rubycomplete#Complete
au! FileType ruby,eruby                             let g:rubycomplete_buffer_loading = 1
au! FileType ruby,eruby                             let g:rubycomplete_rails = 1
au! FileType ruby,eruby                             let g:rubycomplete_classes_in_global = 1

" Random bits
source /home/rrix/dev/3rd-party/kde-devel-scripts/kde-devel-vim.vim
source ~/.vim/plugin/org.kde.activities.vim
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
call Align#AlignCtrl( "Wlp1P0" )
vmap a :Align 
" TODO: Make this smarter with AlignCtrl
" }}}2

" ==== Abbreviations ==== {{{2
iab soap save_and_open_page
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
" set listchars=tab:·\ ,trail:·
set listchars=tab:\·\ ,trail:·
set list

" Convert ruby 1.8-style hashrockets in to 1.9 style
nmap <Leader>h :s/\:\([a-zA-Z_]*\)\s=>/\1\:/g<cr>
vmap <Leader>q :Align \s:\l*

" Jetpack http://bairuidahu.deviantart.com/art/Flying-vs-Cycling-261641977
nnoremap <Leader>l :ls<CR>:b<space>

" vim-notes Directory
let g:notes_directory = '~/Dropbox/TapNote'
let g:notes_suffix = '.txt'

" Vimwiki directory
let g:vimwiki_list = [{'path': '~/Dropbox/TapNote/'}]
"}}}2
" }}}1
