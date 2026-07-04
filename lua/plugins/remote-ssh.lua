return {
  "ihersom/remote-ssh.nvim",
  dependencies = {
    "neovim/nvim-lspconfig", -- Required to handle the proxied remote LSPs
  },
  config = function()
    -- Pull your existing local lsp capabilities / handlers if desired
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    require("remote-ssh").setup({
      capabilities = capabilities,
      -- Optional: Map custom file extensions to specific remote servers
      filetype_to_server = {
        -- python = "pylsp",
        -- cpp = "clangd",
      },
    })
  end,
}
