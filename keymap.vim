let g:mapleader=" "

nnoremap gb :call ToggleBool()<CR>

" Make j and k move to the next row, not file line
noremap <silent> j gj
noremap <silent> k gk

" Use paragraph movement instead of page movement
" Hard to reach {} on sv keyboard
" noremap <silent> <C-u> {
" noremap <silent> <C-d> }

" Jump to beginning and end of line in insert mode
inoremap <C-e> <C-o>$
noremap <C-e> $

inoremap <C-b> <C-o>^
noremap <C-b> 0

" Window only but keep tree
" nmap <C-w>o :wincmd o \| :NvimTreeOpen<CR>

" Select all text
nnoremap vA ggVG

" " Replace f and t with multiline variant
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T

" ===============================================================================
" Tabs

" Switch between tabs
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Easily create a new tab.
noremap <leader>N :tabnew<CR> " Easily close a tab.
noremap <leader>Q :tabclose<CR> " Easily move a tab.

" Move line up and down
nnoremap <A-j> :m      .+1<CR>
nnoremap <A-k> :m      .-2<CR>
inoremap <A-j> <Esc>:m .+1<CR>gi
inoremap <A-k> <Esc>:m .-2<CR>gi

" Alt + Arrows in visual mode
vnoremap <A-j> :m '>+1<CR>gv
vnoremap <A-k> :m '<-2<CR>gv

" Clear last used search pattern
nnoremap <silent><Esc> :noh<return><Esc>

command! Cd cd %:p:h


" ========================================
" Quickfix list
nnoremap <leader>co :copen<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" ========================================
" Location list
nnoremap <leader>l :lopen<CR>
nnoremap <leader>j :lnext<CR>
nnoremap <leader>k :lprev<CR>

" Swap order in lists and arguments
nnoremap <A-h> :SidewaysLeft<cr>
nnoremap <A-l> :SidewaysRight<cr>

" =================================================================
" Buffers
" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
nnoremap <silent>    <leader>bk :BufferClose<CR>
nnoremap <silent>    <leader>bo :BufferCloseAllButCurrent<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode

" =================================================================
" Tree explorer
nnoremap <leader>f :NvimTreeFindFile<CR>
nnoremap <leader>pe :NvimTreeToggle<CR>

" Fix gx
" nnoremap gx :call system("xdg-open " . expand("<cWORD>"))
" For us swedes
noremap å <C-^>


" Better gx
nnoremap gx :call HandleURL()<cr>
" Why wouldn't gf use column if available
nnoremap gf gF
nnoremap gF gf


" Prevent x from touching the registers
noremap x "_x
" Copy top of reg to clipboard
noremap <leader>yc :let @+=@"<CR>

" ===============================================================================
" Terminal
" Open terminal with or without prefix with leader t
nnoremap <silent><leader>t :BufTermToggle<CR>
nnoremap <silent><C-t> :BufTermToggle<CR>
tnoremap <silent><C-\><C-t> <C-\><C-n>:BufTermToggle<CR>
nnoremap <silent><C-\><C-t> :BufTermToggle<CR>
" ==============================================================================
" Terminal Execs
nnoremap <leader>eb <cmd>lua require "project_conf".exec_command("build")<CR>
nnoremap <leader>er <cmd>lua require "project_conf".exec_command("run")<CR>
nnoremap <leader>et <cmd>lua require "project_conf".exec_command("test")<CR>

command! ProjectConf lua require "project_conf".overview()<CR>

" ===============================================================================
" Fugitive
nnoremap <silent><leader>gg  :Ge :<CR>
nnoremap <silent><leader>ga. :Git add %<CR>
nnoremap         <leader>gK  :Git checkout -b<space>
" nnoremap         <leader>gf  :Gpull<CR>
nnoremap         <leader>gpp :G push<CR>
nnoremap         <leader>gpu :Git push -u origin <CR>
nnoremap         <leader>gf  :G pull<CR>
" Commit current file
nnoremap         <leader>gcf :Gcommit %<CR>
nnoremap <silent><leader>gd  :Gvdiffsplit<CR>


" ===============================================================================
" GitGutter and GitMessneger
nnoremap <silent><leader>gm :GitMessenger<CR>

" GitGutter:
nnoremap <silent><leader>hs :GitGutterStageHunk<CR>
nnoremap <silent><leader>hv :GitGutterPreviewHunk<CR>
nnoremap <leader>hx         :GitGutterUndoHunk<CR>
nnoremap <silent>[h         :GitGutterPrevHunk<CR>
nnoremap <silent>]h         :GitGutterNextHunk<CR>

nnoremap <leader>hp         :GitGutterPrevHunk<CR>
nnoremap <leader>hn         :GitGutterNextHunk<CR>

" ===============================================================================
" FZF
noremap <leader><leader> :call FZFOpen(':Files')<CR>
noremap <leader>,        :call FZFOpen(':Buffers')<CR>
noremap <C-p>            :call FZFOpen(':Buffers')<CR>
noremap <leader>rg       :call FZFOpen(':Rg')<CR>
" noremap <C-k><C-t>       :Colors<CR>
noremap <leader>gl       :call FZFOpen(':Commits')<CR>
noremap <leader>/        :call FZFOpen(':BLines')<CR>
noremap <A-x>            <Esc>:call FZFOpen(':Commands')<CR>

" ===============================================================================
" Easy Align

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Surround line with { and }
nnoremap  g{   m`o}<esc><lt><lt>kkA<Space>{<esc>``

" ===============================================================================
" Code 
nnoremap <leader>ci :Indent<CR>
nnoremap <leader>cf :Neoformat<CR>

nnoremap <silent> <leader>o  :call FZFOpen(':Symbols')<CR>
nnoremap <silent> <leader>O :call FZFOpen(':WorkspaceSymbols')<CR>

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<CR>
nnoremap z1 :set foldlevel=1<CR>
nnoremap z2 :set foldlevel=2<CR>
nnoremap z3 :set foldlevel=3<CR>
nnoremap z- :set foldlevel-=1<CR>
nnoremap z= :set foldlevel+=1<CR>
