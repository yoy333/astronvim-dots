local adapter_path = vim.fn.stdpath "data" .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js"

return {
  "mfussenegger/nvim-dap",
  config = function(plugin, opts)
    -- Initialize the base AstroNvim DAP configuration
    -- require("astronvim.plugins.configs.nvim-dap")(plugin, opts)
    require "astronvim.plugins.configs.nvim-dap"()

    local dap = require "dap"

    -- Define the Firefox adapter
    dap.adapters.firefox = {
      type = "executable",
      command = "node",
      args = {
        -- Use stdpath to point to your Mason installation
        adapter_path,
      },
    }

    -- Define TypeScript debugging for Firefox
    dap.configurations.typescript = {
      {
        name = "SRS Debug with Firefox",
        type = "firefox",
        request = "launch",
        reAttach = true,
        url = "http://localhost:5173", -- Match your dev server URL
        webRoot = "${workspaceFolder}/client",
        firefoxExecutable = "/usr/bin/firefox", -- Path to your Firefox binary
      },
    }

    -- Apply the same settings for JavaScript
    dap.configurations.javascript = dap.configurations.typescript
  end,
}
