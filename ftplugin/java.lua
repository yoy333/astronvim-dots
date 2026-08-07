vim.notify("ft plugin: java")

local ok, jdtls = pcall(require, "jdtls")
if not ok then
  vim.notify(
    "nvim-jdtls not available: " .. tostring(jdtls),
    vim.log.levels.WARN
  )
  return
end

local jdtls = require("jdtls")

local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = jdtls.setup.find_root(root_markers)
if not root_dir then return end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data")
  .. "/jdtls-workspace/"
  .. project_name

local config = {
  cmd = {
    vim.fn.exepath("jdtls"),
    "-data",
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      import = {
        gradle = {
          enabled = true,
          wrapper = { enabled = true },
        },
      },
      configuration = {
        updateBuildConfiguration = "automatic",
      },
    },
  },
}

jdtls.start_or_attach(config)

vim.keymap.set(
  "n",
  "<leader>sju",
  "<cmd>JdtUpdateConfig<cr>",
  { desc = "Update JDTLS config", buffer = 0 }
)
