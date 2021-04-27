" Fuzzy finding
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Prevents files from opening in tree split
function! FZFOpen(command_str)
    if (&filetype =~# 'NvimTree' && winnr('$') > 1)
        exe "normal! \<C-w>\<C-l>"
    endif
    exe 'normal! ' . a:command_str . "\<CR>"
endfunction


" [Buffers] Jump to the existing window if possible
" let g:fzf_buffers_jump = 1

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6 } }

" let $FZF_DEFAULT_COMMAND="rg --files"

" Favor files closer to current file
function! s:list_cmd()
  if (!empty(&buftype))
    return 'fd -t f'
  endif

  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd -t f' : printf('fd -t f | proximity-sort %s', expand('%'))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

command! -bang -nargs=? -complete=dir Buffers
  \ call fzf#vim#buffers(<q-args>, {}, <bang>0)

command! -bang -nargs=? -complete=dir Rg
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, s:try_preview({}), <bang>0)

command! Symbols call fzf#run(fzf#wrap({
    \ 'source': luaeval('require "lsp".get_document_symbols()'),
    \ 'sink': function('<sid>load_document_symbol'),
    \ }))

command! WorkspaceSymbols call fzf#vim#files(<q-args>, s:try_preview({
    \ 'source': luaeval('require "lsp".get_workspace_symbols()'),
    \ 'sink': function('<sid>load_workspace_symbol'),
    \ }))

command! LoadSession call fzf#run(fzf#wrap({
    \ 'source': 'ls ~/.local/share/nvim/session/',
    \ 'sink': function('<sid>load_session')
    \ }))

function s:load_session(name)
    execute(':SLoad') a:name
endfunction

function s:try_preview(opts)
    if &columns > 120
        return fzf#vim#with_preview(a:opts)
    else
        return a:opts
    endif
endfunction

function s:load_document_symbol(symbol)
    :exe split(a:symbol, "    ")[0]
endfunction

function s:load_workspace_symbol(symbol)
    let parts = split(a:symbol, ":")
    let file = l:parts[0]
    let line = split(l:parts[1], " ")[0]
    echom "file: " . l:file . " line: " . l:line
    execute('e') l:file
    execute(':') l:line
endfunction
