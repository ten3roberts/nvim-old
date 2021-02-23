local toggleterm = require "toggleterm"

toggleterm.setup{
  size = 12,
  open_mapping = [[<C-t>]],
  shade_filetypes = {"none"},
  shade_terminals = true,
  direction = 'horizontal',
  start_in_insert = false,
}
