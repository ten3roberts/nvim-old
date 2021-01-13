set cmdheight=1
" Smart auto indentation
set autoindent smartindent

" Tabs
set tabstop=2
set shiftwidth=2 
set expandtab
" set mouse=a
set softtabstop=-1

" Better splits in debug mode
let g:termdebug_wide=1

" set number
set numberwidth=2
" set signcolumn=yes
" set relativenumber

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
set ignorecase
" Overrides ignorecase if pattern contains upcase
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
let g:AutoPairsMapCR=1

let g:netrw_banner = 0
let g:netrw_list_hide = '^./$,^../$'

