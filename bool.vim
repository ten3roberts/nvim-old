" https://vim.fandom.com/wiki/Toggling_yes-no
function ToggleBool()
    " Goto bool
    normal! b
    call search('\<\(true\|false\|on\|off\)\>', 'c', line('.') + 3)

    let w=expand("<cword>")
    if     w == "true"   | let w = "false"
    elseif w == "false"  | let w = "true"


    elseif w == "TRUE"   | let w = "FALSE"
    elseif w == "FALSE"  | let w = "TRUE"


    elseif w == "True"   | let w = "False"
    elseif w == "False"  | let w = "True"

    elseif w == "on"     | let w = "off"
    elseif w == "off"    | let w = "on"
    elseif w == "manual" | let w = "auto"
    elseif w == "auto"   | let w = "manual"
    else                 | let w = ""
    endif
    if w != ""
        exec "normal! \"_ciw\<C-R>=w\<CR>\<Esc>b"
    endif
endfunc
