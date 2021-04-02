local lspconfig = require "lspconfig"

local sumneko_root_path = vim.fn.expand("$HOME/.local/bin/lua-language-server")
local sumneko_binary = sumneko_root_path  .. "/bin/Linux/lua-language-server"

local servers = {
  sumneko_lua = {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'Lua',
          -- Setup your lua path
          path = "/usr/bin/lua"
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    },},
    rust_analyzer = {},
    clangd = {},
    vimls = {},
    nimls = {},
    hls = {}
  }

  local function filter_symbol(symbol)
    local kind = symbol.kind
    if kind == "TypeParameter" then return false end

    return true
  end

  local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
  end

  local M = { error_count = 0, warning_count = 0, info_count = 0, hint_count = 0 }
  function M.get_document_symbols()
    local opts = {}

    local params = vim.lsp.util.make_position_params()
    local results_lsp = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, opts.timeout or 1000)

    if not results_lsp or vim.tbl_isempty(results_lsp) then
      print("No results from textDocument/documentSymbol")
      return
    end

    local items = {}
    for _, server_results in pairs(results_lsp) do
      vim.list_extend(items, vim.lsp.util.symbols_to_items(server_results.result, 0) or {})
    end

    if vim.tbl_isempty(items) then
      return
    end

    local lines = {}
    for _, item in pairs(items) do
      if filter_symbol(item) then
        lines[#lines + 1] = string.format("%d    %s", item.lnum, item.text)
      end
    end
    return lines
  end

  local protocol = require('vim.lsp.protocol')
  local util = require('vim.lsp.util')

  --@class DiagnosticSeverity
  local DiagnosticSeverity = protocol.DiagnosticSeverity

  local function to_severity(severity)
    if not severity then return nil end
    return type(severity) == 'string' and DiagnosticSeverity[severity] or severity
  end

  local function filter_to_severity_limit(severity, diagnostics)
    local filter_level = to_severity(severity)
    if not filter_level then
      return diagnostics
    end

    return vim.tbl_filter(function(t) return t.severity == filter_level end, diagnostics)
  end


  local function diagnostic_count (severity, diagnostics)
    local count = 0
    local filter_level = to_severity(severity)
    for _,v in ipairs(diagnostics) do
      if v.severity == filter_level then
        count = count + 1
      end
    end
    return count
  end


  function M.get_workspace_symbols()
    local opts = {}

    local params = vim.lsp.util.make_position_params()
    local results_lsp = vim.lsp.buf_request_sync(0, "workspace/symbol", { query = '' }, opts.timeout or 1000)

    if not results_lsp or vim.tbl_isempty(results_lsp) then
      print("No results from workspace/symbol")
      return
    end

    local items = {}
    for _, server_results in pairs(results_lsp) do
      vim.list_extend(items, vim.lsp.util.symbols_to_items(server_results.result, 0) or {})
    end

    if vim.tbl_isempty(items) then
      return
    end

    local lines = {}
    for _, item in pairs(items) do
      if filter_symbol(item) then
        lines[#lines + 1] = string.format("%s:%d %s", vim.fn.fnamemodify(item.filename, ":."), item.lnum, item.text)
      end
    end
    return lines
  end

  function M.statusline()
    -- Diagnostics are not for this buffer
    if M.current_buf ~= vim.api.nvim_get_current_buf() then
      return ""
    end

    if M.info_count > 0 or M.hint_count > 0 then
      return string.format("E: %-2d W: %-2d I: %-2d H: %-2d", M.error_count, M.warning_count, M.info_count, M.hint_count)
    elseif M.error_count > 0 or M.warning_count > 0 then
      return string.format("E: %-2d W: %-2d", M.error_count, M.warning_count)
    else 
      return ""
    end
  end

  local custom_attach = function(client)
    print("LSP started")
    require'lsp_signature'.on_attach()

    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    map("n", "<leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    map("n", "<leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    -- map("n", "<leader>ah", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    -- map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    map("n", "<leader>k", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    map("n", "<leader>j", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    map("n", "<leader>l", "<cmd>lua vim.lsp.diagnostic.set_loclist({severity_limit = 'Warning'})<CR>")
    map('n','<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    -- map("n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    -- map("n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
  end


  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  function(err, method, result, client_id, bufnr, config)
    vim.lsp.diagnostic.on_publish_diagnostics(err, method, result, client_id, bufnr, config)
    -- vim.lsp.diagnostic.set_loclist({ open_loclist = false, severity_limit = 'Warning' })
    local buffer_diags = vim.lsp.diagnostic.get(bufnr, nil)

    -- Keep track of number of errors and warnings
    M.current_buf = vim.api.nvim_get_current_buf()
    M.error_count = diagnostic_count("Error", buffer_diags)
    M.warning_count = diagnostic_count("Warning", buffer_diags)
    M.info_count = diagnostic_count("Information", buffer_diags)
    M.hint_count = diagnostic_count("Hint", buffer_diags)

    -- Automatically populate location list
  end,
  {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 2
    virtual_text = {
      spacing = 4,
      prefix = '~',
    },

    signs = true,

    -- Disable a feature
    update_in_insert = false,
  }
  )

  local function setup_server(name, config)
    local full_cfg = vim.tbl_extend("force", {on_attach = custom_attach}, config)
    lspconfig[name].setup(full_cfg)
  end

  local function setup_servers(servers)
    for k, v in pairs(servers) do
      setup_server(k, v)
    end
  end

  setup_servers(servers)
  return M
