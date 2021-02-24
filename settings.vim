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
" set nowrap

" Switch to window if buffer is already open in it
set switchbuf=useopen
" set foldmethod=indent
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" set foldtext=MyFoldText()

set foldnestmax=5
set foldlevel=3
set scrolloff=5
set updatetime=500

set path+=**

" Show replace preview
set inccommand=split

set autoread
" Switch dirty buffers
set hidden

set listchars=tab:⇥\  list
" Never breaking at end of words
set linebreak
let showbreak='++' 

set splitright

let g:Hexokinase_highlighters = [
      \   'virtual',
      \   'foregroundfull'
      \ ]

let g:Hexokinase_refreshEvents = ['BufRead', 'BufWrite', 'InsertLeave']

" Autopairs
let g:AutoPairsMapCR=1

let g:netrw_banner = 0
let g:netrw_winsize = -28
let g:netrw_list_hide = '^./$,^../$'
" let g:netrw_liststyle=3

" Default rules for matching:
let g:pear_tree_pairs = {
      \ '(': {'closer': ')'},
      \ '[': {'closer': ']'},
      \ '{': {'closer': '}'},
      \ "'": {'closer': "'"},
      \ '"': {'closer': '"'},
      \ '<': {'closer': '>'},
      \ '/*': {'closer': '*/'}
      \ }
" Pair expansion is dot-repeatable by default:
let g:pear_tree_repeatable_expand = 0

" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 1

" If enabled, smart pair functions timeout after 60ms:
let g:pear_tree_timeout = 60

" Automatically map <BS>, <CR>, and <Esc>
let g:pear_tree_map_special_keys = 0
" Default mappings:
imap <BS> <Plug>(PearTreeBackspace)
" imap <CR> <Plug>(PearTreeExpand)
imap <Esc> <Plug>(PearTreeFinishExpansion)

" NOTE: This variable doesn't exist before barbar runs. Create it before
"       setting any option.
let bufferline = {}

" Enable/disable animations
let bufferline.animation = v:false

" Enable/disable auto-hiding the tab bar when there is a single buffer
let bufferline.auto_hide = v:true

" Enable/disable icons
" if set to 'numbers', will show buffer index in the tabline
" if set to 'both', will show buffer index and icons in the tabline
let bufferline.icons = v:true

" Configure icons on the bufferline.
" let bufferline.icon_separator_active = '▎'
" let bufferline.icon_separator_inactive = '▎'
" let bufferline.icon_close_tab = ''
" let bufferline.icon_close_tab_modified = '●'

" Enable/disable close button
let bufferline.closable = v:false

" Enables/disable clickable tabs
"  - left-click: go to buffer
"  - middle-click: delete buffer
let bufferline.clickable = v:false

" If set, the letters for each buffer in buffer-pick mode will be
" assigned based on their name. Otherwise or in case all letters are
" already assigned, the behavior is to assign letters in order of
" usability (see order below)
let bufferline.semantic_letters = v:true

" Sets the maximum padding width with which to surround each tab
let bufferline.maximum_padding = 2


let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  :'*',
      \ 'Staged'    :'+',
      \ 'Untracked' :'.',
      \ 'Renamed'   :'➜',
      \ 'Unmerged'  :'=',
      \ 'Deleted'   :'✖',
      \ 'Dirty'     :'✗',
      \ 'Ignored'   :'x',
      \ 'Clean'     :'✔︎',
      \ 'Unknown'   :'?',
      \ }
" NERD tree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 0
let NERDTreeWinSize = 28

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['h'] = s:purple " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['c'] = s:darkBlue " sets the color of css files to blue

function! OnlyAndNerdtree()
  let currentWindowID = win_getid()

  windo if win_getid() != currentWindowID && &filetype != 'nerdtree' | close | endif
endfunction

command! Only call OnlyAndNerdtree()


let g:rooter_patterns = ['.git', '.hg', '.bzr', '.svn', 'project.lua']


sign define LspDiagnosticsSignError text=●  texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=- texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=. texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=. texthl=LspDiagnosticsSignHint linehl= numhl=
