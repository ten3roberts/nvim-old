let g:mapleader=" "

nnoremap gb :call ToggleBool()<CR>

" Make j and k move to the next row, not file line
nnoremap <silent> j gj
nnoremap <silent> k gk

" Jump to beginning and end of line in insert mode
inoremap <C-e> <Esc>A
inoremap <C-b> <Esc>I

" Select all text
nnoremap vA ggVG
" ===============================================================================
" Tabs

" Switch between tabs
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt

" Easily create a new tab.
noremap <Leader>N :tabnew<CR>" Easily close a tab.
noremap <Leader>Q :tabclose<CR>" Easily move a tab.

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

" Fix jump when using highlight current word
nnoremap * *``

" Show replace preview

command! Cd cd %:p:h

" ========================================
" Windows
" Remap window controls to leader+w
nnoremap <leader>ww <C-w>w
nnoremap <leader>wv <C-w>v<C-w>l
nnoremap <leader>ws <C-w>s<C-w>j
" Window Movement
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l

nnoremap <leader>wo <C-w>o

" Window swapping
nnoremap <leader>wH <C-w>H
nnoremap <leader>wJ <C-w>J
nnoremap <leader>wK <C-w>K
nnoremap <leader>wL <C-w>L
nnoremap <leader>wq <C-w>q

" Switch windows directionally with C-direction
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" inoremap <C-J> <Esc><C-W>j
" inoremap <C-K> <Esc><C-W>k
" inoremap <C-L> <Esc><C-W>l
" inoremap <C-H> <Esc><C-W>h

" Resizing
nnoremap <leader>w<  <C-w><
nnoremap <leader>w>  <C-w>>
nnoremap <leader>w+  <C-w>+
nnoremap <leader>w-  <C-w>-
nnoremap <leader>w=  <C-w>=
nnoremap <leader>w_  <C-w>_
nnoremap <leader>w\| <C-w>w\|

" Swap order in lists
nnoremap <A-h> :SidewaysLeft<cr>
nnoremap <A-l> :SidewaysRight<cr>

" =================================================================
" Barbar
" Magic buffer-picking mode
nnoremap <silent> <leader>bp :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <leader>bk :Kwbd<CR>
nnoremap <silent> <leader>bo :BufOnly<CR>
" Move to previous/next
nnoremap <silent> <A-,>      :bp<CR>
nnoremap <silent> <A-.>      :bn<CR>
" Goto buffer in position...
nnoremap <silent> <A-1>      :b 1<CR>
nnoremap <silent> <A-2>      :b 2<CR>
nnoremap <silent> <A-3>      :b 3<CR>
nnoremap <silent> <A-4>      :b 4<CR>
nnoremap <silent> <A-5>      :b 5<CR>
nnoremap <silent> <A-6>      :b 6<CR>
nnoremap <silent> <A-7>      :b 7<CR>
nnoremap <silent> <A-8>      :b 8<CR>
nnoremap <silent> <A-9>      :b 9<CR>

" ===============================================================================
"  Netrw

nnoremap <leader>pv :Vexplore <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Sexplore<CR>
nnoremap <leader>pe :Explore<CR>

" For us swedes
noremap å <C-^>

" Prevent x from touching the registers
noremap x "_x
noremap <leader>yc :let @*=@"<CR>


" ===============================================================================
" Terminal
" Open terminal with or without prefix with leader t
nnoremap <silent><leader>t :<C-u>exe v:count1 . "ToggleTerm"<CR>


" ===============================================================================
" Terminal Execs
nnoremap <leader>eb <cmd>lua require "term_exec".exec("build")<CR>
nnoremap <leader>er <cmd>lua require "term_exec".exec("run")<CR>
nnoremap <leader>et <cmd>lua require "term_exec".exec("test")<CR>

" ===============================================================================
" Vim Fugitive
nnoremap <silent><leader>gg  :tabedit %<CR>:Git<CR><C-W>o
nnoremap <silent><leader>ga. :Git add %<CR>
nnoremap         <leader>gK  :Git checkout -b<space>
" nnoremap         <leader>gf  :Gpull<CR>
nnoremap         <leader>gpp :Gpush<CR>
nnoremap         <leader>gpu :Git push -u origin <CR>
nnoremap         <leader>gf  :G pull<CR>
" Commit current file
nnoremap         <leader>gcf :Gcommit %<CR>
nnoremap <silent><leader>gd  :Gvdiffsplit<CR>


" ===============================================================================
" GitGutter and GitMessneger

nnoremap <silent><leader>gm     :GitMessenger<CR>

" GitGutter:
nnoremap <silent><leader>hs :GitGutterStageHunk<CR>
nnoremap <silent><leader>hv :GitGutterPreviewHunk<CR>
"Confirm with enter
nnoremap <leader>hx         :GitGutterUndoHunk
nnoremap <silent>[h         :GitGutterPrevHunk<CR>zvzz
nnoremap <silent>]h         :GitGutterNextHunk<CR>zvzz

" ===============================================================================
" fzf

noremap <leader><leader> :call FZFOpen(':Files')<CR>
noremap <leader>,        :call FZFOpen(':Buffers')<CR>
noremap <leader>rg       :call FZFOpen(':Rg')<CR>
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
nnoremap <silent> <leader>gw :call FZFOpen(':WorkspaceSymbols')<CR>

" ===============================================================================
" Neomake
nnoremap <silent> <leader>j :NeomakeNextLoclist<CR>
nnoremap <silent> <leader>k :NeomakePrevLoclist<CR>


" ===============================================================================
" Folds, scroll

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<CR>
nnoremap z1 :set foldlevel=1<CR>
nnoremap z2 :set foldlevel=2<CR>
nnoremap z3 :set foldlevel=3<CR>
nnoremap z- :set foldlevel-=1 <Bar> call Info('&foldlevel =', &foldlevel)<CR>
nnoremap z+ :set foldlevel+=1 <Bar> call Info('&foldlevel =', &foldlevel)<CR>
