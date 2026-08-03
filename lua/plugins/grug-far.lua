return {
  "MagicDuck/grug-far.nvim",
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  lazy = true,
  cmd = { "GrugFar" },
  config = function()
    -- optional setup call to override plugin options
    -- alternatively you can set options with vim.g.grug_far = { ... }
    require("grug-far").setup({
      -- options, see Configuration section below
      -- there are no required options atm
    })
  end,
  keys = {
    { "<Leader>sf", desc = "GrugFar" },
    {
      "<Leader>sfb",
      function()
        vim.notify(vim.fn.expand("%"))
        require("grug-far").open({
          prefills = {
            paths = vim.fn.expand("%"), -- Targets the current active buffer file
          },
        })
      end,
      desc = "Find & Replace in buffer",
    },
    {
      "<Leader>sfp",
      "<cmd>GrugFarWithin<cr>",
      desc = "Find & Replace",
    },
  },
}
