call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/sideways.vim' " Move function arguments
Plug 'airblade/vim-gitgutter' " Show git info in gutter
Plug 'airblade/vim-rooter' " Autocd to project root
Plug 'akinsho/nvim-toggleterm.lua' " Toggleable terminals
Plug 'dkarter/bullets.vim'
Plug 'drmikehenry/vim-headerguard' "Add header guards to C files
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown preview in browser
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy searching and finding
Plug 'junegunn/fzf.vim' " Fuzzy finding vim commands
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align' " Align text
Plug 'justinmk/vim-sneak' " Like t and f but accepts two characters
Plug 'kyazdani42/nvim-tree.lua' " Tree file explorer plugin
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mhinz/vim-startify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'qxxxb/vim-searchhi'
Plug 'rafamadriz/friendly-snippets'
Plug 'rhysd/git-messenger.vim' " Blame current line
Plug 'romainl/vim-qf'
Plug 'romgrk/barbar.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Colorize color codes (requires Go)
Plug 'sbdchd/neoformat' " File formatting
Plug 'ten3roberts/nim.vim'
Plug 'tikhomirov/vim-glsl' " glsl file support
Plug 'tmsvg/pear-tree' " Automatic closing of delimiters
Plug 'tpope/vim-abolish' " Smart text replacement and case coercion
Plug 'tpope/vim-commentary' " Toggle comments
Plug 'tpope/vim-eunuch' " Unix commands like renaming and moving current file
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround' " Surround with delimiters
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim' " Improves text targets like delimiters and ,

Plug 'hrsh7th/nvim-compe'
Plug 'simrat39/symbols-outline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'cocopon/iceberg.vim'
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
  let l:bufnr = bufnr()
  let ent = len(filter(getloclist("."), {i,v -> v.bufnr == l:bufnr && v.lnum <= curLine}))
  if ent < 1 || (exists("b:lastEntry") && b:lastEntry == ent)
    return
  endif

  let b:lastEntry = ent
  let pos = [ 0, curLine, col("."), 0 ]
  echo ""
  exe "ll ".ent
  call setpos(".", pos)
endfunc

function! LocPrev()
  let curLine = line(".")
  if exists("b:lastLinePrev") && b:lastLinePrev == curLine
    return
  endif

  if len(getloclist(".")) == 0
    return
  endif

  let b:lastLinePrev = line(".")
  let l:bufnr = bufnr()
  let ent = len(filter(getloclist("."), {i,v -> v.bufnr == l:bufnr && v.lnum < curLine}))

  " Wrap
  if ent < 1
    llast
    return
  endif

  echo ""
  exe "ll ".ent
endfunc

if (has("termguicolors"))
  set termguicolors
endif

" let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_contrast_dark="hard"
let g:palenight_terminal_italics=1
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

" Less obtrusive context
" hi! link TreeSitterContext Normal
