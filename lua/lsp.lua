local lspconfig = require "lspconfig"

local servers = {
    sumneko_lua = {},
    rust_analyzer = {},
    vimls = {},
    nimls = {},
    hls = {}
}

local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
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
    map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    map("n", "<leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    map("n", "<leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    map("n", "<leader>ah", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    -- map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map("n", "<leader>ar", "<cmd>lua vim.lsp.buf.rename()<CR>")
    -- map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map("n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    map("n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
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
