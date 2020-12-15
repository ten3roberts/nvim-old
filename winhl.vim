let s:darken_ft = ['netrw', 'fzf', 'toggleterm']

" Change highlight group of preview window when open
function! HighlightWindow()
    if &previewwindow || index(s:darken_ft, &ft) != -1
        set winhl=Normal:DarkenedPanel,EndOfBuffer:DarkenedPanel,SignColumn:DarkenedPanel
    else
        set winhl=Normal:Normal,EndOfBuffer:EndOfBuffer,SignColumn:SignColumn
    endif
endfunction
