---@type LazySpec
return {
  "uhs-robert/sshfs.nvim",
  opts = {
    -- Refer to the configuration section below
    -- or leave empty for defaults
    mounts = {
      base_dir = vim.fn.expand("$HOME") .. "/.mnt", -- where remote mounts are created
    },
    host_paths = {
      ["ynez"] = "/home/ColinDoherty/AI/chess-interp/",
    },
  },
}
