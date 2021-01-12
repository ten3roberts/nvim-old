local lspconfig = require "lspconfig"

local servers = {
    sumneko_lua = {},
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
    vim.fn.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
end

local M = {}
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

local custom_attach = function(client)
    print("LSP started.")
    -- require'completion'.on_attach(client)
    -- require'diagnostic'.on_attach(client)

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
    -- map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    -- map("n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    -- map("n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
end

-- Use neomake for diagnostics
vim.lsp.callbacks["textDocument/publishDiagnostics"] = function()
end

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
