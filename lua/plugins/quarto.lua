return {
  "quarto-dev/quarto-nvim",
  ft = { "markdown", "quarto" },
  dependencies = {
    "jmbuhr/otter.nvim", -- LSP for embedded code chunks
    "nvim-treesitter/nvim-treesitter", -- you already have this via AstroNvim
    "neovim/nvim-lspconfig", -- you already have this via AstroNvim
    "hrsh7th/nvim-cmp", -- you already have this via AstroNvim
  },
  opts = {
    lspFeatures = {
      enabled = true,
      languages = { "python", "r" }, -- "julia", etc. if you use them
      chunks = "all",
      diagnostics = { enabled = true },
      completion = { enabled = true },
    },
    codeRunner = {
      enabled = true,
      default_method = "molten",
      ft_runners = { python = "molten" },
    },
  },
  config = function(_, opts)
    require("quarto").setup(opts)

    if vim.bo.filetype == "markdown" then require("quarto").activate() end

    -- handle all future markdown buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function() require("quarto").activate() end,
    })

    local runner = require("quarto.runner")
    vim.keymap.set(
      "n",
      "<localleader>rc",
      runner.run_cell,
      { desc = "Run cell" }
    )
    vim.keymap.set(
      "n",
      "<localleader>ra",
      runner.run_above,
      { desc = "Run cell and above" }
    )
    vim.keymap.set(
      "n",
      "<localleader>rA",
      runner.run_all,
      { desc = "Run all cells" }
    )
    vim.keymap.set(
      "n",
      "<localleader>rl",
      runner.run_line,
      { desc = "Run line" }
    )
  end,
}
