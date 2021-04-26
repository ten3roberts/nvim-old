require "project_conf"
require "lsp"

-- Setup treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  indent = {
    enable = false
  }
}

-- Setup completion
require 'completion'
require"toggleterm".setup{
  size = 80,
  open_mapping = [[<C-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 0.5, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  persist_size = true,
  direction = 'window' -- vertical' | 'horizontal' | 'window' | 'float',
}
