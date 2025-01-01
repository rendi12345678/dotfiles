return {
  "neovim/nvim-lspconfig", -- REQUIRED: Native Neovim LSP integration
  lazy = false, -- REQUIRED: Start plugin at startup
  dependencies = {
    -- COQ
    { "ms-jpq/coq_nvim", branch = "coq" },
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
    { "mfussenegger/nvim-jdtls" },
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = true, -- Auto-start COQ
      keymap = {
        recommended = false,
        bigger_preview = "",
        jump_to_mark = "<c-]>",
      },
      display = {
        statusline = {
          helo = false,
        },
      },
    }
  end,
  config = function()
    -- Keybindings
    vim.api.nvim_set_keymap("i", "<Esc>", [[pumvisible() ? "\<C-e><Esc>" : "<Esc>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-c>", [[pumvisible() ? "\<C-e><C-c>" : "<C-c>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap(
      "i",
      "<Tab>",
      [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "<Tab>"]],
      { expr = true, silent = true }
    )
    vim.api.nvim_set_keymap("i", "<C-j>", [[pumvisible() ? "\<C-n>" : "<Tab>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-k>", [[pumvisible() ? "\<C-p>" : "<BS>"]], { expr = true, silent = true })

    -- LSP and COQ integration
    local lsp = require("lspconfig")
    local coq = require("coq")

    local jdtls_config = {
      cmd = { "java" },
      root_dir = function(fname)
        return require("lspconfig").util.root_pattern("pom.xml", "build.gradle", ".git")(fname) or vim.fn.getcwd()
      end,
    }

    lsp.jdtls.setup(coq.lsp_ensure_capabilities(jdtls_config))
    lsp.ts_ls.setup(coq.lsp_ensure_capabilities({}))
    lsp.asm_lsp.setup(coq.lsp_ensure_capabilities({}))
    lsp.tailwindcss.setup(coq.lsp_ensure_capabilities({}))
    lsp.intelephense.setup(coq.lsp_ensure_capabilities({}))
    lsp.html.setup(coq.lsp_ensure_capabilities({}))
    lsp.jsonls.setup(coq.lsp_ensure_capabilities({}))
    lsp.emmet_ls.setup(coq.lsp_ensure_capabilities({}))
  end,
}
