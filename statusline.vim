set laststatus=2

function StatuslineReadOnly()
    if &readonly
        return ''
    else
        return ''
    endif
endfunction

function! StatuslineGit()
  let l:branchname = FugitiveHead()
  return l:branchname
endfunction

function StatuslineNeomake()
    let counts = neomake#statusline#LoclistCounts(bufnr())
    let status = ""
    if has_key(counts,  'E')
        let status .= " E: " . counts.E
    endif
    if has_key(counts,  'W')
        let status .= " W: " . counts.W
    endif
    return strlen(status) > 0 ? status . ' | ' : ''
endfunction


function CountModifiedBuffer()
    let mod = map(getbufinfo(), 'v:val.changed')
    return len(filter(mod, 'v:val'))
endfunction

" [+] if only current modified, [+3] if 3 modified including current buffer.
" [3] if 3 modified and current not, "" if none modified.
function StatuslineModified()
    let count = CountModifiedBuffer()
    return count == 0 ? '' : ( &modified ? '[*'. (count>1?count:'') .']' : '[' . count . ']' )
endfunction

function! HiliteSwap(group, name)
    let id = synIDtrans(hlID(a:group))
    let fg = synIDattr(id, "fg#")
    let bg = synIDattr(synIDtrans(hlID("Normal")), "bg#")

    if &termguicolors == 1
        exe printf("hi %s guifg=%s guibg=%s", a:name, l:bg, l:fg)
    else
        exe printf("hi %s ctermfg=%s ctermbg=%s", a:name, l:bg, l:fg)
    endif

endfunction

call HiliteSwap("String", "StringRev")
call HiliteSwap("Keyword", "KeywordRev")
call HiliteSwap("Include", "IncludeRev")

set statusline=
set statusline+=%#StringRev#
set statusline+=\ %{StatuslineGit()}
set statusline+=\ %#PMenuSel#
set statusline+=\ %f
set statusline+=\ %#DarkenedPanel#
set statusline+=%{StatuslineModified()}
set statusline+=%=
set statusline+=%{StatuslineNeomake()}
set statusline+=%{&filetype}
set statusline+=\ %#PMenuSel#
set statusline+=\ %p%%
set statusline+=\ %#IncludeRev#
set statusline+=\ %l:%c\ 
