let termFtToIgnore = ['fzf']
au TermEnter * if empty(&filetype) | tnoremap <buffer> <Esc> <c-\><c-n>

" Remove numbers in terminal
" au TermOpen * setlocal nonumber norelativenumber

" Set window title to current working directory
au DirChanged,VimEnter * call luaeval('require "project_conf".load()')
au Filetype,BufEnter * call luaeval('require "project_conf".load_for_ft()')

" Remember last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remove continuation of comments with o and O
au FileType * set formatoptions-=o
au FileType NvimTree setlocal signcolumn=no statusline=\%#Keyword#Explorer

" Associate .h files with C and not C++
au BufRead,BufNewFile *.h,*.c set filetype=c

" Fugitive tab expand and collapse
au FileType fugitive map <buffer> <Tab> =

" Auto set compiler for filetypes
au FileType rust :compiler cargo

" Auto format some filetypes
au BufWritePre *.rs silent! Neoformat
au Filetype rust let g:termdebugger='rust-gdb'

au FileType markdown set textwidth=60

" au CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Create directories to save file
au BufWritePre * silent! if (&buftype == "") | call mkdir(expand("<afile>:p:h"), "p") | endif

" au InsertLeave,BufWrite,BufEnter * :call LspLocationList() 
