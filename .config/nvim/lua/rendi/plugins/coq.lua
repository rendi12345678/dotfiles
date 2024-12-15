return {
  "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
  lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
  dependencies = {
    -- main one
    { "ms-jpq/coq_nvim", branch = "coq" },

    -- 9000+ Snippets
    { "ms-jpq/coq.artifacts", branch = "artifacts" },

    -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
    -- Need to **configure separately**
    { 'ms-jpq/coq.thirdparty', branch = "3p" }
    -- - shell repl
    -- - nvim lua api
    -- - scientific calculator
    -- - comment banner
    -- - etc
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = true, -- if you want to start COQ at startup
      keymap = {
        recommended = false,
        bigger_preview = "",
        jump_to_mark = "<c-]>"
      },
      display = {
        statusline = {
          helo = false
        }
      },
    }
  end,
  config = function()
    -- Keybindings
    vim.api.nvim_set_keymap('i', '<Esc>', [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap('i', '<C-c>', [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]], { expr = true, silent = true })
    -- vim.api.nvim_set_keymap('i', '<BS>', [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap(
      "i",
      "<Tab>",
      [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
      { expr = true, silent = true }
    )
    vim.api.nvim_set_keymap('i', '<C-j>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap('i', '<C-k>', [[pumvisible() ? "\<C-p>" : "\<BS>"]], { expr = true, silent = true })

    -- Lsp config
    local lsp = require("lspconfig");
    local coq = require("coq");

    lsp.ts_ls.setup(coq.lsp_ensure_capabilities{})
    lsp.asm_lsp.setup(coq.lsp_ensure_capabilities{})
    lsp.tailwindcss.setup(coq.lsp_ensure_capabilities{})
    lsp.intelephense.setup(coq.lsp_ensure_capabilities{})
    lsp.html.setup(coq.lsp_ensure_capabilities{})
    lsp.phpactor.setup(coq.lsp_ensure_capabilities{})
    lsp.emmet_ls.setup(coq.lsp_ensure_capabilities{})
    lsp.jsonls.setup(coq.lsp_ensure_capabilities{})
    -- lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities{
    --   settings = {
    --     ["rust-analyzer"] = {
    --       cargo = {
    --         allFeatures = true,
    --       },
    --       checkOnSave = {
    --         command = "clippy",
    --       },
    --     },
    --   },})
  end,
}
