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

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" Stop enter from selecting in menu
let g:completion_confirm_key = ""

imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<Plug>(PearTreeExpand)" :  "\<Plug>(PearTreeExpand)"

let g:completion_enable_auto_popup = 1
let g:completion_enable_auto_paren = 1
let g:completion_sorting = "none"

let g:completion_matching_strategy_list = ['exact']

let g:completion_matching_smart_case = 1

let g:completion_timer_cycle = 200

let g:completion_chain_complete_list = {
            \ 'default': [
            \{'complete_items': ['lsp', 'path', 'buffer']},
            \{'mode': '<c-p>'},
            \{'mode': '<c-n>'}
            \]}
