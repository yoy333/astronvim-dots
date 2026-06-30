return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- pin to latest major version for stability
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- requires Kitty or Ghostty terminal
      integrations = {},
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
    },
  },
}
