" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
set pumheight=6
set pumwidth=40

" Force open with C-tab
imap <silent> <C-Space> <Plug>(completion_trigger)

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" Stop enter from selecting in menu
let g:completion_confirm_key = ""

" autocmd BufEnter * 
imap <expr> <cr> pumvisible() ? complete_info()["selected"] != "-1" ?
      \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<Plug>(PearTreeExpand)" :  "\<Plug>(PearTreeExpand)"
" imap <expr> <CR> pumvisible() ? "\<C-y><CR>" : "<CR>"

let g:completion_enable_auto_popup = 1
let g:completion_trigger_keyword_length = 2
let g:completion_enable_auto_paren = 1
let g:completion_sorting = "length"

let g:completion_matching_strategy_list = ['exact', 'substring']

let g:completion_matching_smart_case = 1
let g:completion_auto_change_source = 0

let g:completion_chain_complete_list = {
      \ 'default': [
      \{'complete_items': [ 'lsp', 'path', 'buffer' ]}
      \]}

let g:completion_items_priority = {
      \ 'Field': 5,
      \ 'Function': 7,
      \ 'Variables': 7,
      \ 'Method': 10,
      \ 'Interfaces': 5,
      \ 'Constant': 5,
      \ 'Class': 5,
      \ 'Keyword': 4,
      \ 'UltiSnips' : 1,
      \ 'vim-vsnip' : 0,
      \ 'Buffers' : 1,
      \ 'TabNine' : 0,
      \ 'File' : 0,
      \}
