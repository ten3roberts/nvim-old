
let g:neomake_error_sign = {
            \ 'text': 'E',
            \ 'texthl': 'NeomakeErrorSign',
            \ }
let g:neomake_warning_sign = {
            \   'text': 'W',
            \   'texthl': 'NeomakeWarningSign',
            \ }
let g:neomake_message_sign = {
            \   'text': 'M',
            \   'texthl': 'NeomakeMessageSign',
            \ }
let g:neomake_info_sign = {
            \ 'text': 'I',
            \ 'texthl': 'NeomakeInfoSign'
            \ }
let g:neomake_virtualtext_current_error=1
let g:neomake_virtualtext_prefix = '> '

let g:neomake_c_enabled_makers = ['clangtidy', 'clangcheck']

" let g:neomake_open_list = 1

" let g:neomake_cpp_enabled_makers = g:neomake_c_enabled_makers 

function! MyOnBattery()
    if has('macunix')
        return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
    elseif has('unix') && filereadable('/sys/calss/power_supply/AC/online')

        return readfile('/sys/class/power_supply/AC/online') == ['0']
    endif
    return 0
endfunction

if MyOnBattery()
    call neomake#configure#automake('w')
else
    call neomake#configure#automake('rnw', 500)
endif
