function LightLineReadonly()
    if &readonly
        return ''
    else
        return ''
    endif
endfunction


function CountModifiedBuffer()
    let mod = map(getbufinfo(), 'v:val.changed')
    return len(filter(mod, 'v:val'))
endfunction

function GitInfo()
    let head = FugitiveHead()
    if head == ''
        return ''
    endif
    return ' ' . FugitiveHead()
endfunction

" [+] if only current modified, [+3] if 3 modified including current buffer.
" [3] if 3 modified and current not, "" if none modified.
function IsBuffersModified()
    let count = CountModifiedBuffer()
    return count == 0 ? '' : ( &modified ? '[+'. (count>1?count:'') .']' : '[' . count . ']' )
endfunction

function! StatuslineLocList()
    let counts = neomake#statusline#LoclistCounts(bufnr())
    let status = ""
    if has_key(counts,  'E')
        let status .= " E: " . counts.E
    endif
    if has_key(counts,  'W')
        let status .= " W: " . counts.W
    endif
    return status
endfunction

let g:lightline = {
            \ 'colorscheme': 'one',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste', 'readonly' ],
            \             [ 'gitbranch', 'relativepath', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'linter', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'alternatefile': 'AlternateFile',
            \   'gitbranch': 'GitInfo',
            \   'readonly': 'LightLineReadonly',
            \   'modified': 'IsBuffersModified',
            \   'fileinfo': 'FileInfo',
            \   'linter': 'StatuslineLocList'
            \ },
            \ 'mode_map': {
            \ 'n' : 'N',
            \ 'i' : 'I',
            \ 'R' : 'R',
            \ 'v' : 'V',
            \ 'V' : 'VL',
            \ "\<C-v>": 'VB',
            \ 'c' : 'C',
            \ 's' : 'S',
            \ 'S' : 'SL',
            \ "<\C-s>": 'SB',
            \ 't': 'T'
            \ }
            \}
