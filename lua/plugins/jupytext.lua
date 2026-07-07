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
