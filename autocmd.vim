let termFtToIgnore = ['fzf']
au TermEnter * if index(termFtToIgnore, &ft) < 0 | tnoremap <buffer> <Esc> <c-\><c-n>
au TermOpen * setlocal nonumber norelativenumber

" Set window title to current working directory
autocmd DirChanged,VimEnter * call system('set_title Neovim\ `pwd | sed "s|$HOME|~|"`')
autocmd DirChanged * call LoadSession()
autocmd VimLeave * call system("set_title " . g:original_window_title)
autocmd VimLeave * call MakeSession()

" Remember last position in file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd VimEnter * let g:licenses_authors_name = system("git config user.name") |
      \let g:licenses_copyright_holders_name = g:licenses_authors_name

augroup Filetypes
  autocmd!
  " Remove continuation of comments with o and O
  autocmd FileType * set formatoptions-=o

  autocmd BufRead,BufNewFile *.h,*.c set filetype=c

  autocmd FileType fugitive map <buffer> <Tab> =

  autocmd BufEnter,FileType * call luaeval('require "term_exec".set_ft()')

  autocmd FileType c,markdown,nim,rust set textwidth=80

  autocmd BufWritePre *.rs silent! Neoformat

  autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
  " Enable type inlay hints
  " autocmd InsertLeave,BufEnter,BufWritePost *.rs
  "       \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }
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
  autocmd BufWritePre * silent! if (&buftype == "") | call mkdir(expand("<afile>:p:h"), "p") | endif
augroup end

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
