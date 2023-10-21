local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'tsserver', 'rust_analyzer'},
    handlers = {
        lsp_zero.default_setup,
        cssls = function ()
            lspconfig.cssls.setup({
                capabilities = capabilities,
                filetypes = { "css", "scss", "less", "html" }
            })
        end,
        emmet_ls = function()
            lspconfig.emmet_ls.setup({
                capabilities = capabilities,
                filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
                init_options = {
                    html = {
                        options = {
                            ["bem.enabled"] = true,
                        },
                    },
                },
            })
        end,
    },
})
