-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
    },
    -- query_linter = {
    --   enable = true,
    --   use_virtual_text = true,
    --   lint_events = { "BufWrite", "CursorHold" },
    -- },
  },
}
