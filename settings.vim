set cmdheight=1
" Don't show --INSERT-- and alike
" set noshowmode
" Smart auto indentation
set autoindent smartindent

" Tabs
set tabstop=4
set shiftwidth=0 expandtab
" set mouse=a
set softtabstop=-1

set number
set numberwidth=2
set signcolumn=yes
set relativenumber

" Switch to window if buffer is already open in it
set switchbuf=useopen
set foldmethod=indent

set foldtext=MyFoldText()

set nofoldenable
set foldnestmax=7
set foldlevel=99
set scrolloff=5

set path+=**

" Show replace preview
set inccommand=split

set autoread
" Switch dirty buffers
set hidden

set equalalways

" Case Insensitivity Pattern Matching
set ignorecase " Overrides ignorecase if pattern contains upcase
set smartcase

set listchars=tab:⇥\  list
" Never breaking at end of words
set linebreak
let showbreak='++' 

let g:Hexokinase_highlighters = [
\   'virtual',
\   'foregroundfull'
\ ]

let g:Hexokinase_refreshEvents = ['BufRead', 'BufWrite', 'InsertLeave']

" Autopairs
" Smart pairs are disabled by default:
let g:pear_tree_repeatable_expand   = 0
let g:pear_tree_smart_openers       = 1
let g:pear_tree_smart_closers       = 1
let g:pear_tree_smart_backspace     = 1

" If enabled, smart pair functions timeout after 60ms:
let g:pear_tree_timeout = 180

" Don't automatically map <BS>, <CR>, and <Esc>
let g:pear_tree_map_special_keys = 0

" Default mappings:
imap <BS>  <Plug>(PearTreeBackspace)
" Set by completion.vim instead
" imap <CR>  <Plug>(PearTreeExpand)
imap <Esc> <Plug>(PearTreeFinishExpansion)

let g:rooter_patterns = [".git", "Makefile", "conf.lua", "*.nimble"]
let g:netrw_banner = 0


