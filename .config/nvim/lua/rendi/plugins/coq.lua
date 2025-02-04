return {
  "neovim/nvim-lspconfig", -- REQUIRED: Native Neovim LSP integration
  lazy = false, -- REQUIRED: Start plugin at startup
  dependencies = {
    -- COQ for autocomplete
    { "ms-jpq/coq_nvim", branch = "coq" },
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = true, -- Auto-start COQ
      keymap = {
        recommended = false,
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
    local lsp = require("lspconfig")
    local coq = require("coq")

    -- Utility function to simplify setup
    local function setup_lsp(server, opts)
      opts = opts or {}
      lsp[server].setup(coq.lsp_ensure_capabilities(opts))
    end

    -- Keymap for diagnostics
    local function hide_diagnostics()
      vim.diagnostic.config({
        virtual_text = false,
        signs = false,
        underline = false,
      })
    end
    local function show_diagnostics()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
      })
    end

    vim.keymap.set("n", "<leader>dh", hide_diagnostics)
    vim.keymap.set("n", "<leader>ds", show_diagnostics)

    -- Configure asm_lsp
    setup_lsp("asm_lsp", {
      cmd = { "/home/rendi/.cargo/bin/asm-lsp" },
      filetypes = { "asm", "s", "S" },
      root_dir = lsp.util.root_pattern(".git", "Makefile") or vim.fn.getcwd(),
      autostart = true,
    })

    -- Configure JDTLS (Java)
    local workspace_dir = vim.fn.expand("~/workspace-root/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"))
    setup_lsp("jdtls", {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.expand("~/.config/jdtls-latest/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"),
        "-configuration",
        vim.fn.expand("~/.config/jdtls-latest/config_linux"),
        "-data",
        workspace_dir,
      },
      root_dir = function(fname)
        return lsp.util.root_pattern(".git", "pom.xml", "build.gradle")(fname) or vim.fn.getcwd()
      end,
    })

    -- Configure TypeScript LSP
    setup_lsp("ts_ls", {
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      root_dir = lsp.util.root_pattern("package.json", "tsconfig.json", ".git") or vim.fn.getcwd(),
    })

    -- Configure Tailwind CSS
    setup_lsp("tailwindcss", {
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescriptreact" },
      root_dir = function(fname)
        return lsp.util.root_pattern("tailwind.config.js", ".git")(fname) or vim.fn.getcwd()
      end,
    })

    -- Configure Intelephense (PHP)
    setup_lsp("intelephense", {
      root_dir = function(fname)
        return lsp.util.root_pattern(".git", "composer.json")(fname) or vim.fn.getcwd()
      end,
    })

    -- Configure clangd
    setup_lsp("clangd", {
      root_dir = lsp.util.root_pattern(".git") or vim.fn.getcwd(),
    })

    -- Configure HTML
    setup_lsp("html", {
      root_dir = lsp.util.root_pattern(".git") or vim.fn.getcwd(),
    })

    -- Configure XML
    setup_lsp("lemminx", {
      -- The default configuration for lemminx should work for most users
      settings = {
        xml = {
          -- Enabling or disabling validation
          validate = {
            enable = true, -- You can toggle this based on your needs
          },
        },
      },
      root_dir = function(fname)
        -- This ensures the LSP is initialized for XML files
        return lsp.util.root_pattern(".git", "pom.xml", "build.xml")(fname) or vim.fn.getcwd()
      end,
    })

    -- Configure JSON
    setup_lsp("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
      root_dir = function(fname)
        return lsp.util.root_pattern(".git", "package.json")(fname) or vim.fn.getcwd()
      end,
    })

    -- Configure Emmet
    setup_lsp("emmet_ls", {
      filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
      root_dir = lsp.util.root_pattern(".git") or vim.fn.getcwd(),
    })

    -- Keybindings
    vim.api.nvim_set_keymap("i", "<Esc>", [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-c>", [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<BS>", [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap(
      "i",
      "<Tab>",
      [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
      { expr = true, silent = true }
    )
    vim.api.nvim_set_keymap("i", "<C-n>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-p>", [[pumvisible() ? "\<C-p>" : "\<BS>"]], { expr = true, silent = true })
  end,
}
