call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/sideways.vim' " Move function arguments
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'airblade/vim-gitgutter' " Show git info in gutter
Plug 'airblade/vim-rooter'
Plug 'akinsho/nvim-toggleterm.lua' " Toggleable terminals
Plug 'cespare/vim-toml' " Toml support
Plug 'drmikehenry/vim-headerguard' "Add header guards to C files
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown preview in browser
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy searching and finding
Plug 'junegunn/fzf.vim' " Fuzzy finding vim commands
Plug 'junegunn/vim-easy-align' " Align text
Plug 'justinmk/vim-sneak' " Like t and f but accepts two characters
Plug 'michaeljsmith/vim-indent-object' " Adds selection by indent
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'rhysd/git-messenger.vim' " Blame current line
Plug 'roryokane/detectindent' " Indent detection
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Colorize color codes (required Go)
Plug 'sbdchd/neoformat' " File formatting
Plug 'schickling/vim-bufonly' " Close all but current buffer
Plug 'ten3roberts/nim.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tikhomirov/vim-glsl' " glsl file support
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-abolish' " Smart text replacement and case coercion
Plug 'tpope/vim-commentary' " Toggle comments
Plug 'tpope/vim-eunuch' " Unix commands like renaming and moving current file
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tpope/vim-surround' " Surround with delimiters
Plug 'wellle/targets.vim' " Improves text targets like delimiters and ,

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'chriskempson/base16-vim'
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

" let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_contrast_dark="hard"
if empty($VIM_COLORSCHEME)
  let $VIM_COLORSCHEME="one"
endif

" let g:gruvbox_vert_split="bg1"
colorscheme $VIM_COLORSCHEME
packadd termdebug

call s:load('keymap.vim')
call s:load('autocmd.vim')
call s:load('statusline.vim')
call s:load('fzf.vim')
call s:load('settings.vim')
call s:load('winhl.vim')
call s:load('kwbd.vim')
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

function! MakeSession()
  let b:sessiondir = $HOME . "/.local/share/nvim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

command! Indent normal! mggg=G`g

let g:original_window_title = system("xdotool getactivewindow getwindowname")
call system("set_title Neovim")
