local nvim_lsp = require('lspconfig')
--local servers = { 'emmet_ls', 'cssmodules_ls', 'intelepense' }
local servers = { 'emmet_ls', 'eslint', 'intelephense' }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach
  }
end
