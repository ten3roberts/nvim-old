call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/sideways.vim' " Move function arguments
Plug 'airblade/vim-gitgutter' " Show git info in gutter
Plug 'airblade/vim-rooter' " Autocd to project root
Plug 'dkarter/bullets.vim'
Plug 'drmikehenry/vim-headerguard' "Add header guards to C files
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown preview in browser
Plug 'itmecho/bufterm.nvim' " Toggleable terminals
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy searching and finding
Plug 'junegunn/fzf.vim' " Fuzzy finding vim commands
Plug 'junegunn/goyo.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align' " Align text
Plug 'justinmk/vim-sneak' " Like t and f but accepts two characters
Plug 'kyazdani42/nvim-tree.lua' " Tree file explorer plugin
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object' " Adds selection by indent
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'qxxxb/vim-searchhi'
Plug 'rafamadriz/friendly-snippets'
Plug 'rhysd/git-messenger.vim' " Blame current line
Plug 'romainl/vim-qf'
Plug 'ray-x/lsp_signature.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'roryokane/detectindent' " Indent detection
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Colorize color codes (required Go)
Plug 'sbdchd/neoformat' " File formatting
Plug 'schickling/vim-bufonly' " Close all but current buffer
Plug 'ten3roberts/nim.vim'
Plug 'tikhomirov/vim-glsl' " glsl file support
Plug 'tmsvg/pear-tree' " Automatic closing of delimiters
Plug 'tpope/vim-abolish' " Smart text replacement and case coercion
Plug 'tpope/vim-commentary' " Toggle comments
Plug 'tpope/vim-eunuch' " Unix commands like renaming and moving current file
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tpope/vim-surround' " Surround with delimiters
Plug 'wellle/targets.vim' " Improves text targets like delimiters and ,

Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'sainnhe/sonokai'

call plug#end()
let $PAGER=''
let s:rcpath = expand('<sfile>:p:h')
let g:vimrc = expand('<sfile>:p')

" Source file
function! s:load(file)
  let file = s:rcpath . '/' . a:file
  execute (l:file =~# '.lua$' ? 'luafile' : 'source') fnameescape(l:file)
endfunction

function! LspLocationList()
  lua vim.lsp.diagnostic.set_loclist({ open_loclist = false, severity_limit = 'Warning' })
endfunction

function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!xdg-open '".s:uri."'"
  else
    echo "No URI found in line."
  endif
endfunction

function! LocVisible()
  return len(filter(getwininfo(), {i,v -> v.loclist}))
endfunc

function! LocLine()
  let curLine = line(".")
  if exists("b:lastLine") && b:lastLine == curLine
    return
  endif

  let b:lastLine = line(".")
  let ent = len(filter(getloclist("."), {i,v -> v.lnum <= curLine}))
  if ent < 1 || (exists("b:lastEntry") && b:lastEntry == ent)
    return
  endif

  let b:lastEntry = ent
  let pos = [ 0, curLine, col("."), 0 ]
  exe "ll ".ent
  call setpos(".", pos)
endfunc

function! LocPrev()
  let curLine = line(".")
  if exists("b:lastLine") && b:lastLine == curLine
    return
  endif

  let b:lastLine = line(".")
  let ent = len(filter(getloclist("."), {i,v -> v.lnum < curLine}))

  " Wrap
  if ent < 1
    llast
    return
  endif

  exe "ll ".ent
endfunc

if (has("termguicolors"))
  set termguicolors
endif

" let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_contrast_dark="hard"
if empty($VIM_COLORSCHEME)
  let $VIM_COLORSCHEME="nord"
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
" call s:load('completion.vim')
call s:load('bool.vim')
call s:load('onlines.vim')
call s:load('switchheader.vim')

lua require "init"

command! Indent normal! mggg=G`g
command! Quit :wa | qa

command! SucklessAlign normal gaip*{ gaip*, gaip*}
