return {
  "mrcjkb/rustaceanvim",
  version = "^5", -- Recommended version
  lazy = false, -- Ensure it loads on startup
  ft = { "rust" }, -- Load only for Rust files
  config = function()
    vim.g.rustaceanvim = {
      server = {
        autostart = true,
        on_attach = function(client, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
            diagnostics = { enable = true },
          },
        },
      },
    }
  end,
}
