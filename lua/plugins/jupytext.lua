return {
  "GCBallesteros/jupytext.nvim",
  lazy = false,
  config = function()
    require("jupytext").setup({
      style = "hydrogen",
      output_extension = "auto",
      -- force_ft = "python",
    })
  end,
}
