" Note: i_<C-L>
" This constructs a skeleton of a TeX environment.
" You write a line like this:
" floatingfigure:ht<C-L>
" and after you press <C-L>, you get:
" \begin[ht]{floatingfigure}
" \end{floatingfigure}
" -- INSERT --
"
" where floatingfigure is the desired environment
" ht are options
" : is delimiter; in fact, you can use whatever delimiter you want
" as long it is not in &iskeyword option.

inoremap <buffer> <C-L>
 \:s/[^][:alnum:]<Bar>]\+/,/eg
 \I\begin{ea}[A]%d%%P
 \:s/\[,/[/e
 \:s/,]/]/e
 \:s/\[]//e
 \0f{y%o\endpO

inoremap <buffer> { {}i
inoremap <buffer> [ []i
inoremap <buffer> ^ ^{}i
inoremap <buffer> _ _{}i
inoremap <buffer> \( \(\)hi
inoremap <buffer> \[ \[\]hi

" Note: v_<C-L>
" For this to work, you have to write on a blank line the name of
" the desired environment and options (see i_<C-L>) and visual select
" (from top to bottom) this and following lines.
" After pressing <C-L> the selected lines will be surrounded
" with begin/end skeleton of the environment.

vnoremap <buffer> <C-L> o
 \:s/[^][:alnum:]<Bar>]\+/,/eg
 \I\begin{ea}[A]%d%%P
 \:s/\[,/[/e
 \:s/,]/]/e
 \:s/\[]//e
 \0f{y%gvoo\endp

" vnoremap <buffer> { di{}P
" vnoremap <buffer> [ di[]P
vnoremap <buffer>  di^{}P
vnoremap <buffer>  di_{}P
vnoremap <buffer> \( di\(\)hP
vnoremap <buffer> \[ di\[\]hP


" This makes "two spaces after a comma" before every :write
au BufWritePre *.tex %s/,\(\S\)/, \1/ge

" If cursor is inside braces and not before comma, blank or opening brace,
" exit the brace block and stay in insert mode.
" If cursor is outside braces, it inserts a space or perform an abbreviation
" as normal.
function! CleverSpace()
  let CharOnCursor = strpart( getline('.'), col('.')-2, 1)
  let CharAfterCursor = strpart( getline('.'), col('.'), 1)
  if CharOnCursor !~ ',\|\s\|(' && CharAfterCursor =~ ')\|]\|}'
    normal x
  endif
endfunction
inoremap <Space> <Space>:call CleverSpace()<LF>a

