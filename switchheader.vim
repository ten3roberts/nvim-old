function! SwitchHeader()
    if expand("%:e") == "c"
        exe "e" fnameescape(expand("%:p:r:s?src?include?").".h")
    elseif expand("%:e") == "h"
        exe "e" fnameescape(expand("%:p:r:s?include?src?").".c")
    endif
endfunction

function s:openifexists(path)
    if filereadable(a:path)
        exe "e" . a:path
    else
        echom "File '" . a:path . "' does not exist"
    endif
endfunction

nmap gh :call SwitchHeader()<CR>
