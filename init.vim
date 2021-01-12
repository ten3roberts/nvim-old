call plug#begin('~/.vim/plugged')

" Plug 'airblade/vim-rooter' " Cd into root directory of project
" Plug 'psliwka/vim-smoothie' " Smooth C-U and C-D
" Plug 'tmsvg/pear-tree'
" Plug '~/dev/nim/nim.vim'
Plug 'AndrewRadev/sideways.vim' " Move function arguments
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'airblade/vim-gitgutter' " Show git info in gutter
Plug 'akinsho/nvim-toggleterm.lua' " Toggleable terminals
Plug 'cespare/vim-toml' " Toml support
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown preview in browser
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy searching and finding
Plug 'junegunn/fzf.vim' " Fuzzy finding vim commands
Plug 'junegunn/rainbow_parentheses.vim' " Rainbow parenthesis
Plug 'junegunn/vim-easy-align' " Align text
Plug 'justinmk/vim-sneak' " Like t and f but accepts two characters
Plug 'michaeljsmith/vim-indent-object' "Adds selection by indent
Plug 'neomake/neomake'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rhysd/git-messenger.vim' " Blame current line
Plug 'roryokane/detectindent' " Indent detection
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Colorize color codes (required Go)
Plug 'sbdchd/neoformat' " File formatting
Plug 'schickling/vim-bufonly' " Close all but current buffer
Plug 'ten3roberts/nim.vim'
Plug 'tikhomirov/vim-glsl' " glsl file support
Plug 'tpope/vim-abolish' " Smart text replacement and case coercion
Plug 'tpope/vim-commentary' " Toggle comments
Plug 'tpope/vim-eunuch' " Unix commands like renaming and moving current file
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tpope/vim-surround' " Surround with delimiters
Plug 'vim-scripts/headerguard'
Plug 'wellle/targets.vim' " Improves text targets like delimiters and ,

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'romgrk/doom-one.vim'

call plug#end()
let $PAGER=''
let s:rcpath = expand('<sfile>:p:h')
let g:vimrc = expand('<sfile>:p')

" Source file
function! s:load(file)
    let file = s:rcpath . '/' . a:file
    execute (l:file =~# '.lua$' ? 'luafile' : 'source') fnameescape(l:file)
endfunction

if (has("termguicolors"))
    set termguicolors
endif

let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
packadd termdebug

call s:load('keymap.vim')
call s:load('autocmd.vim')
call s:load('statusline.vim')
call s:load('fzf.vim')
call s:load('settings.vim')
call s:load('winhl.vim')
call s:load('kwbd.vim')
call s:load('neomake.vim')
call s:load('completion.vim')
call s:load('bool.vim')
call s:load('onlines.vim')
call s:load('switchheader.vim')

lua require "init"

function! AlternateFile()
    return expand('#')
endfunction

" Echoes all arguments
function! Info(...)
    echo join(a:000, ' ')
endfunction

" Show syntax highlighting groups for word under cursor
nmap <leader>z :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

command! Indent normal! mggg=G`g

let g:original_window_title = system("xtitle")
call system("set_title Neovim")
