return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        rust = { "rustfmt" },
        css = { "prettier" },
        php = { "pint" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        blade = { "blade-formatter" },  -- Make sure you have blade-formatter installed
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },  -- Use stylua for Lua formatting
        python = { "black" },  -- Use black for Python formatting
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
