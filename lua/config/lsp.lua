local LSPServers = {
    "tsserver",
    "tailwindcss",
    "intelephense",
    "gopls"
};


return function()
    local lspconfig = require "lspconfig"
    local cmpnvimlsp = require "cmp_nvim_lsp"

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmpnvimlsp.default_capabilities(capabilities)

    for _, lsp in ipairs(LSPServers) do
        lspconfig[lsp].setup({ capabilities = capabilities })
    end
end
