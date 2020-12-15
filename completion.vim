inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

imap <c-space> <Plug>(asyncomplete_force_refresh)

" allow modifying the completeopt variable, or it will
" be overridden all the time
let g:asyncomplete_auto_completeopt = 1

set completeopt=menuone,noinsert,noselect,preview
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

set pumheight=10

" Buffer
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'b',
    \ 'allowlist': ['*'],
    \ 'priority': 0,
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

let g:asyncomplete_buffer_clear_cache = 1

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'f',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'nim',
    \ 'whitelist': ['nim'],
    \ 'priority': 20,
    \ 'completor': {opt, ctx -> nim#suggest#sug#GetAllCandidates({start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates)})}
    \ })
