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
  size = 12,
  open_mapping = [[<C-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  persist_size = false,
  direction = 'window', -- vertical' | 'horizontal' | 'window' | 'float',
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'curved', --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    width = nil,
    height = nil,
    winblend = 10,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
