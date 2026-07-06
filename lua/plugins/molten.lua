return {
  {
    "benlubas/molten-nvim",
    lazy = true,
    version = "^1.0.0", -- pin to latest major version for stability
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20

      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenKernelReady",
        desc = "Automatically sync Jupyter kernel working directory with the active file",
        callback = function()
          -- Get the absolute directory of the currently active file
          local file_dir = vim.fn.expand("%:p:h")

          -- Escape single quotes in the path to prevent Python syntax errors
          file_dir = file_dir:gsub("'", "\\'")

          -- Silently force the Python kernel to change its working directory
          vim.cmd(
            string.format(
              "MoltenEvaluateArgument import os; os.chdir('%s')",
              file_dir
            )
          )
        end,
      })
    end,
    keys = {
      {
        -- Change this mapping to whatever you prefer to initialize Molten
        "<leader>li",
        function()
          local file_dir = vim.fn.expand("%:p:h")
          local project_root = vim.fn.getcwd()

          -- 1. Temporarily step into the file's directory
          vim.cmd("lcd " .. file_dir)

          -- 2. Initialize the kernel where the local files are
          vim.cmd("MoltenInit")

          -- 3. Instantly snap Neovim back to the project root
          vim.cmd("lcd " .. project_root)

          vim.notify(
            "Molten initialized contextually at file root.",
            vim.log.levels.INFO
          )
        end,
        desc = "Initialize Molten (Local Directory Aware)",
      },
    },
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
