return {
  "neovim/nvim-lspconfig", -- REQUIRED: Native Neovim LSP integration
  lazy = false, -- REQUIRED: Start plugin at startup
  dependencies = {
    -- COQ for autocomplete
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
      lsp[server].setup(coq.lsp_ensure_capabilities(opts or {}))
    end

    -- Configure asm_lsp
    setup_lsp("asm_lsp", {
      cmd = { "asm-lsp" },
      filetypes = { "asm", "s", "S" },
      root_dir = function(fname)
        return lsp.util.root_pattern(".git")(fname) or vim.fn.getcwd()
      end,
      settings = {
        asm = {
          enable = true,
        },
      },
    })

    -- Configure jdtls (Java)
    local workspace_dir = vim.fn.expand("~/workspace-root/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"))
    setup_lsp("jdtls", {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.expand("~/Downloads/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"),
        "-configuration",
        vim.fn.expand("~/.config/config_linux"),
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

    -- Configure HTML
    setup_lsp("html", {
      root_dir = lsp.util.root_pattern(".git") or vim.fn.getcwd(),
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
  end,
}
