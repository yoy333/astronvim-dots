---@type LazySpec
return {
  "GCBallesteros/jupytext.nvim",
  lazy = false,
  config = function()
    require("jupytext").setup({
      -- Do not put style="quarto" or output_extension="qmd" at the top level.
      -- Leave the global defaults untouched to prevent format mismatch crashes.
      style = "hydrogen",
      output_extension = "auto",
      force_ft = nil,

      -- Explicitly inject Quarto processing on a per-language basis
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        julia = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    })

    -- Track which companion files jupytext.nvim actually created this session,
    -- so we never touch a .qmd that already existed before we opened the notebook.
    local jupytext_created_files = {}

    vim.api.nvim_create_autocmd("BufReadPre", {
      pattern = "*.ipynb",
      callback = function(args)
        -- Adjust the extension here to match your jupytext.nvim config
        -- (output_extension / custom_language_formatting), e.g. ".qmd", ".md", ".py"
        local companion = args.file:gsub("%.ipynb$", ".qmd")
        if vim.fn.filereadable(companion) == 0 then
          jupytext_created_files[companion] = true
        end
      end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        for path, _ in pairs(jupytext_created_files) do
          vim.fn.delete(path)
        end
      end,
    })
  end,
  keys = {
    {
      "<Localleader>es",
      function()
        local file_path = vim.fn.expand("%:p")

        vim.notify(file_path)

        vim.fn.system("jupytext --to py:percent " .. file_path)
      end,
      desc = "Export to a script",
    },
  },
}
