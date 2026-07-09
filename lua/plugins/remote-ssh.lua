return {
  "ihersom/remote-ssh.nvim",
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig", -- Required to handle the proxied remote LSPs
  },
  keys = {
    { "<Leader>ss", ":RemoteSession", desc = "Start SSH" },
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
