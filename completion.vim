" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
set pumheight=10

" Force open with C-tab
imap <silent> <C-Space> <Plug>(completion_trigger)

" Stop enter from selecting in menu
let g:completion_confirm_key = "\<C-y>"

let g:completion_sorting = "none"

let g:completion_matching_strategy_list = ['exact', 'substring' ]

let g:completion_matching_smart_case = 1

let g:completion_timer_cycle = 200

let g:completion_chain_complete_list = {
            \ 'default': [
            \{'complete_items': ['lsp', 'path', 'buffer']},
            \{'mode': '<c-p>'},
            \{'mode': '<c-n>'}
            \]}
