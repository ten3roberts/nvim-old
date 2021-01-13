function! OnLines(mode)
    let exp = input("Normal: ")
    let start = line('v')
    if a:mode == 'v'
        let end = line("'>")
    else
        let end = l:start
    endif

    let prev_pat = @/
    if exp == ""
        return
    endif

    exe printf(":%d,%dg/\\S/norm %s", start, end, l:exp)
    let @/ = l:prev_pat
    execute("nohl")
endfunction()

nnoremap gl :call OnLines('n')<CR>
vnoremap gl :<c-u>call OnLines('v')<CR>
