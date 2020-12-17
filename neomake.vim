
let g:neomake_error_sign = {
            \ 'text': '•',
            \ 'texthl': 'NeomakeErrorSign',
            \ }
let g:neomake_warning_sign = {
            \   'text': '.',
            \   'texthl': 'NeomakeWarningSign',
            \ }
let g:neomake_message_sign = {
            \   'text': '_',
            \   'texthl': 'NeomakeMessageSign',
            \ }
let g:neomake_info_sign = {
            \ 'text': '_',
            \ 'texthl': 'NeomakeInfoSign'
            \ }
let g:neomake_virtualtext_prefix = '> '
function! MyOnBattery()
    if has('macunix')
        return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
    elseif has('unix') && filereadable('/sys/calss/power_supply/AC/online')

        return readfile('/sys/class/power_supply/AC/online') == ['0']
    endif
    return 0
endfunction

if MyOnBattery()
    echom "On  battery"
    call neomake#configure#automake('w')
else
    echom "Not on battery"
    call neomake#configure#automake('rnw', 1000)
endif
