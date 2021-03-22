set cmdheight=1
set number
set relativenumber
" Smart auto indentation
set autoindent smartindent


set ignorecase
set smartcase

" Tabs
set tabstop=2
set shiftwidth=2 
set softtabstop=2
set expandtab

" Auto set title
set title
set titlestring=nvim\ %F\ %M
set mouse=nv

" Better splits in debug mode
let g:termdebug_wide=1
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" set nowrap

" Switch to window if buffer is already open in it
set switchbuf=useopen
" set foldmethod=indent
set foldmethod=indent

" Fold, gets it's own section  ----------------------------------------------{{{
function! MyFoldText() " {{{
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
  " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines   ')
  let fillcharcount = windowwidth - len(line)
  " return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines'
  return line . ' ' . '...'. repeat(" ",fillcharcount)
endfunction " }}}
set foldtext=MyFoldText()

set foldnestmax=4
set foldlevel=2
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
set splitbelow

let g:Hexokinase_highlighters = [
      \   'virtual',
      \   'backgroundfull'
      \ ]

let g:Hexokinase_refreshEvents = ['BufRead', 'BufWrite', 'InsertLeave', "TextChanged"]

" Auto closing/matching rules
let g:pear_tree_pairs = {
      \ '(': {'closer': ')'},
      \ '[': {'closer': ']'},
      \ '{': {'closer': '}'},
      \ "'": {'closer': "'"},
      \ '"': {'closer': '"'},
      \ '/\*': {'closer': '\*/'}
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
let g:pear_tree_map_special_keys = 1
" Default mappings:
" imap <BS> <Plug>(PearTreeBackspace)
" imap <CR> <Plug>(PearTreeExpand)
" imap <Esc> <Plug>(PearTreeFinishExpansion)

let g:rooter_patterns = ['.git', '.hg', '.bzr', '.svn', 'project.lua']

" LSP signs
sign define LspDiagnosticsSignError text=●  texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=- texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=. texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=. texthl=LspDiagnosticsSignHint linehl= numhl=

" Lua tree
let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 29 "30 by default
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_auto_open = 0 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 0 "0 by default, closes the tree when it's the last window
let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 0 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 0 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file
let g:nvim_tree_disable_netrw = 1 "1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 1 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
let g:nvim_tree_show_icons = {
      \ 'git': 0,
      \ 'folders': 1,
      \ 'files': 0,
      \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
      \ 'default': '',
      \ 'symlink': '',
      \ 'git': {
      \   'unstaged': '*',
      \   'staged': '$',
      \   'unmerged': '=',
      \   'renamed': '➜',
      \   'untracked': '+'
      \   },
      \ 'folder': {
      \   'default': '▸',
      \   'open': '▾',
      \   'empty': '●',
      \   'empty_open': '●',
      \   'symlink': '▶',
      \   }
      \ }

" vim-sneak
let g:sneak#label = 1
let g:sneak#s_next = 1

" Startify
let g:startify_session_persistence = 1
let g:startify_custom_header = 'startify#center(startify#fortune#boxed())'
let g:startify_bookmarks = [ { 't': '~/tasks.md' }, { 'n': '~/.config/nvim/init.vim' } ]
let g:startify_files_number = 10
let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   Recent - '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]
" \ { 'type': 'files',     'header': ['   Recent']            },

" NOTE: If barbar's option dict isn't created yet, create it
let bufferline = get(g:, 'bufferline', {})

" Enable/disable animations
let bufferline.animation = v:true

" Enable/disable auto-hiding the tab bar when there is a single buffer
let bufferline.auto_hide = v:true

" Enable/disable close button
let bufferline.closable = v:false

" Enables/disable clickable tabs
"  - left-click: go to buffer
"  - middle-click: delete buffer
let bufferline.clickable = v:true

" Enable/disable icons
" if set to 'numbers', will show buffer index in the tabline
" if set to 'both', will show buffer index and icons in the tabline
let bufferline.icons = v:false

" Sets the maximum padding width with which to surround each tab
let bufferline.maximum_padding = 2
