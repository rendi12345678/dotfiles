return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",  -- Ensure this is installed for autotag functionality
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- Configure blade parser for nvim-treesitter
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "phtml",
    }

    vim.filetype.add({
      pattern = {
        [".*%.blade%.php"] = "phtml",
      },
    })

    -- configure treesitter
    treesitter.setup({
      -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json", "javascript", "typescript", "tsx", "asm", "yaml", "html", "css",
        "prisma", "python", "markdown", "markdown_inline", "graphql", "php", "bash",
        "lua", "vim", "dockerfile", "gitignore", "query", "vimdoc", "c", "rust",
      },
      -- incremental selection configuration
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
