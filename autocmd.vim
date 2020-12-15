let termFtToIgnore = ['fzf']
au TermEnter * if index(termFtToIgnore, &ft) < 0 | tnoremap <buffer> <Esc> <c-\><c-n>
au TermOpen * setlocal nonumber norelativenumber

" Set window title to current working directory
autocmd DirChanged * call system('set_title "Neovim - `pwd | rev | cut -d/ -f -2 | rev`"')
" autocmd DirChanged,VimEnter * call luaeval('require "project_conf".load()')
autocmd VimLeave * call system("set_title " . g:original_window_title)

" Remember last position in file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup Filetypes
    autocmd!
    " Remove continuation of comments with o and O
    autocmd FileType * set formatoptions-=o

    " Darken certain filetypes
    autocmd FileType * call HighlightWindow()
    autocmd WinEnter * call HighlightWindow()

    " Json comments
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " Lua self
    autocmd FileType lua call timer_start(300, { tid -> execute('syntax keyword Type self') })

    autocmd FileType fugitive map <buffer> <Tab> =

    autocmd BufEnter,FileType * call luaeval('require "term_exec".set_ft()')

    autocmd FileType markdown,nim,rust set textwidth=80
augroup end

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'LuaTreeOpen' | endif

" augroup SaveSession
"     autocmd!
"     autocmd VimLeave * call SaveCurrentSession()
" augroup end

" Create directories to save file
augroup Mkdir
    autocmd!
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup end

augroup Format
    autocmd!
    " autocmd BufWritePost * Neoformat
augroup end
